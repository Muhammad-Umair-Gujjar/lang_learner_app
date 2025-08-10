import 'package:flutter/material.dart';
import 'package:flutter_project/provider/profile_provider.dart';
import 'package:provider/provider.dart';

import '../../../animated_components/animated_circular_progress_indicator.dart';
import '../../../core/constants.dart';
import '../../../provider/user_progres_provider.dart';
import '../lesson_screen/chapter_list_screen.dart';
import '../lesson_screen/lesson_screen.dart';
import '../lesson_screen/proficiency_selection_screen.dart';

class LessonProgressCard extends StatelessWidget {

  const LessonProgressCard({super.key,});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child:  Row(
          children: [
            Expanded(flex: 2, child: _buildLessonInfo(context)),
            const SizedBox(width: 30),
            Expanded(child: _buildProgressIndicator(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer<UserProgress>(
          builder: (context, progress, _) {
            final isFirstTimeUser = progress.completedLessons.isEmpty;
            return Text(
              isFirstTimeUser ? "Start Learning" : "Continue Learning",
              style: Theme.of(context).textTheme.titleMedium,
            );
          },
        ),
        const SizedBox(height: 8),
        _buildLessonSubtitle(context),
        const SizedBox(height: 12),
        _buildActionButton(context),
      ],
    );
  }

  Widget _buildLessonSubtitle(BuildContext context) {
    return Consumer2<UserProgress, ProfileProvider>(
      builder: (context, progress, profile, _) {
        final isFirstTimeUser = progress.completedLessons.isEmpty;
        return Text(
          isFirstTimeUser
              ? "Begin your ${profile.currentLanguage} journey!"
              : "Next: ${progress.nextLessonTitle}",
          style: Theme.of(context).textTheme.bodyMedium,
        );
      },
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return
      Consumer<UserProgress>(
          builder: (context, progress, _) {
            final isFirstTimeUser = progress.completedLessons.isEmpty;
            return ElevatedButton(
              onPressed: () => _handleLessonNavigation(context),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                backgroundColor: primaryRed,
                foregroundColor: Colors.white,
              ),
              child: Text(isFirstTimeUser ? "Start Lesson" : "Resume"),
            );
          }
      );
  }

  void _handleLessonNavigation(BuildContext context) {
    final progress = context.read<UserProgress>();
    final profile = context.read<ProfileProvider>();
    final fullLessonId = progress.nextLessonId;
    final language = profile.currentLanguage.toLowerCase();

    if (fullLessonId == null || fullLessonId.isEmpty || progress.currentProficiency == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProficiencySelectionScreen(language: language),
        ),
      );
      return;
    }

    try {
      final parts = fullLessonId.split('_');
      if (parts.length < 3) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProficiencySelectionScreen(language: language),
          ),
        );
        return;
      }

      final chapterId = parts.first;
      final lessonId = '${parts[1]}_${parts[2]}';

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LessonScreen(
            language: language,
            proficiency: progress.currentProficiency!,
            chapterId: chapterId,
            lessonId: lessonId,
            onBackPressed: () => _handleBackNavigation(context, language, progress),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not resume lesson')),
      );
    }
  }

  void _handleBackNavigation(
    BuildContext context,
    String language,
    UserProgress progress,
  ) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ChapterListScreen(
          language: language,
          proficiency: progress.currentProficiency!,
          onBackPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => ProficiencySelectionScreen(language: language),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(BuildContext context) {
    return Consumer2<UserProgress, ProfileProvider>(
      builder: (context, progress, profile, _) {
        return AnimatedCircularProgressIndicator(
          label: profile.currentLanguage,
          percentage: progress.completionPercentage,
        );
      },
    );
  }
}
