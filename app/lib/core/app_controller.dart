import 'package:flutter/material.dart';

import '../data/level_repository.dart';
import '../data/progress_store.dart';
import '../data/settings_store.dart';
import '../domain/ad_reward_service.dart';
import '../domain/consent_service.dart';
import '../domain/purchase_service.dart';
import '../models/app_settings.dart';

class AppController extends ChangeNotifier {
  AppController({
    LevelRepository? levelRepository,
    ProgressStore? progressStore,
    SettingsStore? settingsStore,
    AdRewardService? adRewardService,
    PurchaseService? purchaseService,
  })  : levels = levelRepository ?? LevelRepository(),
        progress = progressStore ?? ProgressStore(),
        settingsStore = settingsStore ?? SettingsStore(),
        ads = adRewardService ?? AdRewardService(),
        purchases = purchaseService ?? PurchaseService();

  final LevelRepository levels;
  final ProgressStore progress;
  final SettingsStore settingsStore;
  final AdRewardService ads;
  final PurchaseService purchases;
  late ConsentService consent;

  bool _ready = false;
  bool get ready => _ready;

  AppSettings get settings => settingsStore.settings;

  Future<void> init() async {
    await progress.load();
    await settingsStore.load();
    consent = ConsentService(settings);
    await purchases.init();
    _ready = true;
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    settings.themeMode = mode;
    await settingsStore.save();
    notifyListeners();
  }

  Future<void> setAdsConsent(bool granted) async {
    settings.adsConsentGranted = granted;
    await settingsStore.save();
    notifyListeners();
  }

  Future<void> skipOnboarding() async {
    progress.onboardingSeen = true;
    await progress.save();
    notifyListeners();
  }

  Future<void> completeTutorial() async {
    progress.tutorialSeen = true;
    await progress.save();
    notifyListeners();
  }

  Future<void> resetProgress() async {
    await progress.resetProgress();
    notifyListeners();
  }

  Future<void> updateSettings({
    bool? masterMute,
    bool? bgmEnabled,
    bool? sfxEnabled,
  }) async {
    if (masterMute != null) settings.masterMute = masterMute;
    if (bgmEnabled != null) settings.bgmEnabled = bgmEnabled;
    if (sfxEnabled != null) settings.sfxEnabled = sfxEnabled;
    await settingsStore.save();
    notifyListeners();
  }

  @override
  void dispose() {
    ads.dispose();
    purchases.dispose();
    super.dispose();
  }
}
