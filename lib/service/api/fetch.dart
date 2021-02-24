import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intermediate_udacoding/model/favorite_video.dart';
import 'package:intermediate_udacoding/model/playlist_item.dart';
import 'package:intermediate_udacoding/model/recent_opens.dart';
import 'package:intermediate_udacoding/model/total_recent_opens.dart';
import 'package:intermediate_udacoding/model/video.dart';
import 'package:intermediate_udacoding/model/watch_later.dart';
import 'package:intermediate_udacoding/service/const.dart';
import 'package:intermediate_udacoding/service/helper/storage.dart';
import 'package:path_provider/path_provider.dart';

class FetchApi {
  static UdaStorage storage = Get.put(UdaStorage());

  static Future<Video> fetchVideoCategories() async {
    Map<String, String> param = {
      'part': 'snippet, statistics, contentDetails',
      'chart': 'mostPopular',
      'hl': 'id',
      'maxResults': '50',
      'regionCode': 'id',
      'videoCategoryId': '27',
      'key': API_KEY
    };

    Uri uri = Uri.https('www.googleapis.com', '/youtube/v3/videos', param);

    http.Response response = await http.get(uri, headers: headers);

    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/listVideoCategories.json");
    Video video;

    if (file.existsSync()) {
      var jsonData = file.readAsStringSync();
      video = videoFromJson(jsonData);
    } else {
      video = videoFromJson(response.body);
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
    }
    return video;
  }

  static Future<PlaylistItems> fetchPlaylistItems({String playlistId}) async {
    Map<String, String> param = {
      'part': 'snippet, contentDetails',
      'playlistId': playlistId,
      'maxResults': '100',
      'key': API_KEY
    };

    Uri uri =
        Uri.https('www.googleapis.com', '/youtube/v3/playlistItems', param);

    http.Response response = await http.get(uri, headers: headers);

    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/listPlaylist-$playlistId.json");
    PlaylistItems playlist;

    if (file.existsSync()) {
      var jsonData = file.readAsStringSync();
      playlist = playlistItemsFromJson(jsonData);
    } else {
      playlist = playlistItemsFromJson(response.body);
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
    }
    return playlist;
  }

  static Future<List<TotalRecentOpens>> fetchTotalRecent() async {
    final response = await http.post(
        "http://192.168.100.3/intermediate_udacoding/show/total_recent_opens.php",
        body: {"user_id": storage.authStorage.read('id')});
    if (response.statusCode == 200) {
      List resp = json.decode(response.body);
      return resp.map((rec) => TotalRecentOpens.fromJson(rec)).toList();
    } else {
      throw Exception('Failed to load data');
      ;
    }
  }

  static Future<List<FavoriteVideo>> fetchFavoriteVideo() async {
    final response = await http.post(
        "http://192.168.100.3/intermediate_udacoding/show/favorite_videos.php",
        body: {"user_id": storage.authStorage.read('id')});
    if (response.statusCode == 200) {
      List resp = json.decode(response.body);
      return resp.map((fav) => FavoriteVideo.fromJson(fav)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<RecentOpens>> fetchRecentOpens() async {
    final response = await http.post(
        "http://192.168.100.3/intermediate_udacoding/show/recent_opens.php",
        body: {"user_id": storage.authStorage.read('id')});
    if (response.statusCode == 200) {
      List resp = json.decode(response.body);
      return resp.map((rec) => RecentOpens.fromJson(rec)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<List<WatchLater>> fetchWatchLater() async {
    final response = await http.post(
        "http://192.168.100.3/intermediate_udacoding/show/watch_later.php",
        body: {"user_id": storage.authStorage.read('id')});
    if (response.statusCode == 200) {
      List resp = json.decode(response.body);
      return resp.map((rec) => WatchLater.fromJson(rec)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
