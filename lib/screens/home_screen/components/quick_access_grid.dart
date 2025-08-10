import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants.dart';
import '../../../provider/profile_provider.dart';
import '../../quizes_screen/quiz_proficiency_screen.dart';
import '../lesson_screen/proficiency_selection_screen.dart';
class QuickAccessGrid extends StatelessWidget {
  const QuickAccessGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 1.5,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: _buildGridItems(context),
    );
  }

  List<Widget> _buildGridItems(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    final language = profileProvider.currentLanguage.toLowerCase();
    final items = [
      _GridItem(
        icon: Icons.book,
        label: "Vocabulary",
        onTap: () => _navigateTo(context, ProficiencySelectionScreen(language: language)),),
        _GridItem(
            icon: Icons.quiz,
            label: "Quiz",
            onTap: () => _navigateTo(context, QuizProficiencyScreen(language: language))),
        _GridItem(
            icon: Icons.chat,
            label: "Phrases",
            onTap: () => _navigateTo(context, ProficiencySelectionScreen(language: language))),
        _GridItem(
            icon: Icons.auto_stories,
            label: "Grammar",
            onTap: () => _navigateTo(context, ProficiencySelectionScreen(language: language))),
        ];

        return items.map((item) => _buildGridCard(item)).toList();
  }

  Widget _buildGridCard(_GridItem item) {
    return Card(
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 32, color: mediumPink),
            const SizedBox(height: 8),
            Text(item.label),
          ],
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }
}

class _GridItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  _GridItem({required this.icon, required this.label, required this.onTap});
}