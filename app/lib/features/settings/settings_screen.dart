import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_controller.dart';
import '../../core/app_scope.dart';
import '../../domain/monetization/phase2_placeholders.dart';
import '../../l10n/strings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final s = app.settings;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text(Strings.settings),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text(Strings.appearance),
            subtitle: Text(_themeLabel(s.themeMode)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text(Strings.themeSystem),
                ),
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text(Strings.themeLight),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text(Strings.themeDark),
                ),
              ],
              selected: {s.themeMode},
              onSelectionChanged: (set) {
                app.setThemeMode(set.first);
              },
            ),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text(Strings.masterMute),
            value: s.masterMute,
            onChanged: (v) => app.updateSettings(masterMute: v),
          ),
          SwitchListTile(
            title: const Text(Strings.bgm),
            value: s.bgmEnabled,
            onChanged: (v) => app.updateSettings(bgmEnabled: v),
          ),
          SwitchListTile(
            title: const Text(Strings.sfx),
            value: s.sfxEnabled,
            onChanged: (v) => app.updateSettings(sfxEnabled: v),
          ),
          const Divider(),
          ListTile(
            title: const Text(Strings.supportDeveloper),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/settings/donate'),
          ),
          ListTile(
            title: const Text(Strings.privacyPolicy),
            onTap: () => Phase2Placeholders.openLegal(context, 'privacy'),
          ),
          ListTile(
            title: const Text(Strings.termsOfUse),
            onTap: () => Phase2Placeholders.openLegal(context, 'terms'),
          ),
          ListTile(
            title: const Text(Strings.about),
            subtitle: Text('${Strings.appName} v1.0.0'),
          ),
          ListTile(
            title: Text(
              Strings.resetProgress,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            onTap: () => _confirmReset(context, app),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  String _themeLabel(ThemeMode mode) => switch (mode) {
        ThemeMode.light => Strings.themeLight,
        ThemeMode.dark => Strings.themeDark,
        ThemeMode.system => Strings.themeSystem,
      };

  Future<void> _confirmReset(BuildContext context, AppController app) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(Strings.resetConfirmTitle),
        content: const Text(Strings.resetConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(Strings.adCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(Strings.resetConfirm),
          ),
        ],
      ),
    );
    if (ok == true && context.mounted) {
      await app.resetProgress();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(Strings.progressReset)),
        );
        context.go('/levels');
      }
    }
  }
}
