import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/puzzle_level.dart';

class LevelRepository {
  final Map<int, PuzzleLevel> _cache = {};
  List<int>? _ids;

  Future<List<int>> levelIds() async {
    if (_ids != null) return _ids!;
    final raw = await rootBundle.loadString(
      'assets/levels/levels.manifest.json',
    );
    final json = jsonDecode(raw) as Map<String, dynamic>;
    _ids = (json['ids'] as List<dynamic>).map((e) => e as int).toList();
    return _ids!;
  }

  int get totalLevels => _ids?.length ?? 100;

  Future<PuzzleLevel?> loadLevel(int id) async {
    if (_cache.containsKey(id)) return _cache[id];
    try {
      final raw = await rootBundle.loadString(
        'assets/levels/level-${id.toString().padLeft(3, '0')}.json',
      );
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final level = PuzzleLevel.fromJson(json);
      _cache[id] = level;
      return level;
    } catch (_) {
      return null;
    }
  }
}
