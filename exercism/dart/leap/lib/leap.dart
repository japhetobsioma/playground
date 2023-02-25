class Leap {
  bool leapYear(int year) {
    final isDivisibleByFour = year % 4 == 0;
    final isDivisibleByOneHundred = year % 100 == 0;
    final isDivisibleByFourHundred = year % 400 == 0;

    if (isDivisibleByFour) {
      if (isDivisibleByFourHundred) return true;
      if (isDivisibleByOneHundred) return false;
      return true;
    } else {
      return false;
    }
  }
}
