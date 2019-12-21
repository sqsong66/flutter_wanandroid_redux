import 'package:html/parser.dart' show parse;
import 'package:shared_preferences/shared_preferences.dart';

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

  static String removeHtmlTag(String html) {
    var document = parse(html);
    String parsedString = parse(document.body.text).documentElement.text;
    return parsedString;
  }

  static Future<bool> saveSearchKeyWord(String keyWord) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String keyString = prefs.getString("searchKey");
    String resultString = "";
    if (keyString == null || keyString.isEmpty) {
      resultString = keyWord;
    } else {
      var keyList = keyString.split("|");
      if (keyList.contains(keyWord)) {
        keyList.remove(keyWord);
      }
      keyList.insert(0, keyWord);
      if (keyList.length > 8) {
        keyList = keyList.sublist(0, 8);
      }
      for (int i = 0; i < keyList.length; i++) {
        if (i == keyList.length - 1) {
          resultString += keyList[i];
        } else {
          resultString += keyList[i] + "|";
        }
      }
    }
    return await prefs.setString("searchKey", resultString);
  }

  static Future<List<String>> loadSearchKeyWords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String keyString = prefs.getString("searchKey");
    if (keyString == null || keyString.isEmpty) return [];
    return keyString.split("|");
  }

  static Future<List<String>> deleteSearchKey(
      String keyWord, bool isClear) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String keyString = prefs.getString("searchKey");
    if (isClear) {
      prefs.setString("searchKey", "");
      return [];
    } else {
      var keyList = keyString.split("|");
      if (keyList.contains(keyWord)) {
        keyList.remove(keyWord);
      }
      if (keyList.isEmpty) {
        prefs.setString("searchKey", "");
        return [];
      }

      String resultString = "";
      for (int i = 0; i < keyList.length; i++) {
        if (i == keyList.length - 1) {
          resultString += keyList[i];
        } else {
          resultString += keyList[i] + "|";
        }
      }
      await prefs.setString("searchKey", resultString);
      return keyList;
    }
  }
}
