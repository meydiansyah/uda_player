import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intermediate_udacoding/component/component_void.dart';
import 'package:intermediate_udacoding/service/const.dart';

class ComponentWidget {
  static Widget cardPopular(
          {
            String imgUrl,
            String userId,
            String videoId,
          String duration,
          String title,
          String like,
          String dislike,
            String imgChannel,
            Function onSelected,
          VoidCallback onTap,}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        height: Get.height / 1.8,
        child: Stack(
          children: [
            Container(
              height: Get.height / 1.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder:
                      (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        valueColor: AlwaysStoppedAnimation<Color>(GREEN),
                      )),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [
                        0,
                        0.8
                      ],
                      colors: [
                        Color(0xff091a10),
                        Color(0xff091a10).withOpacity(0.03),
                      ])),
            ),
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: onTap,
                splashColor: GREEN.withOpacity(0.1),
                highlightColor: GREEN.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(),
                      Column(
                        children: [
                          Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                child: Text(
                                  duration,
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                          Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CircleAvatar(
                                    backgroundColor: DARK_GREEN,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: CachedNetworkImage(
                                        imageUrl: imgChannel,
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) => Center(
                                            child: CircularProgressIndicator(
                                              value: downloadProgress.progress,
                                              strokeWidth: 2,
                                              valueColor: AlwaysStoppedAnimation<Color>(GREEN),
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
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.thumb_up,
                                          color: GREEN,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          like,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                          maxLines: 1,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.thumb_down,
                                          color: GREEN.withOpacity(0.4),
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          dislike,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuButton(
                                  icon: Icon(
                                    Icons.more_vert, color: Colors.white,),
                                  onSelected: onSelected,
                                  itemBuilder: (context) {
                                    var ls = List<PopupMenuEntry<Object>>();
                                    ls.add(PopupMenuItem(
                                      value: 1,
                                      child: Row(
                                        children: [
                                          Icon(Icons.access_time,
                                            color: DARK_GREEN,),
                                          SizedBox(width: 10),
                                          Text("Tonton nanti"),
                                        ],
                                      ),
                                    ));
                                    return ls;
                                  })
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget cardTopChannel(
          {String urlBanner, String imgUrl, String title, VoidCallback onTap}) =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
          children: [
            Container(
              height: Get.height / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: urlBanner,
                  fit: BoxFit.cover,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    valueColor: AlwaysStoppedAnimation<Color>(GREEN),
                  )),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [
                        0,
                        1
                      ],
                      colors: [
                        Color(0xff091a10),
                        Color(0xff091a10).withOpacity(0.02),
                      ])),
            ),
            Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: onTap,
                splashColor: GREEN.withOpacity(0.1),
                highlightColor: GREEN.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: DARK_GREEN,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl: imgUrl,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                      child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(GREEN),
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          title,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );

  static Widget lastOpen({@required List<Widget> view}) => Container(
        height: Get.height / 2.9,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.2, 0.7],
                colors: [Color(0xff11301f), Color(0xff091a10)])),
        padding: EdgeInsets.fromLTRB(15, 5, 15, 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Terakhir dibuka",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: GridView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: ClampingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 6 / 2),
                children: view,
              ),
            )
          ],
        ),
      );

  static BoxDecoration cardDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 10, color: Color(0xff017332), offset: Offset(3, 3))
          ]);

  static Widget logoUda() => Hero(
      tag: 'logoUdaPlayer',
      child: Image.asset(
        'assets/icon.png',
        width: 150,
      ));

  static Widget linearProgress() => Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: Get.width,
          child: LinearProgressIndicator(
            backgroundColor: Color(0xff017332).withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff017332)),
          ),
        ),
      );

  static Widget backgroundAuth() => SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color(0xff51EF94),
                const Color(0xff017332),
              ])),
        ),
      );
}
