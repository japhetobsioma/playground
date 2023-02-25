class HighScores {
  const HighScores(this.scores);

  final List<int> scores;

  int latest() => scores.last;

  int personalBest() {
    final sorted = [...scores]..sort((a, b) => b.compareTo(a));
    return sorted.first;
  }

  List<int> personalTopThree() {
    final sorted = [...scores]..sort((a, b) => b.compareTo(a));
    return sorted.take(3).toList();
  }
}
