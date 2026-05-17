class PuzzleLevel {
  PuzzleLevel({
    required this.id,
    required this.title,
    required this.type,
    required this.prompt,
    required this.hint,
    required this.explanation,
    required this.difficulty,
    required this.inputMode,
    required this.answer,
    this.min,
    this.max,
  });

  factory PuzzleLevel.fromJson(Map<String, dynamic> json) {
    final input = json['input'] as Map<String, dynamic>;
    final mode = input['mode'] as String;
    return PuzzleLevel(
      id: json['id'] as int,
      title: json['title'] as String,
      type: json['type'] as String,
      prompt: json['prompt'] as String,
      hint: json['hint'] as String,
      explanation: json['explanation'] as String,
      difficulty: json['difficulty'] as String,
      inputMode: mode,
      answer: json['answer'],
      min: input['min'] as int?,
      max: input['max'] as int?,
    );
  }

  final int id;
  final String title;
  final String type;
  final String prompt;
  final String hint;
  final String explanation;
  final String difficulty;
  final String inputMode;
  final Object answer;
  final int? min;
  final int? max;

  bool checkAnswer(String raw) {
    if (inputMode != 'numeric') return false;
    final parsed = int.tryParse(raw.trim());
    if (parsed == null) return false;
    if (min != null && parsed < min!) return false;
    if (max != null && parsed > max!) return false;
    return parsed == answer;
  }
}
