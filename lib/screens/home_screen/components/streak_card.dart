import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/streak_provider.dart';
class StreakCard extends StatelessWidget {
  const StreakCard({super.key});

  @override

  Widget build(BuildContext context) {
    return Consumer<StreakProvider>(
      builder: (context, streakProvider, child) {

        final streak = streakProvider.currentStreak;
        final xpReward = streak >= 7 ? 10 : 0;

        return Card(
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.local_fire_department, color: Colors.orange),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Daily Streak",
                        style: Theme.of(context).textTheme.titleSmall),
                    Text("🔥 $streak days in a row!",
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
                const Spacer(),
                if (xpReward > 0) Chip(label: Text("+$xpReward XP")),
              ],
            ),
          ),
        );
      },
    );
  }
}