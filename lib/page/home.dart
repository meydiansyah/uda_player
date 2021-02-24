import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intermediate_udacoding/component/component_void.dart';
import 'package:intermediate_udacoding/component/component_widget.dart';
import 'package:intermediate_udacoding/model/channel.dart';
import 'package:intermediate_udacoding/model/video.dart';
import 'package:intermediate_udacoding/page/detail_channel.dart';
import 'package:intermediate_udacoding/page/detail_video.dart';
import 'package:intermediate_udacoding/page/root.dart';
import 'package:intermediate_udacoding/page/setting.dart';
import 'package:intermediate_udacoding/service/api/get.dart';
import 'package:intermediate_udacoding/service/config.dart';
import 'package:intermediate_udacoding/service/const.dart';
import 'package:intermediate_udacoding/service/helper/storage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Config config = Get.put(Config());
  UdaStorage storage = Get.put(UdaStorage());
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => false,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          key: _globalKey,
            backgroundColor: Color(0xff091a10),
            body: Obx(() {
              if(!storage.isLogin.value) Future.delayed(Duration(milliseconds: 100), () {
                return Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Root()));
              });
              return Stack(
                children: [
                  SizedBox.expand(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [
                                0,
                                0.1
                              ],
                              colors: [
                                Color(0xff11301f),
                                Color(0xff091a10)
                              ])),
                    ),
                  ),
                  SafeArea(
                    child: ScrollConfiguration(
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
                              backgroundColor: Color(0xff11301f),
                              title: Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                    child: ComponentWidget.logoUda(),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Uda Player",
                                    style: TextStyle(color: GREEN),
                                  )
                                ],
                              ),
                              actions: [
                                IconButton(
                                  icon: Icon(Icons.settings),
                                  tooltip: 'Settings',
                                  onPressed: () => Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                            SettingsPage(),
                                        transitionsBuilder: (context,
                                            animation,
                                            secondaryAnimation,
                                            child) {
                                          return ScaleTransition(
                                            scale: Tween<double>(
                                              begin: 0.0,
                                              end: 1.0,
                                            ).animate(
                                              CurvedAnimation(
                                                parent: animation,
                                                curve: Curves.fastOutSlowIn,
                                              ),
                                            ),
                                            child: child,
                                          );
                                        },
                                      )),
                                  color: GREEN.withOpacity(0.5),
                                )
                              ],
                            ),
                            SliverFixedExtentList(delegate: SliverChildListDelegate([
                              config.isLoad.value ? ComponentWidget.linearProgress() : Container(),
                            ]), itemExtent: 3),
                            SliverList(
                                delegate: SliverChildListDelegate([
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 15),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text(
                                            "Top Channel",
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: Get.height / 3,
                                          child: PageView(
                                            children:
                                            config.listChannel.map((data) {
                                              if (data.items != null) {
                                                return ComponentWidget
                                                    .cardTopChannel(
                                                    urlBanner: data
                                                        .items[0]
                                                        .brandingSettings
                                                        .image
                                                        .bannerExternalUrl,
                                                    title: data.items[0]
                                                        .snippet.title,
                                                    imgUrl: data
                                                        .items[0]
                                                        .snippet
                                                        .thumbnails
                                                        .medium
                                                        .url,
                                                    onTap: () =>
                                                        Navigator.push(
                                                            context,
                                                            PageRouteBuilder(
                                                              pageBuilder: (context,
                                                                  animation,
                                                                  secondaryAnimation) =>
                                                                  DetailChannel(
                                                                    id: data
                                                                        .items[0]
                                                                        .id,
                                                                  ),
                                                              transitionsBuilder:
                                                                  (context,
                                                                  animation,
                                                                  secondaryAnimation,
                                                                  child) {
                                                                return ScaleTransition(
                                                                  scale: Tween<
                                                                      double>(
                                                                    begin:
                                                                    0.0,
                                                                    end: 1.0,
                                                                  ).animate(
                                                                    CurvedAnimation(
                                                                      parent:
                                                                      animation,
                                                                      curve: Curves
                                                                          .fastOutSlowIn,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                  child,
                                                                );
                                                              },
                                                            )));
                                              } else {
                                                return Container();
                                              }
                                            }).toList(),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 15, top: 15),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Text(
                                            "Popular",
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        FutureBuilder<Video>(
                                          future: config.fetchVideoCategory.value,
                                          builder: (context, snapshot) {
                                            if (snapshot.data != null) {
                                              return Column(
                                                children: snapshot.data.items
                                                    .map((data) {
                                                  if (data == null) {
                                                    return Container();
                                                  }
                                                  var _duration = data
                                                      .contentDetails.duration;

                                                  var duration =
                                                  _duration.replaceFirst(
                                                      RegExp('PT'), '', 0);
                                                  duration =
                                                      duration.replaceFirst(
                                                          RegExp('H'), ':', 0);
                                                  duration =
                                                      duration.replaceFirst(
                                                          RegExp('M'), ':', 0);
                                                  duration =
                                                      duration.replaceFirst(
                                                          RegExp('S'), '', 0);

                                                  var last = duration.substring(
                                                      duration.length - 1);
                                                  if (last == ':') {
                                                    duration =
                                                        duration.replaceFirst(
                                                            RegExp(':'),
                                                            '',
                                                            duration.length - 1);
                                                  }
                                                  return FutureBuilder<Channel>(
                                                    future:
                                                    GetApi.getDetailChannel(
                                                        channelId: data
                                                            .snippet
                                                            .channelId),
                                                    builder: (context, channel) {
                                                      if (channel.hasData) {
                                                        return ComponentWidget
                                                            .cardPopular(
                                                            userId: storage.authStorage.read('id'),
                                                          onSelected: (value) {
                                                            switch (value) {
                                                              case 1:
                                                                bool cancel = false;
                                                                _globalKey.currentState.showSnackBar(SnackBar(content: Text("Sedang menambahkan ke tonton nanti . ."), action: SnackBarAction(label: "undo", onPressed: () => cancel = true,),));
                                                                Future.delayed(Duration(seconds: 4), () {
                                                                  if(!cancel) {
                                                                    ComponentVoid.insertWatchLater(videoId: data.id, userId: storage.authStorage.read('id'));
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
                                                          videoId: data.id,
                                                            imgUrl: data
                                                                .snippet
                                                                .thumbnails
                                                                .medium
                                                                .url,
                                                            duration:
                                                            duration,
                                                            imgChannel: channel
                                                                .data
                                                                .items[0]
                                                                .snippet
                                                                .thumbnails
                                                                .medium
                                                                .url,
                                                            title: data
                                                                .snippet
                                                                .title,
                                                            like: data
                                                                .statistics
                                                                .likeCount,
                                                            dislike: data
                                                                .statistics
                                                                .dislikeCount,
                                                            onTap: () => Navigator.push(
                                                                  context,
                                                                  PageRouteBuilder(
                                                                    pageBuilder: (context,
                                                                        animation,
                                                                        secondaryAnimation) =>
                                                                        DetailVideo(
                                                                          id: data
                                                                              .id,
                                                                        ),
                                                                    transitionsBuilder: (context,
                                                                        animation,
                                                                        secondaryAnimation,
                                                                        child) {
                                                                      return ScaleTransition(
                                                                        scale:
                                                                        Tween<double>(
                                                                          begin: 0.0,
                                                                          end: 1.0,
                                                                        ).animate(
                                                                          CurvedAnimation(
                                                                            parent: animation,
                                                                            curve: Curves.fastOutSlowIn,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                        child,
                                                                      );
                                                                    },
                                                                  )));
                                                      } else {
                                                        return Container();
                                                      }
                                                    },
                                                  );
                                                }).toList(),
                                              );
                                            } else {
                                              return Container();
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ]))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            })),
      ),
    );
  }
}