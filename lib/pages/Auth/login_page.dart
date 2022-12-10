import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/Auth/auth_accces.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Auth/register_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/util/ApiServices.dart';
import 'package:flutter_application_1/util/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isSecure = true;
  String responseMessage = "";
  bool apiCallProgess = false;
  bool apiCircleProgess = false;

  bool isUserNameEmpty = false;
  bool isPasswordEmpty = false;

  @override
  void initState() {
    username.text = "";
    password.text = "";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image:
                        AssetImage('assets/images/auth/Sign_Up_BG_Image.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image.asset(
                                'assets/images/onBoarding/Onboarding_Logo.jpg',
                                fit: BoxFit.scaleDown,
                                width: MediaQuery.of(context).size.width * .70,
                              ),
                            ],
                          ),
                          const Text(
                            'Powered by',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Image.asset(
                                'assets/images/gemrate.png',
                                fit: BoxFit.scaleDown,
                                width: MediaQuery.of(context).size.width * .40,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: size.width * .75,
                                child: Center(
                                  child: TextField(
                                      controller: username,
                                      keyboardType: TextInputType.emailAddress,
                                      cursorColor: Colors.white,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: const InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white60),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        hintText: "Email",
                                        prefixIcon: Icon(Icons.mail_rounded,
                                            color: Colors.white, size: 20),
                                        suffixIcon: Icon(Icons.check,
                                            color: Colors.white70, size: 14),
                                        hintStyle: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      )),
                                ),
                              ),
                              isUserNameEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        "Email Value Can't Be Empty",
                                        style: TextStyle(
                                            color: Colors.red.shade400,
                                            fontSize: 12),
                                      ),
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 18,
                              ),
                              SizedBox(
                                width: size.width * .75,
                                child: Center(
                                  child: TextField(
                                      controller: password,
                                      obscureText: isSecure,
                                      cursorColor: Colors.white,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white60),
                                        ),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        hintText: "Password",
                                        prefixIcon: const Icon(
                                            Icons.lock_rounded,
                                            color: Colors.white,
                                            size: 20),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isSecure = !isSecure;
                                            });
                                          },
                                          icon: Icon(
                                              isSecure
                                                  ? Icons.visibility_off_rounded
                                                  : Icons.visibility_rounded,
                                              color: Colors.white70,
                                              size: 14),
                                        ),
                                        hintStyle: const TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      )),
                                ),
                              ),
                              isPasswordEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        "Password Value Can't Be Empty",
                                        style: TextStyle(
                                            color: Colors.red.shade400,
                                            fontSize: 12),
                                      ),
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                child: Container(
                                  width: size.width * .75,
                                  alignment: Alignment.topRight,
                                  child: const Text(
                                    'Forgot Password ?',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white70),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              apiCallProgess
                                  ? Text(
                                      responseMessage,
                                      style: const TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12),
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 18,
                              ),
                              GestureDetector(
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  height: 60,
                                  width: size.width * .75,
                                  child: Center(
                                    child: apiCircleProgess
                                        ? CircularProgressIndicator(
                                            color: Colors.green.shade700,
                                            strokeWidth: 2,
                                          )
                                        : Text(
                                            'Log In',
                                            style: TextStyle(
                                                color: Colors.green.shade700,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                  ),
                                ),
                                onTap: () async {
                                  if (username.text.isEmpty &&
                                      password.text.isNotEmpty) {
                                    setState(() {
                                      isUserNameEmpty = true;
                                    });
                                  } else if (username.text.isNotEmpty &&
                                      password.text.isEmpty) {
                                    setState(() {
                                      isPasswordEmpty = true;
                                    });
                                  } else if (username.text.isEmpty &&
                                      password.text.isEmpty) {
                                    setState(() {
                                      isUserNameEmpty = true;
                                      isPasswordEmpty = true;
                                    });
                                  } else {
                                    setState(() {
                                      apiCircleProgess = true;
                                      isUserNameEmpty = false;
                                      isPasswordEmpty = false;
                                    });
                                    if (await loginService(
                                        username.text, password.text)) {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Home()),
                                          (Route<dynamic> route) => false);
                                    } else {
                                      setState(() {
                                        apiCallProgess = true;
                                        apiCircleProgess = false;
                                      });
                                    }
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 18,
                              ),
                              GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      border: Border.all(color: Colors.white)),
                                  height: 60,
                                  width: size.width * .75,
                                  child: const Center(
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterPage()));
                                },
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                            ]),
                      ),
                    ),
                  ],
                )),
            Positioned(
              right: 24,
              top: 24,
              child: GestureDetector(
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const Home()),
                        (Route<dynamic> route) => false);
                  }),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: rightFloatingButton,
          // onPressed: () => Navigator.of(context).pop(),
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const AuthAccess()),
              (Route<dynamic> route) => false),
          tooltip: 'back',
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 35,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      ),
    );
  }

  Future<bool> loginService(String username, String password) async {
    http.Response response;
    response = await http.post(
        Uri.parse(ApiService.apiUrl + ApiService.auth + ApiService.login),
        body: {'Email': username, 'Password': password});

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      prefs.setBool('isLogged', true);
      prefs.setString('accessToken', data['token']);
      return true;
    } else {
      setState(() {
        // responseMessage = response.body;
        responseMessage = "Please check your email and password !";
      });
      return false;
    }
  }
}
