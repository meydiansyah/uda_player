import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intermediate_udacoding/component/component_widget.dart';
import 'package:intermediate_udacoding/service/const.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool focusPassword = false;
  bool focusUsername = true;
  bool focusEmail = false;
  bool focusConfirmPassword = false;
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  bool showProgress = false;

  var valError;

  TextEditingController usernameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          ComponentWidget.backgroundAuth(),
          _buttonRegister(),
          Positioned(
              top: 30,
              left: 0,
              child: Column(
                children: [
                  ComponentWidget.logoUda(),
                  Container(
                    height: Get.height / 1.5,
                    width: Get.width,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 30),
                      decoration: ComponentWidget.cardDecoration(),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    Text(
                                      "Register",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: DARK_GREEN),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Text(
                                        "Masukkan data dengan yang benar",
                                        style: TextStyle(color: DARK_GREEN),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    formField(
                                        autoFocus: true,
                                        controller: usernameController,
                                        obscureText: false,
                                        title: 'username'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    formField(
                                        autoFocus: true,
                                        controller: emailController,
                                        obscureText: false,
                                        title: 'email'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    formField(
                                        autoFocus: true,
                                        controller: passwordController,
                                        obscureText:
                                            _showPassword ? false : true,
                                        title: 'password'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    formField(
                                        autoFocus: false,
                                        controller: confirmPasswordController,
                                        obscureText:
                                            _showConfirmPassword ? false : true,
                                        title: 'confirm password'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () => Navigator.pop(context),
                                        splashColor: Colors.transparent,
                                        child: Text(
                                          "Sudah punya akun ?",
                                          style: TextStyle(
                                              color: Colors.blueAccent),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            showProgress
                                ? ComponentWidget.linearProgress()
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget _buttonRegister() {
    bool emptyValue() {
      if (usernameController.text.length < 5 ||
          passwordController.text.length < 5 ||
          emailController.text.isEmpty ||
          confirmPasswordController.text != passwordController.text) {
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
            color: emptyValue() ? Colors.grey : Color(0xff003617),
            boxShadow: emptyValue()
                ? null
                : [
                    BoxShadow(
                        color: Color(0xff00240f),
                        blurRadius: 10,
                        offset: Offset(0, 2))
                  ]),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: emptyValue()
                  ? null
                  : () {
                      setState(() => showProgress = true);

                      snackBar(String message) {
                        final snackBar = SnackBar(
                          content: Text(message),
                        );

                        _scaffoldKey.currentState.showSnackBar(snackBar);
                      }

                      Future.delayed(Duration(milliseconds: 1500), () async {
                        var resp = await http.post(
                            "http://192.168.100.3/intermediate_udacoding/register.php",
                            body: {
                              'username': usernameController.text,
                              'email': emailController.text,
                              'password': passwordController.text,
                            });

                        final data = json.decode(resp.body);
                        var val = data['value'];

                        switch (val) {
                          case 0:
                            setState(() => showProgress = false);
                            snackBar('Register Berhasil !');
                            Future.delayed(Duration(milliseconds: 500),
                                () async {
                              return Navigator.pop(context);
                            });
                            break;
                          case 2:
                            snackBar('Username sudah digunakan !');
                            setState(() {
                              showProgress = false;
                              valError = 2;
                            });
                            break;
                          case 3:
                            snackBar('Email sudah digunakan !');
                            setState(() {
                              showProgress = false;
                              valError = 3;
                            });
                            break;
                          default:
                            snackBar('Register Gagal !');
                            setState(() => showProgress = false);
                            break;
                        }
                      });
                    },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Text(
                  "Register",
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

    bool checkCondition(bool active) {
      if (!active) {
        return true;
      }
      return false;
    }

    error() {
      if (controller.text.isEmpty) {
        switch (title) {
          case 'username':
            return checkCondition(focusUsername);
            break;
          case 'email':
            return checkCondition(focusEmail);
            break;
          case 'password':
            return checkCondition(focusPassword);
            break;
          case 'confirm password':
            return checkCondition(focusConfirmPassword);
            break;
          default:
            return false;
            break;
        }
      } else {
        return false;
      }
    }

    hintCondition(String output) {
      if (error())
        return output;
      else
        return title;
    }

    hintText() {
      if (controller.text.isEmpty) {
        switch (title) {
          case 'username':
            if (!focusUsername) return hintCondition("masukkan username");
            break;
          case 'email':
            if (!focusEmail) return hintCondition("masukkan email");
            break;
          case 'password':
            if (!focusPassword) return hintCondition("masukkan password");
            break;
          case 'confirm password':
            if (!focusConfirmPassword) return hintCondition("ulangi password");
            break;
          default:
            return title;
            break;
        }
      } else
        return title;
    }

    showErrorCondition(int min, int max) {
      if (controller.text.length > 0 && controller.text.length < min) {
        return Text(
          "$title harus > $min huruf",
          style: TextStyle(color: ERROR),
        );
      }

      if (title == 'confirm password') {
        if (controller.text.length > 0 &&
            (confirmPasswordController.text != passwordController.text)) {
          return Text(
            "password tidak cocok",
            style: TextStyle(color: ERROR),
          );
        } else {
          return Container();
        }
      } else {
        return Container();
      }
    }

    showError() {
      switch (title) {
        case 'username':
          return showErrorCondition(5, 20);
          break;
        case 'email':
          return showErrorCondition(5, 100);
          break;
        case 'password':
          return showErrorCondition(8, 20);
          break;
        case 'confirm password':
          return showErrorCondition(8, 20);
          break;
        default:
          return Container();
          break;
      }
    }

    maxText() {
      switch (title) {
        case 'username':
          return 10;
          break;
        case 'email':
          return 100;
          break;
        case 'password':
          return 20;
          break;
        case 'confirm password':
          return 20;
          break;
        default:
          return 20;
          break;
      }
    }

    onTapField() {
      focus(bool username, bool email, bool password, bool confirm) {
        setState(() {
          focusUsername = username;
          focusEmail = email;
          focusPassword = password;
          focusConfirmPassword = confirm;
        });
      }

      switch (title) {
        case 'username':
          focus(true, false, false, false);
          break;
        case 'email':
          focus(false, true, false, false);
          break;
        case 'password':
          focus(false, false, true, false);
          break;
        case 'confirm password':
          focus(false, false, false, true);
          break;
        default:
          return focus(false, false, false, false);
          break;
      }
    }

    borderColor() {
      if (title == 'password' || title == 'confirm password') {
        if ((passwordController.text.length > 0 &&
                passwordController.text.length > 0) &&
            (passwordController.text.length > 8 &&
                passwordController.text.length > 8) &&
            (passwordController.text == confirmPasswordController.text)) {
          return SUCCESS;
        } else {
          return ERROR;
        }
      } else {
        if (error()) return ERROR;
        return DARK_GREEN;
      }
    }

    suffixShowPassword() {
      if (title == 'password') {
        return InkWell(
          onTap: () => setState(() => _showPassword = !_showPassword),
          child: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
            color: _showPassword ? DARK_GREEN : Colors.grey,
          ),
        );
      } else if (title == 'confirm password') {
        return InkWell(
          onTap: () =>
              setState(() => _showConfirmPassword = !_showConfirmPassword),
          child: Icon(
            _showConfirmPassword ? Icons.visibility : Icons.visibility_off,
            color: _showConfirmPassword ? DARK_GREEN : Colors.grey,
          ),
        );
      } else
        return null;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(color: borderColor()),
                borderRadius: BorderRadius.circular(4),
                color: error() ? ERROR.withOpacity(0.05) : null),
            child: TextFormField(
              keyboardType: title == 'email'
                  ? TextInputType.emailAddress
                  : TextInputType.text,
              onChanged: (val) {
                if (val.length < maxText()) {
                  setState(() {
                    hintError = true;
                  });
                } else {
                  setState(() {
                    hintError = false;
                  });
                }
              },
              autofocus: autoFocus,
              maxLength: maxText(),
              obscureText: obscureText,
              controller: controller,
              onTap: () => onTapField(),
              decoration: InputDecoration(
                  counterText: "",
                  suffixIcon: suffixShowPassword(),
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
