import 'package:flutter/material.dart';

import '../../l10n/strings.dart';

/// Phase 2 hooks: AdMob test IDs, IAP SKUs (ADR-0005).
abstract final class Phase2Placeholders {
  /// Google sample app ID (Android) — replace in release AdMob console.
  static const admobAppIdAndroid = 'ca-app-pub-3940256099942544~3347511713';

  static const admobRewardedTestAndroid =
      'ca-app-pub-3940256099942544/5224354917';

  static const iapSkus = ['tip_small', 'tip_medium', 'tip_large'];

  static Future<void> openLegal(BuildContext context, String doc) async {
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          doc == 'privacy' ? Strings.privacyPolicy : Strings.termsOfUse,
        ),
        content: const Text(Strings.legalDraftNotice),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
