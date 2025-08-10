import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../../core/constants.dart';
import '../../../provider/quiz_provider.dart';

class QuizQuestionWidget extends StatelessWidget {

  final QueryDocumentSnapshot question;
  final Future<void> Function(int score)? onCorrectAnswer;

  const QuizQuestionWidget({super.key, required this.question, this.onCorrectAnswer});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<QuizProvider>(context);

    final data = question.data() as Map<String, dynamic>;
    final type = data['type'];
    final correctAnswer = data['correctAnswer'];
    final questionText = data['question'] as Map<String, dynamic>;

    if (type == 'matching' && provider.correctMatches.isEmpty) {
      provider.setCorrectMatches(Map<String, String>.from(data['pairs']));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(questionText['english'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(questionText['italian'], style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
          const SizedBox(height: 24),

          if (type == 'mcq') ..._buildMCQ(context, data['options'], correctAnswer),
          if (type == 'fill_blank') _buildFillInBlank(context, correctAnswer),
          if (type == 'matching') _buildMatching(context, data['pairs']),

          const SizedBox(height: 20),

          _buildAnswerRevealSection(context, type, correctAnswer),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: provider.toggleShowAnswer,
                child: Text(
                  provider.showAnswer ? 'Hide Answer' : 'Show Answer',
                  style: TextStyle(color: primaryRed),
                ),
              ),
              ElevatedButton(
                onPressed: (type == 'matching' && provider.answerChecked) ? null : () async {
                  provider.checkAnswer();

                  if (provider.isCorrect && onCorrectAnswer != null) {
                  final score = provider.calculateScore();
                  await onCorrectAnswer!(score);
                  }
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey,
                ),
                child: const Text('Check Answer'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMCQ(BuildContext context, List options, String correctAnswer) {
    final provider = Provider.of<QuizProvider>(context);

    return options.map<Widget>((option) {
      final isSelected = provider.selectedOption == option;
      final isCorrectOption = option == correctAnswer;

      Color? textColor = Colors.black;
      Color? tileColor = Colors.transparent;

      if (provider.answerChecked) {
        if (isSelected && !isCorrectOption) {
          textColor = Colors.red;
          tileColor = Colors.red[50];
        } else if (isCorrectOption) {
          textColor = Colors.green;
          tileColor = Colors.green[50];
        }
      }

      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? primaryRed : Colors.grey[300]!),
        ),
        child: RadioListTile<String>(
          title: Text(option, style: TextStyle(color: textColor)),
          value: option,
          groupValue: provider.selectedOption,
          onChanged: provider.answerChecked ? null : provider.updateSelectedOption,
          activeColor: primaryRed,
        ),
      );
    }).toList();
  }

  Widget _buildFillInBlank(BuildContext context, String correctAnswer) {
    final provider = Provider.of<QuizProvider>(context);

    return TextField(
      decoration: InputDecoration(
        hintText: 'Type your answer',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: provider.answerChecked && !provider.isCorrect ? Colors.red : Colors.grey,
            width: 2.0,
          ),
        ),
        suffixIcon: provider.answerChecked
            ? Icon(provider.isCorrect ? Icons.check : Icons.close,
            color: provider.isCorrect ? Colors.green : Colors.red)
            : null,
        errorText: provider.answerChecked && !provider.isCorrect ? 'Incorrect, try again' : null,
      ),
      onChanged: provider.updateFillBlankAnswer,
      readOnly: provider.answerChecked && provider.isCorrect,
    );
  }

  Widget _buildMatching(BuildContext context, Map pairs) {
    final provider = Provider.of<QuizProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Match the following:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...pairs.keys.map<Widget>((key) {
          final isCorrect = provider.answerChecked &&
              provider.selectedMatches[key] == provider.correctMatches[key];
          final isIncorrect = provider.answerChecked &&
              provider.selectedMatches[key] != null &&
              provider.selectedMatches[key] != provider.correctMatches[key];

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: isCorrect ? Colors.green[50] : isIncorrect ? Colors.red[50] : null,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isCorrect ? Colors.green : isIncorrect ? Colors.red : Colors.grey,
              ),
            ),
            child: ListTile(
              title: Text(key),
              trailing: DropdownButton<String>(
                hint: const Text('Select match'),
                value: provider.selectedMatches[key],
                items: provider.correctMatches.values
                    .toSet()
                    .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                    .toList(),
                onChanged: (value) {
                  provider.updateSelectedMatch(key, value);
                },
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildAnswerRevealSection(BuildContext context, String type, dynamic correctAnswer) {
    final provider = Provider.of<QuizProvider>(context);

    if (type == 'matching' && provider.answerChecked) {
      return Column(
        children: [
          Text(
            'Score: ${provider.selectedMatches.entries.where((e) => e.value == provider.correctMatches[e.key]).length} '
                'out of ${provider.correctMatches.length}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          if (provider.showAnswer)
            ...provider.correctMatches.entries.map((entry) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text('${entry.key} = ${entry.value}',
                  style: const TextStyle(color: Colors.green)),
            )),
        ],
      );
    }

    if (provider.showAnswer && type != 'matching') {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Correct Answer:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(correctAnswer.toString()),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
