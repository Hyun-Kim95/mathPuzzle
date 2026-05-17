import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_scope.dart';
import '../../l10n/strings.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text(Strings.appName)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Text(
              Strings.onboardingTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),
            Text(
              Strings.onboardingBody,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(),
            FilledButton(
              onPressed: () async {
                await app.skipOnboarding();
                if (context.mounted) context.go('/levels');
              },
              child: const Text(Strings.onboardingContinue),
            ),
            TextButton(
              onPressed: () async {
                await app.skipOnboarding();
                if (context.mounted) context.go('/levels');
              },
              child: const Text(Strings.onboardingSkip),
            ),
          ],
        ),
      ),
    );
  }
}
