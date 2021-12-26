import 'dart:math';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

class RandomUtil {
  static String getRandomString(int length) {
    Random rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(
          rnd.nextInt(
            _chars.length,
          ),
        ),
      ),
    );
  }
}
