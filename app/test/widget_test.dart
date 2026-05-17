import 'package:flutter_test/flutter_test.dart';
import 'package:math_puzzle/data/level_repository.dart';
import 'package:math_puzzle/models/puzzle_level.dart';
import 'package:math_puzzle/data/progress_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('level answer validates', () {
    final level = PuzzleLevel(
      id: 1,
      title: 'L1',
      type: 'number_grid',
      prompt: 'test',
      hint: 'h',
      explanation: 'e',
      difficulty: 'easy',
      inputMode: 'numeric',
      answer: 10,
      min: 0,
      max: 99,
    );
    expect(level.checkAnswer('10'), isTrue);
    expect(level.checkAnswer('9'), isFalse);
  });

  test('perfect flag when no ad unlocks', () async {
    final progress = ProgressStore();
    await progress.load();
    await progress.completeLevel(1);
    expect(progress.isPerfect(1), isTrue);
  });

  test('no perfect after hint unlock', () async {
    final progress = ProgressStore();
    await progress.load();
    await progress.setHintUnlocked(1);
    await progress.completeLevel(1);
    expect(progress.isPerfect(1), isFalse);
  });

  test('highestUnlocked advances on clear', () async {
    final progress = ProgressStore();
    await progress.load();
    expect(progress.highestUnlocked, 1);
    await progress.completeLevel(1);
    expect(progress.highestUnlocked, 2);
  });

  test('manifest lists 100 levels', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final repo = LevelRepository();
    final ids = await repo.levelIds();
    expect(ids.length, 100);
    expect(ids.first, 1);
    expect(ids.last, 100);
  });
}
