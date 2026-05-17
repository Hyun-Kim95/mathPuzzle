import 'package:flutter/material.dart';

class AppSettings {
  AppSettings({
    this.themeMode = ThemeMode.system,
    this.masterMute = false,
    this.bgmEnabled = true,
    this.sfxEnabled = true,
    this.adsConsentGranted = false,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    final mode = json['themeMode'] as String? ?? 'system';
    return AppSettings(
      themeMode: switch (mode) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      },
      masterMute: json['masterMute'] as bool? ?? false,
      bgmEnabled: json['bgmEnabled'] as bool? ?? true,
      sfxEnabled: json['sfxEnabled'] as bool? ?? true,
      adsConsentGranted: json['adsConsentGranted'] as bool? ?? false,
    );
  }

  ThemeMode themeMode;
  bool masterMute;
  bool bgmEnabled;
  bool sfxEnabled;
  bool adsConsentGranted;

  Map<String, dynamic> toJson() => {
        'schemaVersion': 1,
        'themeMode': switch (themeMode) {
          ThemeMode.light => 'light',
          ThemeMode.dark => 'dark',
          ThemeMode.system => 'system',
        },
        'masterMute': masterMute,
        'bgmEnabled': bgmEnabled,
        'sfxEnabled': sfxEnabled,
        'adsConsentGranted': adsConsentGranted,
      };
}
