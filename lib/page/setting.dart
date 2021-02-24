import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intermediate_udacoding/model/total_recent_opens.dart';
import 'package:intermediate_udacoding/page/history_page.dart';
import 'package:intermediate_udacoding/page/watch_later_page.dart';
import 'package:intermediate_udacoding/service/api/fetch.dart';
import 'package:intermediate_udacoding/service/const.dart';
import 'package:intermediate_udacoding/service/helper/storage.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  UdaStorage storage = Get.put(UdaStorage());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                      centerTitle: false,
                      backgroundColor: Color(0xff11301f),
                      actions: [
                        IconButton(
                            icon: Icon(
                              Icons.exit_to_app,
                              color: GREEN.withOpacity(0.4),
                            ),
                            onPressed: () async {
                              await showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  child: AlertDialog(
                                    title: Text("Keluar"),
                                    content: Text("Yakin ingin keluar ?"),
                                    actions: [
                                      FlatButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text(
                                          "Kembali",
                                          style: TextStyle(color: DARK_GREEN),
                                        ),
                                        splashColor:
                                            DARK_GREEN.withOpacity(0.2),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          storage.logOut();
                                          return Navigator.popUntil(context,
                                              (route) => route.isFirst);
                                        },
                                        child: Text(
                                          "Keluar",
                                          style: TextStyle(color: DARK_GREEN),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                            primary: GREEN),
                                      )
                                    ],
                                  ));
                            })
                      ],
                      title: Text(
                        "Pengaturan",
                        style: TextStyle(color: GREEN),
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      Material(
                        type: MaterialType.transparency,
                        child: Container(
                          padding: EdgeInsets.all(30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 8,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      storage.authStorage.read('username'),
                                      style: TextStyle(
                                          color: GREEN,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      storage.authStorage.read('email'),
                                      style: TextStyle(
                                          color: GREEN.withOpacity(0.6),
                                          fontSize: 25),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: GREEN.withOpacity(0.4),
                                ),
                                onPressed: () {
                                  _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                          content: Text("Dalam pengembangan")));
                                },
                                tooltip: 'Edit',
                              )
                            ],
                          ),
                        ),
                      ),
                      FutureBuilder<List<TotalRecentOpens>>(
                        future: FetchApi.fetchTotalRecent(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          } else {
                            if (snapshot.data.isEmpty) {
                              return Container();
                            } else {
                              List<double> listData = new List<double>();
                              var _min;
                              var _max;
                              for (var i in snapshot.data) {
                                listData.add(double.parse(i.totalHarian));

                                _min = listData.reduce(min);
                                _max = listData.reduce(max);
                              }
                              return Column(
                                children: [
                                  Divider(
                                    color: GREEN.withOpacity(0.3),
                                  ),
                                  _chart(
                                      min: 0,
                                      max: _max + 2,
                                      snapshot: snapshot),
                                  Divider(
                                    color: GREEN.withOpacity(0.3),
                                  ),
                                  Material(
                                    type: MaterialType.transparency,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        return Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HistoryPage()));
                                      },
                                      title: Text(
                                        "Riwayat menonton",
                                        style: TextStyle(color: GREEN),
                                      ),
                                      leading: Icon(
                                        Icons.history,
                                        color: GREEN.withOpacity(0.5),
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          }
                        },
                      ),
                      Divider(
                        color: GREEN.withOpacity(0.3),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: ListTile(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WatchLaterPage())),
                          title: Text(
                            "Tonton nanti",
                            style: TextStyle(color: GREEN),
                          ),
                          leading: Icon(
                            Icons.access_time_rounded,
                            color: GREEN.withOpacity(0.5),
                            size: 30,
                          ),
                        ),
                      ),
                    ]))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<TotalRecentOpens> recentOpens;

  Widget _chart({double max, double min, AsyncSnapshot snapshot}) =>
      SfCartesianChart(
        title: ChartTitle(
            text: "Total menonton", textStyle: TextStyle(color: Colors.white)),
        enableAxisAnimation: true,
        plotAreaBorderColor: GREEN,
        plotAreaBackgroundColor: DARK_GREEN.withOpacity(0.7),
        primaryXAxis: CategoryAxis(
            majorGridLines: MajorGridLines(width: 0),
            labelStyle: TextStyle(color: Colors.white),
            axisLine: AxisLine(color: GREEN),
            majorTickLines: MajorTickLines(size: 0, color: GREEN),
            labelPlacement: LabelPlacement.betweenTicks),
        primaryYAxis: NumericAxis(
            minimum: min,
            maximum: max,
            axisLine: AxisLine(color: GREEN),
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            labelFormat: '{value}',
            labelStyle: TextStyle(
              color: GREEN,
            ),
            majorTickLines: MajorTickLines(size: 0, color: Colors.white)),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          header: "Total",
        ),
        series: <CartesianSeries>[
          ColumnSeries<TotalRecentOpens, String>(
            dataSource: snapshot.data,
            color: GREEN,
            name: 'asd',
            xValueMapper: (TotalRecentOpens total, _) => total.createdAt,
            yValueMapper: (TotalRecentOpens total, _) =>
                int.parse(total.totalHarian),
          )
        ],
      );
}
