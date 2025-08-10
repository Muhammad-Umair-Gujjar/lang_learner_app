
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/core/constants.dart';
import '../../provider/quiz_provider.dart';
import '../../provider/user_progres_provider.dart';
import '../../widgets/custom_lesson_quiz_appBar.dart';
import 'components/quiz_question_widget.dart';

class QuizScreen extends StatefulWidget {
  final String language;
  final String proficiency;
  final String chapterId;
  final String chapterTitle;
  final int chapterOrder;

  const QuizScreen({
    required this.language,
    required this.proficiency,
    required this.chapterId,
    required this.chapterTitle,
    required this.chapterOrder,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<QuizProvider>(context, listen: false).loadQuestions(
      language: widget.language,
      proficiency: widget.proficiency,
      chapterId: widget.chapterId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomLessonQuizAppbar(title: widget.chapterTitle),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, _) {
          if (quizProvider.questions.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final question = quizProvider.questions[quizProvider.currentIndex];

          return Column(
            children: [
              LinearProgressIndicator(
                value:
                    (quizProvider.currentIndex + 1) /
                    quizProvider.questions.length,
                color: Colors.green,
              ),
              Expanded(child: QuizQuestionWidget(question: question,onCorrectAnswer: (score) async {
                final quizId = '${widget.chapterId}_quiz_${quizProvider.currentIndex + 1}';

                await Provider.of<UserProgress>(context, listen: false).completeQuiz(
                  language: widget.language,
                  chapterId: widget.chapterId,
                  quizId: quizId,
                  score: score,
                );

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Correct! +$score XP')),
                );
              },)),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        if (quizProvider.currentIndex > 0) {
                          quizProvider.previousQuestion();
                        } else {
                          final previousChapter = await quizProvider
                              .loadPreviousChapter(
                                language: widget.language,
                                proficiency: widget.proficiency,
                                currentChapterOrder: widget.chapterOrder,
                              );

                          if (previousChapter != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuizScreen(
                                  language: widget.language,
                                  proficiency: widget.proficiency,
                                  chapterId: previousChapter.id,
                                  chapterTitle: previousChapter['title'],
                                  chapterOrder: previousChapter['order'],
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('This is the first chapter.'),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text('Previous',style: TextStyle(color: primaryRed),),
                    ),
                    Text(
                      'Question ${quizProvider.currentIndex + 1} of ${quizProvider.questions.length}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: quizProvider.isLastQuestion
                          ? () async {
                              final nextChapter = await quizProvider
                                  .loadNextChapter(
                                    language: widget.language,
                                    proficiency: widget.proficiency,
                                    currentChapterOrder: widget.chapterOrder,
                                  );

                              if (nextChapter != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QuizScreen(
                                      language: widget.language,
                                      proficiency: widget.proficiency,
                                      chapterId: nextChapter.id,
                                      chapterTitle: nextChapter['title'],
                                      chapterOrder: nextChapter['order'],
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'You completed all chapters!',
                                    ),
                                  ),
                                );
                                Navigator.pop(context);
                              }
                            }
                          : quizProvider.nextQuestion,
                      child: Text(
                        quizProvider.isLastQuestion ? 'Next Chapter' : 'Next',style: TextStyle(color: primaryRed),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
