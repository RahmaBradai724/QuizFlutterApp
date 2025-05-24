class Score {
  final String category;
  final String difficulty;
  final int score;
  final DateTime date;

  Score({
    required this.category,
    required this.difficulty,
    required this.score,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'difficulty': difficulty,
      'score': score,
      'date': date.toIso8601String(),
    };
  }

  factory Score.fromMap(Map<String, dynamic> map) {
    return Score(
      category: map['category'],
      difficulty: map['difficulty'],
      score: map['score'],
      date: DateTime.parse(map['date']),
    );
  }
}