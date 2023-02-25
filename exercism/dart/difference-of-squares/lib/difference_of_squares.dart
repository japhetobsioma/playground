import 'dart:math';

class DifferenceOfSquares {
  int squareOfSum(int number) {
    final numbers = List.generate(number, (index) => index + 1);
    final sum = numbers.fold(0, (prev, next) => prev + next);
    return pow(sum, 2).toInt();
  }

  int sumOfSquares(int number) {
    final numbers = List.generate(number, (index) => pow(index + 1, 2).toInt());
    return numbers.fold(0, (prev, next) => prev + next);
  }

  int differenceOfSquares(int number) {
    return squareOfSum(number) - sumOfSquares(number);
  }
}
