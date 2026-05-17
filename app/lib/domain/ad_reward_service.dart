import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../domain/monetization/phase2_placeholders.dart';
import '../l10n/strings.dart';

class AdRewardService {
  RewardedAd? _ad;
  bool _loading = false;

  static String get _unitId {
    if (kDebugMode) {
      return Phase2Placeholders.admobRewardedTestAndroid;
    }
    // Production: set via --dart-define=ADMOB_REWARDED_UNIT=...
    return const String.fromEnvironment(
      'ADMOB_REWARDED_UNIT',
      defaultValue: Phase2Placeholders.admobRewardedTestAndroid,
    );
  }

  Future<bool> showRewarded({
    required BuildContext context,
    required bool forHint,
  }) async {
    if (_loading) return false;

    final loaded = await _loadAd();
    if (!loaded || _ad == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(Strings.adUnavailable)),
        );
      }
      return false;
    }

    final completer = Completer<bool>();
    var rewarded = false;

    _ad!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _ad = null;
        if (!completer.isCompleted) completer.complete(rewarded);
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _ad = null;
        if (!completer.isCompleted) completer.complete(false);
      },
    );

    _ad!.show(
      onUserEarnedReward: (ad, reward) {
        rewarded = true;
      },
    );

    return completer.future.timeout(
      const Duration(minutes: 2),
      onTimeout: () => rewarded,
    );
  }

  Future<bool> _loadAd() async {
    if (_ad != null) return true;
    _loading = true;
    final completer = Completer<bool>();

    await RewardedAd.load(
      adUnitId: _unitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _ad = ad;
          _loading = false;
          if (!completer.isCompleted) completer.complete(true);
        },
        onAdFailedToLoad: (error) {
          _loading = false;
          if (!completer.isCompleted) completer.complete(false);
        },
      ),
    );

    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        _loading = false;
        return false;
      },
    );
  }

  void dispose() {
    _ad?.dispose();
    _ad = null;
  }
}
