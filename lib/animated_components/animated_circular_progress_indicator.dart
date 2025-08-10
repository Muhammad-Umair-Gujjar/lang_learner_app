import 'package:flutter/material.dart';
import '../core/constants.dart';
class AnimatedCircularProgressIndicator extends StatelessWidget {
  final String label;
  final double percentage;
  const AnimatedCircularProgressIndicator({
    super.key,
    required this.label,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: percentage),
            duration: Duration(seconds: 1),
            builder: (context, value, child) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    color: mediumPink.withRed(170),
                    value: value,
                    strokeWidth: 10,
                    backgroundColor: Color(0xFFE0E0E0),
                  ),
                  Center(
                    child: Text(
                      "${(value * 100).toInt()}%",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(height: defaultPadding / 2),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}