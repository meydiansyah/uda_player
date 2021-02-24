import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intermediate_udacoding/service/config.dart';
import 'package:intl/intl.dart';

class ComponentVoid {
  static Config config = Get.put(Config());

  static insertRecentOpens({String videoId, String userId}) async {
    await http.post(
        "http://192.168.100.3/intermediate_udacoding/insert/recent_opens.php",
        body: {
          'video_id': videoId,
          'user_id': userId,
        });
    config.recentOpens();
  }

  static insertWatchLater({String videoId, String userId}) async {
    await http.post(
        "http://192.168.100.3/intermediate_udacoding/insert/watch_later.php",
        body: {
          'video_id': videoId,
          'user_id': userId,
        });
    config.watchLater();
  }

  static removeWatchLater({String videoId, String userId}) async {
    await http.post(
        "http://192.168.100.3/intermediate_udacoding/delete/watch_later.php",
        body: {'video_id': videoId, 'user_id': userId});
    config.watchLater();
  }

  static saveVideo({String videoId, String userId}) async {
    await http.post(
        "http://192.168.100.3/intermediate_udacoding/insert/favorite_videos.php",
        body: {
          'video_id': videoId,
          'user_id': userId,
        });
  }

  static String countSubscriber(String subsCount) {
    int subs = int.parse(subsCount);
    var coba =
        new NumberFormat.currency(locale: 'id', symbol: '', decimalDigits: 0)
            .format(subs);
    String count = coba.toString();

    if (subs.toString().length > 6) {
      return "${count.substring(0, 3)} Jt";
    } else {
      return "${count.substring(0, 4)} Rb";
    }
  }
}
