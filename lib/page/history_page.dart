import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intermediate_udacoding/component/component_void.dart';
import 'package:intermediate_udacoding/model/recent_opens.dart';
import 'package:intermediate_udacoding/model/video.dart';
import 'package:intermediate_udacoding/page/detail_video.dart';
import 'package:intermediate_udacoding/service/api/get.dart';
import 'package:intermediate_udacoding/service/config.dart';
import 'package:intermediate_udacoding/service/const.dart';
import 'package:intermediate_udacoding/service/helper/storage.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Config config = Get.put(Config());
  UdaStorage storage = Get.put(UdaStorage());
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: Color(0xff091a10),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 0.1],
                      colors: [Color(0xff11301f), Color(0xff091a10)])),
            ),
          ),
          Obx(() => SafeArea(
                child: FutureBuilder<List<RecentOpens>>(
                  future: config.fetchRecentOpens.value,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ScrollConfiguration(
                        behavior: ScrollBehavior(),
                        child: GlowingOverscrollIndicator(
                          axisDirection: AxisDirection.down,
                          color: GREEN.withOpacity(0.1),
                          child: CustomScrollView(
                            physics: ClampingScrollPhysics(),
                            slivers: [
                              SliverAppBar(
                                brightness: Brightness.light,
                                floating: true,
                                titleSpacing: 10,
                                centerTitle: false,
                                backgroundColor: Color(0xff11301f),
                                title: Text(
                                  "Riwayat menonton",
                                  style: TextStyle(color: GREEN),
                                ),
                              ),
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return FutureBuilder<Video>(
                                      future: GetApi.getDetailVideo(
                                          videoId:
                                              snapshot.data[index].videoId),
                                      builder: (context, video) {
                                        if (video.hasData) {
                                          var data = video.data.items[0];
                                          return Material(
                                            type: MaterialType.transparency,
                                            child: Column(
                                              children: <Widget>[
                                                SizedBox(height: 5),
                                                ListTile(
                                                  onTap: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailVideo(
                                                                id: data.id,
                                                              ))),
                                                  title: Text(
                                                    data.snippet.title,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  trailing: PopupMenuButton(
                                                      icon: Icon(
                                                        Icons.more_vert,
                                                        color: Colors.white,
                                                      ),
                                                      onSelected: (value) {
                                                        switch (value) {
                                                          case 1:
                                                            bool cancel = false;
                                                            _globalKey
                                                                .currentState
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              content: Text(
                                                                  "Sedang menambahkan ke tonton nanti . ."),
                                                              action:
                                                                  SnackBarAction(
                                                                label: "undo",
                                                                onPressed: () =>
                                                                    cancel =
                                                                        true,
                                                              ),
                                                            ));
                                                            Future.delayed(
                                                                Duration(
                                                                    seconds: 4),
                                                                () {
                                                              if (!cancel) {
                                                                ComponentVoid.insertWatchLater(
                                                                    videoId:
                                                                        data.id,
                                                                    userId: storage
                                                                        .authStorage
                                                                        .read(
                                                                            'id'));
                                                                _globalKey.currentState
                                                                    .showSnackBar(SnackBar(
                                                                  content: Text(
                                                                      "Sukses menambahkan ke tonton nanti"),
                                                                ));
                                                              }
                                                            });
                                                            break;
                                                        }
                                                      },
                                                      itemBuilder: (context) {
                                                        var ls = List<
                                                            PopupMenuEntry<
                                                                Object>>();
                                                        ls.add(PopupMenuItem(
                                                          value: 1,
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .access_time,
                                                                color:
                                                                    DARK_GREEN,
                                                              ),
                                                              SizedBox(
                                                                  width: 10),
                                                              Text(
                                                                  "Tonton nanti"),
                                                            ],
                                                          ),
                                                        ));
                                                        return ls;
                                                      }),
                                                  leading: Container(
                                                    width: 80,
                                                    child: CachedNetworkImage(
                                                      imageUrl: data
                                                          .snippet
                                                          .thumbnails
                                                          .medium
                                                          .url,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                index < snapshot.data.length - 1
                                                    ? Divider(
                                                        height: 1,
                                                        color: Colors.white,
                                                      )
                                                    : Container()
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    );
                                  },
                                  childCount: snapshot.data.length,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(GREEN),
                        ),
                      );
                    }
                  },
                ),
              )),
        ],
      ),
    );
  }
}
