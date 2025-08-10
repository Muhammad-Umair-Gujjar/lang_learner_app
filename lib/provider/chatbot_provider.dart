import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({required this.text, required this.isUser, required this.timestamp});
}

class ChatBotProvider with ChangeNotifier {
  final List<ChatMessage> _messages = [];
  final TextEditingController textController = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();

  bool _isTyping = false;
  bool get isTyping => _isTyping;
  List<ChatMessage> get messages => _messages;

  ChatBotProvider() {
    _addWelcomeMessage();
  }

  void _addWelcomeMessage() {
    _messages.add(ChatMessage(
      text: "Hello! I'm your language tutor. What would you like to practice today?",
      isUser: false,
      timestamp: DateTime.now(),
    ));
  }

  String _detectLanguage(String text) {
    text = text.trim();

    if (RegExp(r'[\u0600-\u06FF]').hasMatch(text)) return 'ur-PK';
    if (RegExp(r'[\u0370-\u03FF]').hasMatch(text)) return 'el-GR';
    if (RegExp(r'[¿¡áéíóúñ]').hasMatch(text)) return 'es-ES';
    if (RegExp(r'[àâçéèêëîïôûùüÿœæ]').hasMatch(text)) return 'fr-FR';
    if (RegExp(r'[àèéìòù]').hasMatch(text)) return 'it-IT';

    return 'en-US';
  }

  Future<void> speak(String fullText) async {
    await _flutterTts.stop();

    final match = RegExp(r'\((.*?)\)').firstMatch(fullText);
    final translation = match?.group(1)?.trim();
    final textToSpeak = translation ?? fullText;

    String lang = _detectLanguage(textToSpeak);
    await _flutterTts.setLanguage(lang);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(textToSpeak);
  }

  Future<void> sendMessage() async {
    if (textController.text.isEmpty) return;

    final userMessage = ChatMessage(
      text: textController.text,
      isUser: true,
      timestamp: DateTime.now(),
    );

    _messages.add(userMessage);
    _isTyping = true;
    notifyListeners();

    final response = await _callGroqAPI(textController.text);
    textController.clear();

    _messages.add(ChatMessage(
      text: response,
      isUser: false,
      timestamp: DateTime.now(),
    ));
    _isTyping = false;
    notifyListeners();
  }

  Future<String> _callGroqAPI(String prompt) async {
    try {
      final apiKey = dotenv.env['GROQ_API_KEY'];
      final url = Uri.parse('https://api.groq.com/openai/v1/chat/completions');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          "model": "llama-3.3-70b-versatile",
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
}
