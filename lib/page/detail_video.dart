import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:intermediate_udacoding/component/component_void.dart';
import 'package:intermediate_udacoding/model/channel.dart';
import 'package:intermediate_udacoding/model/video.dart';
import 'package:intermediate_udacoding/page/detail_channel.dart';
import 'package:intermediate_udacoding/service/api/get.dart';
import 'package:intermediate_udacoding/service/const.dart';
import 'package:intermediate_udacoding/service/helper/storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailVideo extends StatefulWidget {
  String id;

  DetailVideo({this.id});

  @override
  _DetailVideoState createState() => _DetailVideoState();
}

class _DetailVideoState extends State<DetailVideo> {
  YoutubePlayerController youtubePlayerController;
  UdaStorage storage = Get.put(UdaStorage());
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  bool tapMore = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    youtubePlayerController = YoutubePlayerController(
        initialVideoId: widget.id,
        flags: YoutubePlayerFlags(
          mute: false,
          autoPlay: true,
          loop: true,
        ));

    Future.delayed(Duration(seconds: 3), () {
      ComponentVoid.insertRecentOpens(
          videoId: widget.id, userId: storage.authStorage.read('id'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
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
              FutureBuilder<Video>(
                future: GetApi.getDetailVideo(videoId: widget.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.items == null) {
                      return SafeArea(
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
                                  titleSpacing: 0,
                                  centerTitle: false,
                                  backgroundColor: Color(0xff11301f),
                                  title: Text(
                                    "Data missing",
                                    style: TextStyle(color: GREEN),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SliverList(
                                    delegate: SliverChildListDelegate([
                                  Container(
                                    height: Get.height,
                                    width: Get.width,
                                    child: Center(
                                      child: Text(
                                        "Data is null",
                                        style: TextStyle(
                                            fontSize: 25, color: GREEN),
                                      ),
                                    ),
                                  )
                                ]))
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SafeArea(
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
                                  titleSpacing: 0,
                                  centerTitle: false,
                                  backgroundColor: Color(0xff11301f),
                                  title: Text(
                                    snapshot.data.items[0].snippet.title,
                                    style: TextStyle(color: GREEN),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  actions: [
                                    PopupMenuButton(
                                        icon: Icon(
                                          Icons.more_vert,
                                          color: Colors.white,
                                        ),
                                        onSelected: (value) {
                                          switch (value) {
                                            case 1:
                                              bool cancel = false;
                                              _globalKey.currentState
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Sedang menambahkan ke tonton nanti . ."),
                                                action: SnackBarAction(
                                                  label: "undo",
                                                  onPressed: () =>
                                                      cancel = true,
                                                ),
                                              ));
                                              Future.delayed(
                                                  Duration(seconds: 4), () {
                                                if (!cancel) {
                                                  ComponentVoid
                                                      .insertWatchLater(
                                                          videoId: widget.id,
                                                          userId: storage
                                                              .authStorage
                                                              .read('id'));
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
                                          var ls =
                                              List<PopupMenuEntry<Object>>();
                                          ls.add(PopupMenuItem(
                                            value: 1,
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  color: DARK_GREEN,
                                                ),
                                                SizedBox(width: 10),
                                                Text("Tonton nanti"),
                                              ],
                                            ),
                                          ));
                                          return ls;
                                        })
                                  ],
                                ),
                                SliverList(
                                    delegate: SliverChildListDelegate([
                                  Container(
                                    height: Get.height / 2.3,
                                    child: YoutubePlayer(
                                      controller: youtubePlayerController,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Material(
                                        type: MaterialType.transparency,
                                        child: ListTile(
                                          onTap: () => setState(
                                              () => tapMore = !tapMore),
                                          title: Text(
                                            "Deskripsi",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          trailing: Icon(
                                            tapMore
                                                ? Icons.arrow_drop_up
                                                : Icons.arrow_drop_down,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Divider(
                                        color: GREEN.withOpacity(0.3),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            15, 5, 15, 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: GREEN
                                                            .withOpacity(0.3)),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 10),
                                                    child: Text(
                                                      "${snapshot.data.items[0].statistics.likeCount} disukai",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        color: GREEN
                                                            .withOpacity(0.3)),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 10),
                                                    child: Text(
                                                      "${snapshot.data.items[0].statistics.dislikeCount} tidak disukai",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15),
                                              child: Text(
                                                  snapshot.data.items[0].snippet
                                                      .title,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20)),
                                            ),
                                            Linkify(
                                              text: snapshot.data.items[0]
                                                  .snippet.description,
                                              style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.6)),
                                              maxLines: tapMore ? 100 : 2,
                                              overflow: TextOverflow.ellipsis,
                                              linkStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              options: LinkifyOptions(
                                                  humanize: true),
                                              onOpen: (link) async {
                                                print(link.url);
                                                if (await canLaunch(link.url)) {
                                                  print(link.url);
                                                  await launch(link.url);
                                                } else {
                                                  print("error");
                                                  throw 'Could not launch $link';
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: GREEN.withOpacity(0.3),
                                      ),
                                    ],
                                  ),
                                  FutureBuilder<Channel>(
                                    future: GetApi.getDetailChannel(
                                        channelId: snapshot
                                            .data.items[0].snippet.channelId),
                                    builder: (context, channel) {
                                      if (channel.hasData) {
                                        return Material(
                                          type: MaterialType.transparency,
                                          child: ListTile(
                                            onTap: () => Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      DetailChannel(
                                                          id: channel.data
                                                              .items[0].id),
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
                                                          curve: Curves
                                                              .fastOutSlowIn,
                                                        ),
                                                      ),
                                                      child: child,
                                                    );
                                                  },
                                                )),
                                            leading: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: CircleAvatar(
                                                backgroundColor: DARK_GREEN,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: CachedNetworkImage(
                                                    imageUrl: channel
                                                        .data
                                                        .items[0]
                                                        .snippet
                                                        .thumbnails
                                                        .medium
                                                        .url,
                                                    progressIndicatorBuilder: (context,
                                                            url,
                                                            downloadProgress) =>
                                                        Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                      value: downloadProgress
                                                          .progress,
                                                      strokeWidth: 2,
                                                      valueColor:
                                                          AlwaysStoppedAnimation<
                                                              Color>(GREEN),
                                                    )),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              channel
                                                  .data.items[0].snippet.title,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            subtitle: Text(
                                              "${channel.data.items[0].statistics.subscriberCount} subscribers",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white
                                                      .withOpacity(0.6)),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                  Divider(
                                    color: GREEN.withOpacity(0.3),
                                  ),
                                ]))
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(GREEN),
                    ));
                  }
                },
              ),
            ],
          )),
    );
  }
}
