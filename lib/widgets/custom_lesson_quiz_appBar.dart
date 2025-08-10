import 'package:flutter/material.dart';
import '../core/constants.dart';
class CustomLessonQuizAppbar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final VoidCallback? onBackPressed;
  const CustomLessonQuizAppbar({super.key, required this.title, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryRed,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: white),
        onPressed: () {
          if (onBackPressed != null) {
            onBackPressed!();
          } else {
            Navigator.pop(context);
          }
        },
      ),
      title: Text(
        title,
        style: TextStyle(color: white),
      ),
    );
  }
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
