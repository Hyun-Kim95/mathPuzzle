class LevelFlags {
  LevelFlags({
    this.completed = false,
    this.perfect = false,
    this.hintUnlocked = false,
    this.answerUnlocked = false,
  });

  factory LevelFlags.fromJson(Map<String, dynamic> json) => LevelFlags(
        completed: json['completed'] as bool? ?? false,
        perfect: json['perfect'] as bool? ?? false,
        hintUnlocked: json['hintUnlocked'] as bool? ?? false,
        answerUnlocked: json['answerUnlocked'] as bool? ?? false,
      );

  bool completed;
  bool perfect;
  bool hintUnlocked;
  bool answerUnlocked;

  Map<String, dynamic> toJson() => {
        'completed': completed,
        'perfect': perfect,
        'hintUnlocked': hintUnlocked,
        'answerUnlocked': answerUnlocked,
      };

  bool get hasAnyFlag =>
      completed || perfect || hintUnlocked || answerUnlocked;
}
