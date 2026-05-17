import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_scope.dart';
import '../../l10n/strings.dart';
import '../../theme/app_theme.dart';

class LevelCompleteScreen extends StatelessWidget {
  const LevelCompleteScreen({
    required this.levelId,
    required this.perfect,
    super.key,
  });

  final int levelId;
  final bool perfect;

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final total = app.levels.totalLevels;
    final hasNext = levelId < total && app.progress.canEnter(levelId + 1);
    final isLast = levelId >= total;

    return Scaffold(
      appBar: AppBar(title: Text('${Strings.levelTitle} $levelId')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Icon(
              perfect ? Icons.star_rounded : Icons.check_circle_outline,
              size: 80,
              color: perfect ? AppColors.lightPerfect : AppColors.lightSuccess,
            ),
            const SizedBox(height: 16),
            Text(
              isLast ? Strings.allCompleteTitle : (perfect ? 'Perfect!' : 'Level cleared!'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Spacer(),
            if (isLast)
              FilledButton(
                onPressed: () => context.go('/complete'),
                child: const Text(Strings.backToLevels),
              )
            else if (hasNext)
              FilledButton(
                onPressed: () => context.go('/play/${levelId + 1}'),
                child: const Text(Strings.nextLevel),
              ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => context.go('/levels'),
              child: const Text(Strings.backToLevels),
            ),
          ],
        ),
      ),
    );
  }
}
