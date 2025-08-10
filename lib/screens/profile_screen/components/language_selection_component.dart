import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants.dart';
import '../../../provider/profile_provider.dart';
import '../../../provider/user_progres_provider.dart';

class LanguageSelectionCard extends StatelessWidget {
  final String currentLanguage;
  final List<String> availableLanguages;

  const LanguageSelectionCard({
    super.key,
    required this.currentLanguage,
    required this.availableLanguages,
  });

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 10),
            _buildLanguageDropdown(context, profileProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Learning Language',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryDark,
          ),
        ),
        Icon(Icons.language, color: primaryRed),
      ],
    );
  }

  Widget _buildLanguageDropdown(
    BuildContext context,
    ProfileProvider provider,
  ) {
    return DropdownButtonFormField<String>(
      value: currentLanguage,
      items: availableLanguages
          .map(
            (language) =>
                DropdownMenuItem(value: language, child: Text(language)),
          )
          .toList(),
      onChanged: (newLanguage) async {
        if (newLanguage != null && newLanguage != currentLanguage) {
          await _showConfirmationDialog(context, newLanguage, provider);
        }
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE4E7EB)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog(
    BuildContext context,
    String newLanguage,
    ProfileProvider provider,
  ) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Change Language'),
        content: Text(
          'Are you sure you want to change language to $newLanguage?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(
                context,
              );
              final progress = Provider.of<UserProgress>(
                context,
                listen: false,
              );
              final provider = Provider.of<ProfileProvider>(
                context,
                listen: false,
              );
              Navigator.pop(
                context,
              );
              try {
                await provider.updateUserLanguage(newLanguage);
                await progress.initializeProgress(newLanguage);

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  messenger.showSnackBar(
                    SnackBar(content: Text('Language updated to $newLanguage')),
                  );
                });
              } catch (e) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  messenger.showSnackBar(
                    const SnackBar(content: Text('Failed to update language')),
                  );
                });
              }
            },

            child: Text("Confirm", style: TextStyle(color: primaryRed)),
          ),
        ],
      ),
    );
  }
}
