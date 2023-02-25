class ArmstrongNumbers {
  bool isArmstrongNumber(String number) {
    final digits = number.split('');

    BigInt total = BigInt.from(0);
    for (final digit in digits) {
      total += BigInt.parse(digit).pow(digits.length);
    }

    return total == BigInt.parse(number);
  }
}
