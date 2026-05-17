import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/app_controller.dart';
import 'core/app_scope.dart';
import 'core/routing/app_router.dart';
import 'l10n/strings.dart';
import 'theme/app_theme.dart';

class MathPuzzleApp extends StatefulWidget {
  const MathPuzzleApp({required this.controller, super.key});

  final AppController controller;

  @override
  State<MathPuzzleApp> createState() => _MathPuzzleAppState();
}

class _MathPuzzleAppState extends State<MathPuzzleApp> {
  late final GoRouter _router = createAppRouter(widget.controller);

  @override
  Widget build(BuildContext context) {
    return AppScope(
      notifier: widget.controller,
      child: ListenableBuilder(
        listenable: widget.controller,
        builder: (context, _) {
          final settings = widget.controller.settings;
          return MaterialApp.router(
            title: Strings.appName,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: settings.themeMode,
            routerConfig: _router,
          );
        },
      ),
    );
  }
}
