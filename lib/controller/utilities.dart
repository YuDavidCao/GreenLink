import 'package:profanity_filter/profanity_filter.dart';
import 'package:timeago/timeago.dart' as timeago;

class Utilities {
  static bool hasProfanity(String text) {
    final filter = ProfanityFilter();
    return filter.hasProfanity(text);
  }

  static bool arrayContain(List<String> arr1, List<String> arr2) {
    final int l1 = arr1.length;
    final int l2 = arr2.length;
    for (int i = 0; i < l2; i++) {
      bool containValue = false;
      for (int f = 0; f < l1; f++) {
        if (arr1[f] == arr2[i]) {
          containValue = true;
          break;
        }
      }
      if (!containValue) {
        return false;
      }
    }
    return true;
  }

  static String convertToTimeAgo(DateTime time) {
    return timeago.format(time);
  }

  static String twoSideConvertTimeAgo(DateTime time) {
    if (DateTime.now().isBefore(time)) {
      String formatted = timeago.format(DateTime.now(), clock: time);
      return "${formatted.substring(0, formatted.length - 4)} later";
    } else {
      return timeago.format(time);
    }
  }
}
