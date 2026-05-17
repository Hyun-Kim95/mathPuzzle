import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_scope.dart';
import '../../features/tutorial/level1_tutorial_overlay.dart';
import '../../l10n/strings.dart';
import '../../models/puzzle_level.dart';
import '../../theme/app_theme.dart';

class PuzzlePlayScreen extends StatefulWidget {
  const PuzzlePlayScreen({
    required this.levelId,
    this.showTutorial = false,
    super.key,
  });

  final int levelId;
  final bool showTutorial;

  @override
  State<PuzzlePlayScreen> createState() => _PuzzlePlayScreenState();
}

class _PuzzlePlayScreenState extends State<PuzzlePlayScreen> {
  PuzzleLevel? _level;
  final _controller = TextEditingController();
  String? _feedback;
  bool _wrong = false;
  bool _loading = true;
  bool _showTutorialOverlay = false;

  bool get _adsDisabled =>
      widget.showTutorial && !AppScope.of(context).progress.tutorialSeen;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final app = AppScope.of(context);
    if (!app.progress.canEnter(widget.levelId)) {
      if (mounted) context.go('/levels');
      return;
    }
    final level = await app.levels.loadLevel(widget.levelId);
    if (!mounted) return;
    if (level == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(Strings.puzzleLoadError)),
      );
      context.go('/levels');
      return;
    }
    setState(() {
      _level = level;
      _loading = false;
      _showTutorialOverlay =
          widget.showTutorial && !app.progress.tutorialSeen;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _dismissTutorial() async {
    final app = AppScope.of(context);
    await app.completeTutorial();
    if (mounted) setState(() => _showTutorialOverlay = false);
  }

  Future<void> _submit() async {
    final level = _level;
    if (level == null) return;
    final app = AppScope.of(context);
    if (!level.checkAnswer(_controller.text)) {
      setState(() {
        _wrong = true;
        _feedback = Strings.tryAgain;
      });
      return;
    }
    await app.progress.completeLevel(widget.levelId);
    final perfect = app.progress.isPerfect(widget.levelId);
    if (!mounted) return;
    context.go(
      '/play/${widget.levelId}/complete?perfect=${perfect ? 1 : 0}',
    );
  }

  Future<void> _unlockHint() async {
    if (_adsDisabled) return;
    final app = AppScope.of(context);
    final flags = app.progress.flagsFor(widget.levelId);
    if (flags.hintUnlocked) return;

    if (!await app.consent.ensureAdsConsent(context)) return;
    if (!mounted) return;
    await app.setAdsConsent(true);
    if (!mounted) return;

    final ok = await app.ads.showRewarded(context: context, forHint: true);
    if (!ok || !mounted) return;
    await app.progress.setHintUnlocked(widget.levelId);
    setState(() {});
  }

  Future<void> _unlockAnswer() async {
    if (_adsDisabled) return;
    final app = AppScope.of(context);
    final flags = app.progress.flagsFor(widget.levelId);
    if (flags.answerUnlocked) return;

    if (!await app.consent.ensureAdsConsent(context)) return;
    if (!mounted) return;
    await app.setAdsConsent(true);
    if (!mounted) return;

    final ok = await app.ads.showRewarded(context: context, forHint: false);
    if (!ok || !mounted) return;
    await app.progress.setAnswerUnlocked(widget.levelId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final level = _level!;
    final app = AppScope.of(context);
    final flags = app.progress.flagsFor(widget.levelId);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/levels'),
        ),
        title: Text('${Strings.levelTitle} ${widget.levelId}'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      level.prompt,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Answer',
                    errorText: _wrong ? _feedback : null,
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (_) {
                    if (_wrong) setState(() => _wrong = false);
                  },
                ),
                if (flags.hintUnlocked) ...[
                  const SizedBox(height: 12),
                  _panel(
                    context,
                    Strings.hint,
                    level.hint,
                    AppColors.lightAccent,
                  ),
                ],
                if (flags.answerUnlocked) ...[
                  const SizedBox(height: 12),
                  _panel(
                    context,
                    Strings.showAnswer,
                    '${level.answer}\n\n${level.explanation}',
                    AppColors.lightPrimary,
                  ),
                ],
                const Spacer(),
                FilledButton(
                  onPressed: _submit,
                  child: const Text(Strings.submit),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _adsDisabled || flags.hintUnlocked
                            ? null
                            : _unlockHint,
                        child: const Text(Strings.hint),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _adsDisabled || flags.answerUnlocked
                            ? null
                            : _unlockAnswer,
                        child: const Text(Strings.showAnswer),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (_showTutorialOverlay)
            Level1TutorialOverlay(onDismiss: _dismissTutorial),
        ],
      ),
    );
  }

  Widget _panel(
    BuildContext context,
    String title,
    String body,
    Color accent,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(body),
        ],
      ),
    );
  }
}
