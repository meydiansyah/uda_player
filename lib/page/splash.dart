import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intermediate_udacoding/component/component_void.dart';
import 'package:intermediate_udacoding/component/component_widget.dart';
import 'package:intermediate_udacoding/page/root.dart';
import 'package:intermediate_udacoding/service/helper/storage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  UdaStorage storage = Get.put(UdaStorage());
  AnimationController controller;
  Animation animation;
  Animation<Color> changeColor;

  initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    setProgressIndicator();
  }

  setProgressIndicator() {
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2500), vsync: this);

    animation = new Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          return Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => Root(),
                transitionDuration: Duration(milliseconds: 1500),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
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
              ));
        }
      });
    controller.forward(from: 0);

    changeColor = ColorTween(
      begin: Colors.white,
      end: Color(0xff51EF94),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.23,
        0.83,
        curve: Curves.linear,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: Get.width,
              child: LinearProgressIndicator(
                value: animation.value,
                valueColor: changeColor,
                minHeight: 5,
                backgroundColor: Color(0xff88FFBA).withOpacity(0.5),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                    tag: 'logoUdaPlayer',
                    child: Image.asset(
                      'assets/icon.png',
                      width: 200,
                    )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Uda Player",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
