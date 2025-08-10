import 'package:flutter/material.dart';

import '../../../core/constants.dart';

class RoundButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  bool? loading;
  RoundButton({
    super.key,
    this.loading = false,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryRed,
        ),
        child: Center(
          child: (loading!)
              ? CircularProgressIndicator(color: Colors.white)
              : Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
