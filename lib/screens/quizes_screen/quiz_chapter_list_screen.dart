import 'package:flutter/material.dart';
import 'package:flutter_project/screens/quizes_screen/quiz_screen.dart';
import 'package:flutter_project/widgets/custom_lesson_quiz_appBar.dart';
import 'package:provider/provider.dart';

import '../../provider/quiz_provider.dart';
class QuizChapterListScreen extends StatefulWidget {
  final String language;
  final String proficiency;

  const QuizChapterListScreen({
    Key? key,
    required this.language,
    required this.proficiency,
  }) : super(key: key);

  @override
  State<QuizChapterListScreen> createState() => _QuizChapterListScreenState();
}

class _QuizChapterListScreenState extends State<QuizChapterListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuizProvider>(context, listen: false)
          .fetchChapters(widget.language, widget.proficiency);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomLessonQuizAppbar(title: '${widget.proficiency} Chapters'),
      body: Consumer<QuizProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }

          if (provider.chapters.isEmpty) {
            return Center(child: Text('No chapters available'));
          }

          return ListView.builder(
            itemCount: provider.chapters.length,
            itemBuilder: (context, index) {
              final chapter = provider.chapters[index];
              final title = chapter['title'];
              final order = chapter['order'];

              return ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                  backgroundColor: Colors.grey,
                ),
                title: Text(title),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizScreen(
                        language: widget.language,
                        proficiency: widget.proficiency,
                        chapterId: chapter.id,
                        chapterTitle: title,
                        chapterOrder: order,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
