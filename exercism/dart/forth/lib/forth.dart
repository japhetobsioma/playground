class Forth {
  List<int> stack = [];

  void evaluate(String value) {
    final chars = value.split(' ');
    final numbers = <int>[];
    final symbols = <String>[];
    String word = '';

    for (final char in chars) {
      final number = int.tryParse(char);

      if (number != null) {
        numbers.add(number);
      } else {
        if (char.length > 1) {
          word = char;
        } else {
          symbols.add(char);
        }
      }
    }

    if (symbols.isEmpty) {
      if (word.isNotEmpty) {
        if (numbers.isNotEmpty) {
          stack.addAll(_processWord(word, numbers));
        } else {
          throw Exception('Stack empty');
        }
      } else {
        stack.addAll(numbers);
      }
    } else {
      if (numbers.length == 1 || numbers.isEmpty) {
        throw Exception('Stack empty');
      }

      if (symbols.length == 1) {
        stack.add(
          _processArithmetic(symbols.first, numbers.first, numbers.last),
        );
      } else {
        final firstOperation = _processArithmetic(
          symbols[0],
          numbers[0],
          numbers[1],
        );
        stack.add(_processArithmetic(symbols[1], firstOperation, numbers.last));
      }
    }
  }

  List<int> _processWord(String word, List<int> numbers) {
    print(word);
    switch (word) {
      case 'dup':
        if (numbers.length == 1) {
          return [numbers.first, numbers.first];
        } else {
          return [...numbers, numbers.last];
        }
      case 'drop':
        if (numbers.length == 1) {
          return [];
        } else {
          return [...numbers.take(numbers.length - 1)];
        }
      case 'swap':
        if (numbers.length == 2) {
          return [numbers.last, numbers.first];
        } else {
          return [numbers.first, numbers[2], numbers[1]];
        }
      case 'over':
        if (numbers.length == 2) {
          return [...numbers, numbers.first];
        } else {
          return [...numbers, numbers[numbers.length - 2]];
        }
      default:
        throw UnimplementedError('$word is not implemented');
    }
  }

  int _processArithmetic(
    String symbol,
    int a,
    int b,
  ) {
    switch (symbol) {
      case '+':
        return a + b;
      case '-':
        return a - b;
      case '*':
        return a * b;
      case '/':
        try {
          return a ~/ b;
        } on UnsupportedError {
          throw Exception('Division by zero');
        }
      default:
        throw UnimplementedError('$symbol is not implemented');
    }
  }
}
