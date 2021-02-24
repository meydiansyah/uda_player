import 'dart:async';

import 'package:get/get.dart';
import 'package:intermediate_udacoding/model/channel.dart';
import 'package:intermediate_udacoding/model/recent_opens.dart';
import 'package:intermediate_udacoding/model/video.dart';
import 'package:intermediate_udacoding/model/watch_later.dart';
import 'package:intermediate_udacoding/service/api/fetch.dart';
import 'package:intermediate_udacoding/service/api/get.dart';

class Config extends GetxController {
  var isLoad = true.obs;
  Channel channel;

  List<Channel> listChannel = new List<Channel>().obs;
  var fetchVideoCategory = Future.value(Video()).obs;
  var fetchRecentOpens = Future.value(<RecentOpens>[]).obs;
  var fetchWatchLater = Future.value(<WatchLater>[]).obs;

  List channelId = [
    "UCkXmLjEr95LVtGuIm3l2dPg",
    "UC14ZKB9XsDZbnHVmr4AmUpQ",
    "UCW5YeuERMmlnqo4oq8vwUpg",
    "UCu0yQD7NFMyLu_-TmKa4Hqg",
  ].obs;

  @override
  void onInit() {
    fetchData();
    fetchVideo();
    fetchVideo();
    recentOpens();
    watchLater();
    super.onInit();
  }

  fetchData() async {
    try {
      isLoad.value = true;
      for (var i in channelId) {
        channel = await GetApi.getDetailChannel(channelId: i);
        listChannel.add(channel);

        await GetApi.getPlaylist(channelId: i);
      }

      listChannel.sort((b, a) =>
          int.parse(a.items[0].statistics.subscriberCount)
              .compareTo(int.parse(b.items[0].statistics.subscriberCount)));
    } finally {
      isLoad.value = false;
    }
    update();
  }

  void fetchVideo() {
    fetchVideoCategory.value = FetchApi.fetchVideoCategories();
  }

  void recentOpens() {
    fetchRecentOpens.value = FetchApi.fetchRecentOpens();
  }

  void watchLater() {
    fetchWatchLater.value = FetchApi.fetchWatchLater();
  }
}
