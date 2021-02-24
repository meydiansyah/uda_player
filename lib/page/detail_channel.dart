import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:intermediate_udacoding/model/channel.dart';
import 'package:intermediate_udacoding/model/playlist.dart';
import 'package:intermediate_udacoding/model/playlist_item.dart';
import 'package:intermediate_udacoding/page/playlist_page.dart';
import 'package:intermediate_udacoding/service/api/fetch.dart';
import 'package:intermediate_udacoding/service/api/get.dart';
import 'package:intermediate_udacoding/service/config.dart';
import 'package:intermediate_udacoding/service/const.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailChannel extends StatefulWidget {
  String id;

  DetailChannel({this.id});

  @override
  _DetailChannelState createState() => _DetailChannelState();
}

class _DetailChannelState extends State<DetailChannel> {
  Config config = Get.put(Config());
  bool tapMore = false;
  Playlist detailPlaylist;

  getDetailPlaylist(String id) async {
    detailPlaylist = await GetApi.getPlaylist(channelId: id);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
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
              FutureBuilder<Channel>(
                future: GetApi.getDetailChannel(channelId: widget.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
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
                              ),
                              SliverList(
                                  delegate: SliverChildListDelegate([
                                Container(
                                  height: Get.height / 2.3,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: Get.height / 2.3,
                                        child: CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data
                                              .items[0]
                                              .brandingSettings
                                              .image
                                              .bannerExternalUrl,
                                          fit: BoxFit.cover,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                                  child:
                                                      CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    GREEN),
                                          )),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                                stops: [
                                              0,
                                              0.7
                                            ],
                                                colors: [
                                              Color(0xff091a10),
                                              Color(0xff091a10)
                                                  .withOpacity(0.02),
                                            ])),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(),
                                            Row(
                                              children: [
                                                Flexible(
                                                  flex: 2,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          DARK_GREEN,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: snapshot
                                                              .data
                                                              .items[0]
                                                              .snippet
                                                              .thumbnails
                                                              .medium
                                                              .url,
                                                          progressIndicatorBuilder:
                                                              (context, url,
                                                                      downloadProgress) =>
                                                                  Center(
                                                                      child:
                                                                          CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress,
                                                            strokeWidth: 2,
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    GREEN),
                                                          )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 10,
                                                ),
                                                Flexible(
                                                  flex: 12,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        snapshot.data.items[0]
                                                            .snippet.title,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "${snapshot.data.items[0].statistics.subscriberCount} subscriber",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                        maxLines: 2,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Material(
                                      type: MaterialType.transparency,
                                      child: ListTile(
                                        onTap: () =>
                                            setState(() => tapMore = !tapMore),
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
                                          15, 15, 15, 20),
                                      child: Linkify(
                                        text: snapshot
                                            .data.items[0].snippet.description,
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.6)),
                                        maxLines: tapMore ? 100 : 2,
                                        overflow: TextOverflow.ellipsis,
                                        linkStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                        options: LinkifyOptions(humanize: true),
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
                                    ),
                                    Divider(
                                      color: GREEN.withOpacity(0.3),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  child: Text(
                                    "Top Playlists",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                FutureBuilder<Playlist>(
                                  future:
                                      GetApi.getPlaylist(channelId: widget.id),
                                  builder: (context, snapshotPlaylist) {
                                    if (snapshotPlaylist.hasData) {
                                      return Column(
                                        children: snapshotPlaylist.data.items
                                            .map((data) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0),
                                            child: Material(
                                              type: MaterialType.transparency,
                                              child: ListTile(
                                                onTap: () => Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                      pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) =>
                                                          DetailPlaylist(
                                                        id: data.id,
                                                        imgChannel: snapshot
                                                            .data
                                                            .items[0]
                                                            .snippet
                                                            .thumbnails
                                                            .medium
                                                            .url,
                                                      ),
                                                      transitionsBuilder:
                                                          (context,
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
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(6),
                                                    bottomLeft:
                                                        Radius.circular(6),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: data.snippet
                                                        .thumbnails.medium.url,
                                                  ),
                                                ),
                                                title: Text(
                                                  data.snippet.title,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                subtitle: Text(
                                                  data.snippet.description,
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.6)),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                trailing: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 4),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color:
                                                        GREEN.withOpacity(0.6),
                                                  ),
                                                  child: FutureBuilder<
                                                      PlaylistItems>(
                                                    future: FetchApi
                                                        .fetchPlaylistItems(
                                                            playlistId:
                                                                data.id),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Text(
                                                            "${snapshot.data.items.length} videos");
                                                      } else {
                                                        return Text("0 Videos");
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    } else {
                                      return Center(
                                          child: Text("Memuat . . .",
                                              style: TextStyle(color: GREEN)));
                                    }
                                  },
                                )
                              ]))
                            ],
                          ),
                        ),
                      ),
                    );
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
