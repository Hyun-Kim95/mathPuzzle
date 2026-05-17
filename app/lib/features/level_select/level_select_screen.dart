import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_scope.dart';
import '../../data/progress_store.dart';
import '../../l10n/strings.dart';
import '../../theme/app_theme.dart';

class LevelSelectScreen extends StatefulWidget {
  const LevelSelectScreen({super.key});

  @override
  State<LevelSelectScreen> createState() => _LevelSelectScreenState();
}

class _LevelSelectScreenState extends State<LevelSelectScreen> {
  static const _chapterSize = 20;
  static const _chapterCount = 5;

  int _total = 100;

  @override
  void initState() {
    super.initState();
    _loadTotal();
  }

  Future<void> _loadTotal() async {
    final app = AppScope.of(context);
    final ids = await app.levels.levelIds();
    if (mounted) setState(() => _total = ids.length);
  }

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final progress = app.progress;
    final cleared = progress.clearedCount();

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '$cleared / $_total ${Strings.progressSummary}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          for (var ch = 1; ch <= _chapterCount; ch++) ...[
            _ChapterHeader(
              chapter: ch,
              unlocked: progress.highestUnlocked > (ch - 1) * _chapterSize,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var i = 0; i < _chapterSize; i++)
                  _LevelChip(
                    levelId: (ch - 1) * _chapterSize + i + 1,
                    progress: progress,
                    onTap: (id) => _openLevel(context, id, progress),
                  ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ],
      ),
    );
  }

  void _openLevel(BuildContext context, int id, ProgressStore progress) {
    if (id > _total) return;
    if (!progress.canEnter(id)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(Strings.levelLocked)),
      );
      return;
    }
    final showTutorial = id == 1 && !progress.tutorialSeen;
    context.push(
      showTutorial ? '/play/$id?tutorial=1' : '/play/$id',
    );
  }
}

class _ChapterHeader extends StatelessWidget {
  const _ChapterHeader({required this.chapter, required this.unlocked});

  final int chapter;
  final bool unlocked;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${Strings.chapter} $chapter',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        if (!unlocked) ...[
          const SizedBox(width: 8),
          Icon(Icons.lock, size: 18, color: AppColors.lightLocked),
        ],
      ],
    );
  }
}

class _LevelChip extends StatelessWidget {
  const _LevelChip({
    required this.levelId,
    required this.progress,
    required this.onTap,
  });

  final int levelId;
  final ProgressStore progress;
  final void Function(int id) onTap;

  @override
  Widget build(BuildContext context) {
    final canEnter = progress.canEnter(levelId);
    final completed = progress.isCompleted(levelId);
    final perfect = progress.isPerfect(levelId);

    Color bg = Theme.of(context).colorScheme.surface;
    Color fg = Theme.of(context).colorScheme.onSurface;
    IconData? icon;

    if (!canEnter) {
      bg = AppColors.lightLocked.withValues(alpha: 0.35);
      fg = AppColors.lightMuted;
      icon = Icons.lock;
    } else if (perfect) {
      bg = AppColors.lightPerfect.withValues(alpha: 0.25);
      icon = Icons.star;
    } else if (completed) {
      bg = AppColors.lightSuccess.withValues(alpha: 0.25);
      icon = Icons.check;
    }

    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: canEnter ? () => onTap(levelId) : null,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 52,
          height: 44,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: fg),
                const SizedBox(width: 2),
              ],
              Text(
                '$levelId',
                style: TextStyle(fontWeight: FontWeight.w600, color: fg),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
