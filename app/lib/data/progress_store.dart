import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/level_flags.dart';

class ProgressStore {
  static const _progressKey = '@mathPuzzle/progress_v1';
  static const _metaKey = '@mathPuzzle/app_meta_v1';

  int highestUnlocked = 1;
  final Map<int, LevelFlags> levels = {};
  bool onboardingSeen = false;
  bool tutorialSeen = false;

  LevelFlags flagsFor(int levelId) =>
      levels[levelId] ??= LevelFlags();

  bool canEnter(int levelId) => levelId <= highestUnlocked;

  bool isCompleted(int levelId) => flagsFor(levelId).completed;

  bool isPerfect(int levelId) => flagsFor(levelId).perfect;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final progressRaw = prefs.getString(_progressKey);
    if (progressRaw != null) {
      final json = jsonDecode(progressRaw) as Map<String, dynamic>;
      highestUnlocked = json['highestUnlocked'] as int? ?? 1;
      final levelsJson = json['levels'] as Map<String, dynamic>? ?? {};
      levels.clear();
      for (final entry in levelsJson.entries) {
        final id = int.parse(entry.key);
        levels[id] = LevelFlags.fromJson(
          entry.value as Map<String, dynamic>,
        );
      }
    }
    final metaRaw = prefs.getString(_metaKey);
    if (metaRaw != null) {
      final meta = jsonDecode(metaRaw) as Map<String, dynamic>;
      onboardingSeen = meta['onboardingSeen'] as bool? ?? false;
      tutorialSeen = meta['tutorialSeen'] as bool? ?? false;
    }
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final levelsOut = <String, dynamic>{};
    for (final entry in levels.entries) {
      if (entry.value.hasAnyFlag) {
        levelsOut['${entry.key}'] = entry.value.toJson();
      }
    }
    await prefs.setString(
      _progressKey,
      jsonEncode({
        'schemaVersion': 1,
        'highestUnlocked': highestUnlocked,
        'levels': levelsOut,
      }),
    );
    await prefs.setString(
      _metaKey,
      jsonEncode({
        'schemaVersion': 1,
        'onboardingSeen': onboardingSeen,
        'tutorialSeen': tutorialSeen,
      }),
    );
  }

  Future<void> completeLevel(int levelId) async {
    final f = flagsFor(levelId);
    f.perfect = !(f.hintUnlocked || f.answerUnlocked);
    f.completed = true;
    if (levelId < 100) {
      highestUnlocked = highestUnlocked > levelId + 1
          ? highestUnlocked
          : levelId + 1;
    }
    await save();
  }

  Future<void> setHintUnlocked(int levelId) async {
    flagsFor(levelId).hintUnlocked = true;
    await save();
  }

  Future<void> setAnswerUnlocked(int levelId) async {
    flagsFor(levelId).answerUnlocked = true;
    await save();
  }

  Future<void> resetProgress() async {
    highestUnlocked = 1;
    levels.clear();
    await save();
  }

  int clearedCount() =>
      levels.values.where((f) => f.completed).length;
}
