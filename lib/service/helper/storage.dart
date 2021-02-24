import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UdaStorage extends GetxController {
  final authStorage = GetStorage('authStorage');
  var isLogin = false.obs;
  var savedVIdeo = false.obs;

  @override
  void onInit() {
    checkAuth();
    super.onInit();
  }

  void checkAuth() {
    if (authStorage.read('isLogin') == null || !authStorage.read('isLogin')) {
      isLogin.value = false;
      authStorage.write('isLogin', false);
    } else {
      isLogin.value = true;
      authStorage.write('isLogin', true);
    }
    update();
  }

  void login() {
    isLogin.value = true;
    authStorage.write('isLogin', true);
    update();
  }

  void logOut() {
    isLogin.value = false;
    authStorage.write('isLogin', false);
  }
}
