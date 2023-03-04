class Forth {
  List<int> stack = [];

  bool isNumber(String value) => int.tryParse(value) != null;

  int add(int x, int y) => x + y;

  int subtract(int x, int y) => x - y;

  int multiply(int x, int y) => x * y;

  int divide(int x, int y) {
    try {
      return x ~/ y;
    } catch (_) {
      throw Exception('Division by zero');
    }
  }

  Map<String, List<String>> userDefinedWords = {};

  void evaluate(String value) {
    List<String> characters = value.split(' ');

    if (characters.first == ':' && characters.last == ';') {
      final definition = characters..removeWhere((e) => e == ':' || e == ';');
      final value = [...definition]..removeAt(0);
      if (value.length == 1) {
        final newValue = userDefinedWords[value.first];
        userDefinedWords.addAll(
          {definition.first: newValue ?? value},
        );
      } else {
        userDefinedWords.addAll(
          {definition.first: value},
        );
      }
      return;
    }

    if (characters.any((e) => userDefinedWords.containsKey(e))) {
      for (final character in [...characters]) {
        if (userDefinedWords.containsKey(character)) {
          final value = userDefinedWords[character]!;
          final index = characters.indexWhere((e) => e == character);
          characters.replaceRange(index, index + 1, value);
        }
      }
    }

    for (final character in characters) {
      if (isNumber(character)) {
        final number = int.parse(character);
        stack.add(number);
      } else if (character.length > 1) {
        if (stack.isEmpty) throw Exception('Stack empty');

        switch (character) {
          case 'dup':
            stack.add(stack.last);
            break;
          case 'drop':
            stack.removeLast();
            break;
          case 'swap':
            if (stack.length < 2) throw Exception('Stack empty');
            final savedStack = [...stack];
            stack.removeRange(stack.length - 2, stack.length);
            stack.addAll([savedStack.last, savedStack[savedStack.length - 2]]);
            break;
          case 'over':
            if (stack.length < 2) throw Exception('Stack empty');
            if (stack.length < 3) {
              stack.add(stack.first);
            } else {
              stack.add(stack[stack.length - 2]);
            }
            break;
          default:
            throw UnimplementedError('$character is not implemented');
        }
      } else {
        if (characters.isEmpty || characters.length < 3) {
          throw Exception('Stack empty');
        }

        final savedStack = [...stack];
        stack.clear();

        switch (character) {
          case '+':
            stack.add(add(savedStack.first, savedStack.last));
            break;
          case '-':
            stack.add(subtract(savedStack.first, savedStack.last));
            break;
          case '*':
            print(stack);
            stack.add(multiply(savedStack.first, savedStack.last));
            break;
          case '/':
            stack.add(divide(savedStack.first, savedStack.last));
            break;
          default:
            throw UnimplementedError('$character is not implemented');
        }
      }
    }
  }
}
