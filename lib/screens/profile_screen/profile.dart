
import 'package:flutter/material.dart';
import 'package:flutter_project/provider/streak_provider.dart';
import 'package:provider/provider.dart';
import '../../core/constants.dart';
import '../../provider/auth_provider.dart';
import '../../provider/profile_provider.dart';
import '../../provider/user_progres_provider.dart';
import '../auth_screens/login_screen.dart';
import 'components/language_selection_component.dart';
import 'components/profile_header.dart';
import 'components/stat_item.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileHeader(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildLanguageSection(context),
                  const SizedBox(height: 20),
                  _buildStatsSection(),
                  const SizedBox(height: 20),
                  _buildAccountActions(),
                  const SizedBox(height: 30),
                  _buildSignOutButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSection(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profile, _) {
        return LanguageSelectionCard(
          currentLanguage: profile.currentLanguage,
          availableLanguages: availableLanguages,
        );
      },
    );
  }

  Widget _buildStatsSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Stats',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryDark,
              ),
            ),
            const SizedBox(height: 16),
            Consumer2<UserProgress, StreakProvider>(
              builder: (context, progress,streak, _) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StatItem(
                      title: 'Lessons\nCompleted',
                      value: progress.completedLessons.length.toString(),
                      icon: Icons.check_circle,
                    ),
                    StatItem(
                      title: 'Quiz\nCompleted',
                      value: progress.completedQuizzes.length.toString(),
                      icon: Icons.library_books,
                    ),
                    StatItem(
                      title: 'Current\nStreak',
                      value: streak.currentStreak.toString(),
                      icon: Icons.local_fire_department,
                    ),
                  ],
                );
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountActions() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.switch_account, color: primaryRed),
            title: Text(
              'Switch Account',
              style: TextStyle(color: primaryDark),
            ),
            trailing: Icon(Icons.chevron_right, color: primaryDark),
            onTap: () {},
          ),
          const Divider(height: 1),
          ListTile(
            leading: Icon(Icons.settings, color: primaryRed),
            title: Text(
              'Settings',
              style: TextStyle(color: primaryDark),
            ),
            trailing: Icon(Icons.chevron_right, color: primaryDark),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSignOutButton(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryRed,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () => _showSignOutConfirmation(context, authProvider),
        child: const Text(
          'Sign Out',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  Future<void> _performSignOut(BuildContext context, AuthProvider provider) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await provider.logout();

      if (context.mounted) {
        Navigator.pop(context);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
        );
      }
    } catch (error) {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign out failed: ${error.toString()}')),
        );
      }
    }
  }


  Future<void> _showSignOutConfirmation(
      BuildContext context, AuthProvider provider) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sign Out"),
        content: Text("Are you sure you want to sign out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _performSignOut(context, provider);
            },
            child: Text("Confirm", style: TextStyle(color: primaryRed)),
          )
        ],
      ),
    );
  }
}