import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intermediate_udacoding/page/auth/login.dart';
import 'package:intermediate_udacoding/page/home.dart';
import 'package:intermediate_udacoding/service/helper/storage.dart';

class Root extends GetWidget<UdaStorage> {
  @override
  Widget build(BuildContext context) {
    return Get.find<UdaStorage>().isLogin.value ? HomePage() : LoginPage();
  }
}
