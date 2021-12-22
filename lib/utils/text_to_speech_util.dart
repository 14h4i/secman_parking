class TextToSpeechUtil {
  static String? vehicleToText(String? number) {
    if (number == null) {
      return null;
    }
    String text = '';
    final listNumber = number.split('');
    for (int i = 0; i < listNumber.length; i++) {
      text += listNumber[i];
      if (i != listNumber.length - 1) {
        if (listNumber[i + 1] != "." && listNumber[i] != ".") {
          text += ' ';
        }
      }
    }

    return text;
  }
}
