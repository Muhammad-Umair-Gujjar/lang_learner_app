
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/custom_lesson_quiz_appBar.dart';
import 'package:provider/provider.dart';
import '../../../provider/lesson_provider.dart';
import '../../../provider/user_progres_provider.dart';
import 'lesson_screen.dart';
extension StringCasingExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}
class ChapterListScreen extends StatelessWidget {
  final String language;
  final String proficiency;
  final VoidCallback? onBackPressed;

  const ChapterListScreen({
    required this.language,
    required this.proficiency, this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomLessonQuizAppbar(title: '${proficiency.capitalize()} ${language.capitalize()} - Chapters',onBackPressed: onBackPressed,),
      body: Consumer2<LessonProvider, UserProgress>(
          builder: (context, lessonProvider, userProgress, _) {
            return StreamBuilder<QuerySnapshot>(
              stream:  lessonProvider.getChapters(language,proficiency),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final chapter = snapshot.data!.docs[index];
                    return ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                          backgroundColor: Provider.of<UserProgress>(context)
                              .isLessonCompleted(chapter.id)
                              ? Colors.green
                              : Colors.grey,
                        ),
                        title: Text(chapter['name']),
                        subtitle: Text("total lessons ${chapter['totalLessons']}"),
                        onTap: () async {
                          final chapterId = chapter.id;
                            final lessonId =await  lessonProvider.getFirstLessonId(language: language, proficiency: proficiency, chapterId: chapterId);
                            if (lessonId != null){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LessonScreen(
                                  language: language,
                                  proficiency: proficiency,
                                  chapterId: chapterId,
                                  lessonId: lessonId,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('No lessons found in this chapter.')),
                            );
                          }
                        }
                    );
                  },
                );
              },
            );
          }
      )
    );
  }
}