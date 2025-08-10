import 'package:flutter/material.dart';
import 'package:flutter_project/screens/home_screen/components/Lesson_progress_card.dart';
import 'package:provider/provider.dart';
import '../../core/constants.dart';
import '../../provider/profile_provider.dart';
import '../../provider/user_progres_provider.dart';
import 'components/home_header.dart';
import 'components/quick_access_grid.dart';
import 'components/streak_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _lastLanguage;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final profile = Provider.of<ProfileProvider>(context);
    final currentLanguage = profile.currentLanguage.toLowerCase();

    if (_lastLanguage != currentLanguage) {
      _lastLanguage = currentLanguage;

      Provider.of<UserProgress>(context, listen: false)
          .initializeProgress(currentLanguage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: screenHeight<740 ? 6 :5, child: const HomeHeader()),
          Expanded(
            flex: 10,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LessonProgressCard(),
                    SizedBox(height: defaultPadding),
                    const StreakCard(),
                    SizedBox(height: defaultPadding),
                    Text("Quick Access", style: Theme.of(context).textTheme.titleLarge),
                    const QuickAccessGrid(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}