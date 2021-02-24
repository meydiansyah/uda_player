import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intermediate_udacoding/component/component_widget.dart';
import 'package:intermediate_udacoding/page/auth/register.dart';
import 'package:intermediate_udacoding/page/root.dart';
import 'package:intermediate_udacoding/service/const.dart';
import 'package:intermediate_udacoding/service/helper/storage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UdaStorage storage = Get.put(UdaStorage());
  bool focusPassword = false;
  bool focusUsername = true;
  bool showProgress = false;
  bool _showPassword = false;

  bool trueUsername = false;
  bool truePassword = false;

  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
          body: Stack(
        children: [
          ComponentWidget.backgroundAuth(),
          _buttonLogin(),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.only(top: Get.height / 3.5),
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                height: Get.height / 2.3,
                decoration: ComponentWidget.cardDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      showProgress
                          ? ComponentWidget.linearProgress()
                          : Container(),
                      Container(
                        margin: EdgeInsets.only(top: Get.height / 35),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: DARK_GREEN),
                            ),
                            Text(
                              "Masuk dengan username dan password yang telah didaftarkan",
                              style: TextStyle(color: DARK_GREEN),
                            ),
                            formField(
                                autoFocus: true,
                                controller: usernameController,
                                obscureText: false,
                                title: 'username'),
                            formField(
                                autoFocus: false,
                                controller: passwordController,
                                obscureText: _showPassword ? false : true,
                                title: 'password'),
                            Align(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  setState(() => showProgress = false);
                                  usernameController.clear();
                                  passwordController.clear();

                                  return Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            RegisterPage(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
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
                                },
                                splashColor: Colors.transparent,
                                child: Text(
                                  "Belum punya akun ?",
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: Get.height / 10),
              child: ComponentWidget.logoUda(),
            ),
          )
        ],
      )),
    );
  }

  Widget _buttonLogin() {
    bool validate() {
      if (trueUsername && truePassword) {
        return true;
      } else
        return false;
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: Get.width,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: validate() ? Color(0xff003617) : Colors.grey,
            boxShadow: validate()
                ? [
                    BoxShadow(
                        color: Color(0xff00240f),
                        blurRadius: 10,
                        offset: Offset(0, 2))
                  ]
                : null),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: validate()
                  ? () {
                      setState(() => showProgress = true);
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Future.delayed(
                            Duration(milliseconds: 3500),
                            () => Navigator.pushReplacement(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    storage.login();
                                    return Root();
                                  },
                                  transitionDuration:
                                      Duration(milliseconds: 2000),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return child;
                                  },
                                )));
                      });
                    }
                  : null,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              )),
        ),
      ),
    );
  }

  Widget formField(
      {@required TextEditingController controller,
      @required bool autoFocus,
      bool obscureText,
      String title}) {
    bool hintError = false;

    error() {
      if (title == 'username' && !focusUsername) {
        if (controller.text.isEmpty) {
          return true;
        } else {
          if (trueUsername) {
            return false;
          } else {
            return true;
          }
        }
      } else if (truePassword && !focusPassword) {
        if (controller.text.isEmpty) {
          return true;
        } else {
          if (truePassword) {
            return false;
          } else {
            return true;
          }
        }
      } else
        return false;
    }

    hintText() {
      if (controller.text.isEmpty) {
        if (!focusUsername) {
          if (error())
            return "masukkan username";
          else
            return title;
        } else if (!focusPassword) {
          if (error())
            return "masukkan password";
          else
            return title;
        }
      } else
        return title;
    }

    showError() {
      if (title == 'username') {
        if (controller.text.length > 0 && !trueUsername) {
          return Text(
            "username tidak terdaftar",
            style: TextStyle(color: ERROR),
          );
        } else {
          return Container();
        }
      } else {
        if (controller.text.length > 0 && !truePassword) {
          return Text(
            "password tidak terdaftar",
            style: TextStyle(color: ERROR),
          );
        } else {
          return Container();
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(color: error() ? ERROR : DARK_GREEN),
                borderRadius: BorderRadius.circular(4),
                color: error() ? ERROR.withOpacity(0.05) : null),
            child: TextFormField(
              onChanged: (val) async {
                var resp = await http.post(
                    "http://192.168.100.3/intermediate_udacoding/login.php",
                    body: {
                      'username': usernameController.text,
                      'password': passwordController.text
                    });

                final data = json.decode(resp.body);

                if (title == 'username') {
                  if (data['value'] == 2) {
                    storage.authStorage.write('id', data['id']);
                    storage.authStorage.write('username', data['username']);
                    storage.authStorage.write('email', data['email']);
                    storage.authStorage.write('created_at', data['created_at']);
                    setState(() {
                      truePassword = true;
                      trueUsername = true;
                      hintError = false;
                    });
                  } else if (data['value'] == 3) {
                    setState(() {
                      truePassword = false;
                      trueUsername = true;
                      hintError = false;
                    });
                  } else {
                    setState(() {
                      trueUsername = false;
                      truePassword = false;
                      hintError = true;
                    });
                  }
                } else {
                  if (data['value'] == 2) {
                    storage.authStorage.write('id', data['id']);
                    storage.authStorage.write('username', data['username']);
                    storage.authStorage.write('email', data['email']);
                    storage.authStorage.write('created_at', data['created_at']);
                    setState(() {
                      trueUsername = true;
                      truePassword = true;
                      hintError = false;
                    });
                  } else {
                    setState(() {
                      trueUsername = false;
                      truePassword = false;
                      hintError = true;
                    });
                  }
                }
              },
              autofocus: autoFocus,
              obscureText: obscureText,
              controller: controller,
              onTap: () {
                if (title == 'username') {
                  setState(() {
                    focusUsername = true;
                    focusPassword = false;
                  });
                } else {
                  setState(() {
                    focusUsername = false;
                    focusPassword = true;
                  });
                }
              },
              decoration: InputDecoration(
                  suffixIcon: title == 'username'
                      ? null
                      : InkWell(
                          onTap: () =>
                              setState(() => _showPassword = !_showPassword),
                          child: Icon(
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: _showPassword ? DARK_GREEN : Colors.grey,
                          ),
                        ),
                  border: InputBorder.none,
                  hintText: hintText()),
            ),
          ),
          hintError ? Container() : showError()
        ],
      ),
    );
  }
}
