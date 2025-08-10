import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/widgets/custom_lesson_quiz_appBar.dart';
import 'package:provider/provider.dart';
import '../../../provider/lesson_provider.dart';
import 'chapter_list_screen.dart';
extension StringCasingExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1).toLowerCase();
  }
}

class ProficiencySelectionScreen extends StatelessWidget {
  final VoidCallback? onBackPressed;
  final String language;

  const ProficiencySelectionScreen({required this.language, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    final lessonProvider = context.watch<LessonProvider>();
    return Scaffold(
      appBar: CustomLessonQuizAppbar(title: 'Select Level for ${StringCasingExtension(language).capitalize()}',onBackPressed: onBackPressed),
      body: StreamBuilder<QuerySnapshot>(
        stream: lessonProvider.getProficiencies(language),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No proficiency levels found'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final proficiency = snapshot.data!.docs[index];
              return ListTile(
                title: Text(proficiency['name']),
                subtitle: Text('${proficiency['totalLessons']} lessons'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChapterListScreen(
                      language: language,
                      proficiency: proficiency.id,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
