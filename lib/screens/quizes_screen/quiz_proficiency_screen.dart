import 'package:flutter/material.dart';
import 'package:flutter_project/screens/quizes_screen/quiz_chapter_list_screen.dart';
import 'package:flutter_project/widgets/custom_lesson_quiz_appBar.dart';
import 'package:provider/provider.dart';

import '../../provider/quiz_provider.dart';
class QuizProficiencyScreen extends StatefulWidget {
  final String language;

  const QuizProficiencyScreen({Key? key, required this.language}) : super(key: key);

  @override
  State<QuizProficiencyScreen> createState() => _QuizProficiencyScreenState();
}

class _QuizProficiencyScreenState extends State<QuizProficiencyScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<QuizProvider>(context, listen: false)
          .fetchProficiencyLevels(widget.language);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomLessonQuizAppbar(title: 'Select Proficiency Level'),
      body: Consumer<QuizProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(child: Text(provider.error!));
          }

          if (provider.proficiencyLevels.isEmpty) {
            return Center(child: Text('No proficiency levels found'));
          }

          return ListView.builder(
            itemCount: provider.proficiencyLevels.length,
            itemBuilder: (context, index) {
              final level = provider.proficiencyLevels[index];
              final levelId = level.id;
              final levelName = level['name'];

              return ListTile(
                title: Text(levelName),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizChapterListScreen(
                        language: widget.language,
                        proficiency: levelId,
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
