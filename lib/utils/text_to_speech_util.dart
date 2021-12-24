class TextToSpeechUtil {
  static String? vehicleToText(String? number) {
    if (number == null) {
      return null;
    }
    String text = '';
    final listNumber = number.split('');
    for (int i = 0; i < listNumber.length; i++) {
      if (listNumber[i] != '.') {
        text += listNumber[i];
        if (i != listNumber.length - 1) {
          text += ' ';
        }
      }
    }

    return text;
  }
}
