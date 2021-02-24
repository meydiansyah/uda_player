import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:intermediate_udacoding/model/channel.dart';
import 'package:intermediate_udacoding/model/playlist.dart';
import 'package:intermediate_udacoding/model/video.dart';
import 'package:intermediate_udacoding/service/api/fetch.dart';
import 'package:intermediate_udacoding/service/const.dart';
import 'package:path_provider/path_provider.dart';

class GetApi {
  static Future<Playlist> getPlaylist({String channelId}) async {
    Map<String, String> param = {
      'part': 'snippet',
      'channelId': channelId,
      'maxResults': '100',
      'key': API_KEY
    };

    Uri uri = Uri.https('www.googleapis.com', '/youtube/v3/playlists', param);

    http.Response response = await http.get(uri, headers: headers);

    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/listPlaylist-$channelId.json");
    Playlist playlist;

    if (file.existsSync()) {
      var jsonData = file.readAsStringSync();
      playlist = playlistFromJson(jsonData);
    } else {
      playlist = playlistFromJson(response.body);
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
    }
    await FetchApi.fetchPlaylistItems(playlistId: playlist.items[0].id);
    return playlist;
  }

  static Future<Channel> getDetailChannel({String channelId}) async {
    Map<String, String> param = {
      'part': 'snippet, brandingSettings, statistics',
      'id': channelId,
      'key': API_KEY
    };

    Uri uri = Uri.https('www.googleapis.com', '/youtube/v3/channels', param);

    http.Response response = await http.get(uri, headers: headers);

    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/detailChannel-$channelId.json");
    Channel channel;

    if (file.existsSync()) {
      var jsonData = file.readAsStringSync();
      channel = channelFromJson(jsonData);
    } else {
      channel = channelFromJson(response.body);
      file.writeAsStringSync(response.body, flush: true, mode: FileMode.write);
    }
    return channel;
  }

  static Future<Video> getDetailVideo({String videoId}) async {
    Map<String, String> param = {
      'part': 'snippet, statistics, contentDetails',
      'id': videoId,
      'key': API_KEY
    };

    Uri uri = Uri.https('www.googleapis.com', '/youtube/v3/videos', param);

    http.Response response = await http.get(uri, headers: headers);

    var dir = await getTemporaryDirectory();
    File file = new File("${dir.path}/video-$videoId.json");

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
}
