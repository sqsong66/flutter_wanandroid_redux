class CommonUtils {
  
  static String analysisFirstLetter(String first, String second) {
    String letter = "";
    if (first.isNotEmpty) {
      letter = first.substring(0, 1).toUpperCase();
    } else {
      if (second.isNotEmpty) {
        letter = second.substring(0, 1).toUpperCase();
      }
    }
    if (letter.isEmpty) {
      letter = "*";
    }
    return letter;
  }


}