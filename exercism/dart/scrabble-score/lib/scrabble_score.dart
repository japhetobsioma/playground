int score(String word) {
  final values = {
    ['A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T']: 1,
    ['D', 'G']: 2,
    ['B', 'C', 'M', 'P']: 3,
    ['F', 'H', 'V', 'W', 'Y']: 4,
    ['K']: 5,
    ['J', 'X']: 8,
    ['Q', 'Z']: 10
  };

  final letters = word.split('').map((e) => e.toUpperCase());

  int totalScore = 0;
  for (final letter in letters) {
    for (final entry in values.entries) {
      if (entry.key.contains(letter)) totalScore += entry.value;
    }
  }

  return totalScore;
}
