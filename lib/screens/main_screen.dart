
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/chatBot_tutor/chatbot_screen.dart';
import 'package:flutter_project/screens/home_screen/home_screen.dart';
import 'package:flutter_project/screens/profile_screen/profile.dart';
import 'package:flutter_project/screens/quizes_screen/quiz_proficiency_screen.dart';
import 'package:provider/provider.dart';
import '../provider/profile_provider.dart';
import '../widgets/custom_bottom_nav.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Consumer<ProfileProvider>(
          builder: (context, profile, _) {
            final language = profile.currentLanguage.toLowerCase();

            final List<Widget> _pages = [
              const HomeScreen(),
              QuizProficiencyScreen(language: language),
              ChatBotScreen(),
              const ProfileScreen(),
            ];

            return AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: _pages[_selectedIndex],
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                }
            );
          }
      ),

      bottomNavigationBar: CustomBottomNav(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
          _selectedIndex = index;
          });
          },
      ),
    );
  }
}



