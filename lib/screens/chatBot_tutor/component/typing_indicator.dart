import 'package:flutter/material.dart';

class TypingIndicator extends StatelessWidget {
  final Color? dotColor;

  const TypingIndicator({Key? key, this.dotColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = dotColor ?? Theme.of(context).primaryColor;
    return SizedBox(
      width: 40,
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTypingDot(color, 0),
          _buildTypingDot(color, 200),
          _buildTypingDot(color, 400),
        ],
      ),
    );
  }

  Widget _buildTypingDot(Color color, int delay) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
      onEnd: () {},
      builder: (context, value, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          margin: const EdgeInsets.all(2),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color.withOpacity(value),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
