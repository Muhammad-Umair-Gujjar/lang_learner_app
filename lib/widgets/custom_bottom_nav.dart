import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../core/constants.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return CurvedNavigationBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      color: primaryRed,
      buttonBackgroundColor: primaryRed,
      animationDuration: Duration(milliseconds: 300),
      height: 50,
      index: selectedIndex,
      onTap: onTap,
      items: const <Widget>[
        Icon(Icons.home, size: 24, color: Colors.white),
        Icon(Icons.quiz, size: 24, color: Colors.white),
        Icon(Icons.chat, size: 24, color: Colors.white),
        Icon(Icons.person, size: 24, color: Colors.white),
      ],
    );
  }
}
