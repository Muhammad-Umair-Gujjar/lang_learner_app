
import 'package:flutter/material.dart';
import '../../../core/constants.dart';

class StatItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatItem({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: primaryRed.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: primaryRed, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryDark,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}