import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Auth/login_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/util/ApiServices.dart';
import 'package:flutter_application_1/util/colors.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();

  bool isSecure = true;
  String responseMessage = "";
  bool apiCallProgess = false;
  bool notCompatiblePasswords = false;

  bool apiCircleProgess = false;

  bool isUserNameEmpty = false;
  bool isEmailEmpty = false;
  bool isPasswordEmpty = false;
  bool isConfirmationEmpty = false;

  @override
  void initState() {
    username.text = "";
    email.text = "";
    password.text = "";
    passwordConfirmation.text = "";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    email.dispose();
    password.dispose();
    passwordConfirmation.dispose();
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
                      height: 40,
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset(
                            'assets/images/onBoarding/Onboarding_Logo.jpg',
                            fit: BoxFit.scaleDown,
                            width: MediaQuery.of(context).size.width * .65,
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
                                      keyboardType: TextInputType.name,
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
                                        hintText: "Username",
                                        prefixIcon: Icon(Icons.person,
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
                                        "Username Value Can't Be Empty",
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
                                      controller: email,
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
                              isEmailEmpty
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
                              SizedBox(
                                width: size.width * .75,
                                child: Center(
                                  child: TextField(
                                      controller: passwordConfirmation,
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
                                        errorBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white60)),
                                        hintText: "confirm Password",
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
                              notCompatiblePasswords
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        "Password should be the same as the confirmation",
                                        style: TextStyle(
                                            color: Colors.red.shade400,
                                            fontSize: 12),
                                      ),
                                    )
                                  : const SizedBox(),
                              isConfirmationEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        "Password confirmation Can't Be Empty",
                                        style: TextStyle(
                                            color: Colors.red.shade400,
                                            fontSize: 12),
                                      ),
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 38,
                              ),
                              apiCallProgess
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            responseMessage,
                                            style: const TextStyle(
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w300,
                                                fontSize: 12),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
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
                                            'Sign Up',
                                            style: TextStyle(
                                                color: Colors.green.shade700,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16),
                                          ),
                                  ),
                                ),
                                onTap: () async {
                                  if (username.text.isEmpty) {
                                    setState(() {
                                      isUserNameEmpty = true;
                                    });
                                  }
                                  if (email.text.isEmpty) {
                                    setState(() {
                                      isEmailEmpty = true;
                                    });
                                  }
                                  if (password.text.isEmpty) {
                                    setState(() {
                                      isPasswordEmpty = true;
                                    });
                                  }
                                  if (passwordConfirmation.text.isEmpty) {
                                    setState(() {
                                      isConfirmationEmpty = true;
                                    });
                                  }
                                  if (username.text.isNotEmpty &&
                                      email.text.isNotEmpty &&
                                      password.text.isNotEmpty &&
                                      passwordConfirmation.text.isNotEmpty) {
                                    if (password.text !=
                                        passwordConfirmation.text) {
                                      setState(() {
                                        notCompatiblePasswords = true;
                                      });
                                    } else {
                                      setState(() {
                                        notCompatiblePasswords = false;
                                        apiCircleProgess = true;
                                        isUserNameEmpty = false;
                                        isEmailEmpty = false;
                                        isPasswordEmpty = false;
                                        isConfirmationEmpty = false;
                                      });
                                      if (await signUpService(username.text,
                                              password.text, email.text) &&
                                          password.text ==
                                              passwordConfirmation.text) {
                                        Timer(const Duration(seconds: 2), () {
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginPage()));
                                        });
                                      } else {
                                        setState(() {
                                          apiCallProgess = true;
                                          apiCircleProgess = false;
                                        });
                                      }
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
                                      'Log In',
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
                                              const LoginPage()));
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
          onPressed: () => Navigator.of(context).pop(),
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

  Future<bool> signUpService(
      String username, String password, String email) async {
    http.Response response;
    response = await http.post(
        Uri.parse(
            ApiService.apiUrl + ApiService.auth + ApiService.creationAccount),
        body: {'Email': email, 'Username': username, 'Password': password});

    // final data = json.decode(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      setState(() {
        responseMessage = response.body;
      });
      return false;
    }
  }
}
