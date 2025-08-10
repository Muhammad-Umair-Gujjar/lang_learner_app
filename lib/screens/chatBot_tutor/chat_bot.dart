
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../core/constants.dart';

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final FlutterTts _flutterTts = FlutterTts();

  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _addWelcomeMessage();
  }

  String _detectLanguage(String text) {
    text = text.trim();

    // Urdu: Arabic script
    if (RegExp(r'[\u0600-\u06FF]').hasMatch(text)) {
      return 'ur-PK';
    }

    // Greek: Unicode Greek characters
    if (RegExp(r'[\u0370-\u03FF]').hasMatch(text)) {
      return 'el-GR';
    }

    // Spanish: Contains upside-down ?/!, ñ, accented vowels
    if (RegExp(r'[¿¡áéíóúñ]').hasMatch(text)) {
      return 'es-ES';
    }

    // French: Contains accents and œ, ç, etc.
    if (RegExp(r'[àâçéèêëîïôûùüÿœæ]').hasMatch(text)) {
      return 'fr-FR';
    }

    // Italian: Accented vowels commonly used in Italian
    if (RegExp(r'[àèéìòù]').hasMatch(text)) {
      return 'it-IT';
    }

    // Default: English
    return 'en-US';
  }

  Future<void> _speak(String fullText) async {
    await _flutterTts.stop(); // Stop any ongoing speech

    // Extract translation in parentheses e.g., "Hola (Hello)"
    final RegExp regExp = RegExp(r'\((.*?)\)');
    final match = regExp.firstMatch(fullText);
    final translation = match?.group(1)?.trim();

    // Fallback if no translation found
    final textToSpeak = translation ?? fullText;

    // Auto-detect language (basic heuristic)
    String lang = _detectLanguage(textToSpeak);

    await _flutterTts.setLanguage(lang);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(textToSpeak);
  }


  void _addWelcomeMessage() {
    _messages.add(ChatMessage(
      text: "Hello! I'm your language tutor. What would you like to practice today?",
      isUser: false,
      timestamp: DateTime.now(),
    ));
  }

  Future<void> _sendMessage() async {
    if (_textController.text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: _textController.text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _isTyping = true;
    });

    final response = await _callGroqAPI(_textController.text);
    _textController.clear();

    setState(() {
      _messages.add(ChatMessage(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      ));
      _isTyping = false;
    });
  }

  // Future<String> _callGPT4(String prompt) async {
  //   // Replace with your actual API call
  //   final apiKey = dotenv.env['OPENAI_API_KEY'];
  //   final url = Uri.parse('https://api.openai.com/v1/chat/completions');
  //
  //   final response = await http.post(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $apiKey',
  //     },
  //     body: jsonEncode({
  //       "model": "gpt-4",
  //       "messages": [
  //         {
  //           "role": "system",
  //           "content": "You're a friendly language tutor. Respond in the target language first, then provide English translation in parentheses."
  //         },
  //         {"role": "user", "content": prompt}
  //       ],
  //       "temperature": 0.7
  //     }),
  //   );
  //
  //   final data = jsonDecode(response.body);
  //   return data['choices'][0]['message']['content'];
  // }
  // Future<String> _callGPT4(String prompt) async {
  //   try {
  //     final apiKey = dotenv.env['OPENAI_API_KEY'];
  //     if (apiKey == null || apiKey.isEmpty) {
  //       return "Error: OpenAI API key not configured";
  //     }
  //
  //     final url = Uri.parse('https://api.openai.com/v1/chat/completions');
  //
  //     final response = await http.post(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $apiKey',
  //       },
  //       body: jsonEncode({
  //         "model": "gpt-3.5-turbo",
  //         "messages": [
  //           {
  //             "role": "system",
  //             "content": "You're a friendly language tutor. Respond in the target language first, then provide English translation in parentheses."
  //           },
  //           {"role": "user", "content": prompt}
  //         ],
  //         "temperature": 0.7
  //       }),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       if (data['choices'] != null && data['choices'].isNotEmpty) {
  //         return data['choices'][0]['message']['content'] ?? "No response content";
  //       }
  //       return "Error: No choices in response";
  //     } else {
  //       return "Error: ${response.statusCode} - ${response.body}";
  //     }
  //   } catch (e) {
  //     return "Error: ${e.toString()}";
  //   }
  // }

  Future<String> _callGroqAPI(String prompt) async {
    try {
      final apiKey = dotenv.env['GROQ_API_KEY']; // Store in .env
      final url = Uri.parse('https://api.groq.com/openai/v1/chat/completions');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "llama-3.3-70b-versatile",  // Free & fast
          "messages": [
            {
              "role": "system",
              "content": "You're a friendly language tutor. Respond first in the target language, then provide English translation.",
            },
            {"role": "user", "content": prompt}
          ],
          "temperature": 0.7,
          "max_tokens": 1024,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'];
      } else {
        return "Error: ${response.statusCode} - ${response.body}";
      }
    } catch (e) {
      return "Error: ${e.toString()}";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryRed,
        title: Text("Language Tutor",style: TextStyle(
          color: Colors.white
        ),),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),

          // Typing Indicator
          if (_isTyping)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  SizedBox(width: 16),
                  _buildTypingIndicator(),
                  Text("Tutor is typing..."),
                ],
              ),
            ),

          // Input Area
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(

                      hintText: "Type your message...",
                      prefixIcon: Icon(Icons.text_fields,color: primaryRed,),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffE4E7EB)),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffE4E7EB)),
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),

                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                SizedBox(width: 5,),
                Container(
                  decoration: BoxDecoration(
                    color: primaryRed,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send,color: Colors.white,),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: message.isUser
                ? Theme.of(context).primaryColor
                : Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.text,
                style: TextStyle(
                  color: message.isUser ? Colors.white : null,
                ),
              ),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      fontSize: 10,
                      color: message.isUser ? Colors.white70 : Colors.grey,
                    ),
                  ),
                  if (!message.isUser)
                    IconButton(
                      icon: Icon(Icons.volume_up, color: Colors.black54, size: 20),
                      onPressed: () => _speak(message.text),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      width: 40,
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTypingDot(0),
          _buildTypingDot(200),
          _buildTypingDot(400),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int delay) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
      margin: EdgeInsets.all(2),
      curve: Curves.easeInOut,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: Duration(milliseconds: 1000),
        builder: (_, value, __) {
          return Opacity(
            opacity: value,
            child: SizedBox(),
          );
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}
