import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intermediate_udacoding/component/component_void.dart';
import 'package:intermediate_udacoding/model/video.dart';
import 'package:intermediate_udacoding/model/watch_later.dart';
import 'package:intermediate_udacoding/page/detail_video.dart';
import 'package:intermediate_udacoding/service/api/get.dart';
import 'package:intermediate_udacoding/service/config.dart';
import 'package:intermediate_udacoding/service/const.dart';
import 'package:intermediate_udacoding/service/helper/storage.dart';

class WatchLaterPage extends StatefulWidget {
  @override
  _WatchLaterPageState createState() => _WatchLaterPageState();
}

class _WatchLaterPageState extends State<WatchLaterPage> {
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
            child: FutureBuilder<List<WatchLater>>(
              future: config.fetchWatchLater.value,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
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
                            title: Text("Tonton nanti", style: TextStyle(color: GREEN),),
                          ),
                          SliverList(delegate: SliverChildListDelegate([
                            snapshot.data.isBlank ? Container(
                              height: Get.height,
                              width: Get.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.access_time, color: GREEN, size: 100,),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 30),
                                    child: Text("Daftar Tonton nanti masih kosong", style: TextStyle(color: GREEN, fontSize: 30), textAlign: TextAlign.center,),
                                  )
                                ],
                              ),
                            ) : Container()

                        ])),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) {
                                    return FutureBuilder<Video>(
                                  future: GetApi.getDetailVideo(videoId: snapshot.data[index].videoId),
                                  builder: (context, video) {
                                    if(video.hasData) {
                                      var data = video.data.items[0];
                                      return Material(
                                        type: MaterialType.transparency,
                                        child: Column(
                                          children: <Widget>[
                                            SizedBox(height: 5),
                                            ListTile(
                                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailVideo(id: data.id,))),
                                              title: Text(data.snippet.title, style: TextStyle(color: Colors.white), maxLines: 2, overflow: TextOverflow.ellipsis,),
                                              trailing: PopupMenuButton(
                                                  icon: Icon(Icons.more_vert,
                                                    color: Colors.white,),
                                                  onSelected: (value) {
                                                    switch (value) {
                                                      case 1:
                                                        bool cancel = false;
                                                        _globalKey.currentState
                                                            .showSnackBar(
                                                            SnackBar(
                                                              content: Text(
                                                                  "Sedang proses hapus data dari tonton nanti"),
                                                              action: SnackBarAction(
                                                                label: "undo",
                                                                onPressed: () =>
                                                                cancel =
                                                                true,),));
                                                        Future.delayed(Duration(
                                                            seconds: 4), () {
                                                          if (!cancel) {
                                                            ComponentVoid
                                                                .removeWatchLater(
                                                                videoId: snapshot
                                                                    .data[index]
                                                                    .videoId,
                                                                userId: storage
                                                                    .authStorage
                                                                    .read(
                                                                    'id'));
                                                            print("Success");
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
                                                            Icons.remove_circle,
                                                            color: DARK_GREEN,),
                                                          SizedBox(width: 10),
                                                          Text(
                                                              "Hapus tonton nanti"),
                                                        ],
                                                      ),
                                                    ));
                                                    return ls;
                                                  }),
                                              leading: Container(width: 80, child: CachedNetworkImage(
                                                imageUrl: data.snippet.thumbnails.medium.url,
                                              ),),
                                            ),
                                            SizedBox(height: 5),
                                            index < snapshot.data.length-1 ? Divider(height: 1, color: Colors.white,) : Container()
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
                  return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(GREEN),),);
                }
              },
            ),
          )),
        ],
      ),
    );
  }
}
