import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../l10n/strings.dart';
import '../models/app_settings.dart';

/// UMP + local consent for child-directed / Everyone (ADR-0005).
class ConsentService {
  ConsentService(this._settings);

  final AppSettings _settings;
  bool _umpRequested = false;

  Future<void> requestUmpIfNeeded() async {
    if (_umpRequested) return;
    _umpRequested = true;
    try {
      final params = ConsentRequestParameters(
        tagForUnderAgeOfConsent: true,
      );
      final completer = Completer<void>();
      ConsentInformation.instance.requestConsentInfoUpdate(
        params,
        () => completer.complete(),
        (_) => completer.complete(),
      );
      await completer.future.timeout(
        const Duration(seconds: 5),
        onTimeout: () {},
      );
    } catch (_) {
      // UMP unavailable on some platforms — in-app dialog only
    }
  }

  Future<bool> ensureAdsConsent(BuildContext context) async {
    if (_settings.adsConsentGranted) return true;

    await requestUmpIfNeeded();

    if (!context.mounted) return false;

    final accepted = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text(Strings.adConsentTitle),
        content: const Text(Strings.adConsentBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text(Strings.adConsentDecline),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(Strings.adConsentAccept),
          ),
        ],
      ),
    );

    if (accepted == true) {
      _settings.adsConsentGranted = true;
      return true;
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(Strings.adConsentBlocked)),
      );
    }
    return false;
  }
}
