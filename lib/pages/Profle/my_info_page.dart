import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/user.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/Profle/Widgets/change_password_dialog.dart';
import 'package:flutter_application_1/util/ApiServices.dart';
import 'package:flutter_application_1/util/colors.dart';
import 'package:flutter_application_1/widgets/logout_dialog.dart';
import 'package:flutter_application_1/widgets/spacer_sizer_boxer.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key? key}) : super(key: key);

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  double fullHeight = 0;
  double fullWidth = 0;
  late String token;
  late bool isWaiting = false;
  late bool isChanging = false;
  late http.Response responseOther;
  bool isCallingApi = false;

  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  void initState() {
    getUserAttempsAndLogged();
    email.text = "";
    username.text = "";
    firstName.text = "";
    lastName.text = "";
    age.text = "";
    address.text = "";
    fetchUserInit();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    username.dispose();
    email.dispose();
    firstName.dispose();
    lastName.dispose();
    age.dispose();
    address.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fullHeight = MediaQuery.of(context).size.height;
    fullWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      top: true,
      child: Scaffold(
        body: Container(
          height: fullHeight,
          width: fullWidth,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff006F70),
              Color(0xff008062),
              Color(0xff2A9745),
            ],
          )),
          child: Stack(children: <Widget>[
            SingleChildScrollView(
              child: GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            'assets/images/auth/div.png',
                          ),
                          const Text(
                            "My informations",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Container(
                              padding: const EdgeInsets.only(
                                top: 15,
                              ),
                              child: FutureBuilder(
                                  future: fetchUser(),
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                            ConnectionState.none &&
                                        !snapshot.hasData) {
                                      shimmerCardWidget();
                                    }
                                    if (!snapshot.hasData ||
                                        snapshot.hasError) {
                                      shimmerCardWidget();
                                    }
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        cardWidget(snapshot.data),
                                        const SizedBox(
                                          height: 32,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(children: const [
                                              Icon(
                                                Icons.person,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text("Account ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300)),
                                            ]),
                                            const MySpaceSizedBoxer(),
                                          ],
                                        ),
                                        formUser(),
                                        const SizedBox(
                                          height: 26,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(children: const [
                                              Icon(
                                                Icons.settings,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text("Settings ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w300)),
                                            ]),
                                            const MySpaceSizedBoxer(),
                                            settingWidget()
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 72,
                                        ),
                                      ],
                                    );
                                  }))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
                bottom: 0,
                child: Divider(
                  color: Colors.white,
                  thickness: 2,
                  height: 2,
                )),
            //const RightFloatButton()
          ]),
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

  void getUserAttempsAndLogged() async {
    setState(() {
      token = prefs.getString('accessToken') ?? '';
    });

    if (prefs.getString('accessToken')!.isEmpty ||
        prefs.getString('accessToken') == '') {}
  }

  Future<User?> fetchUser() async {
    User? user = User();
    http.Response response;
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    response = await http.get(
        Uri.parse(ApiService.apiUrl + ApiService.user + ApiService.profile),
        headers: headers);

    if (response.statusCode == 200) {
      user = userFromJson(response.body);
      return user;
    } else {
      throw Exception('Failed to load Card');
    }
  }

  void fetchUserInit() async {
    User user;
    http.Response response;
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    response = await http.get(
        Uri.parse(ApiService.apiUrl + ApiService.user + ApiService.profile),
        headers: headers);

    if (response.statusCode == 200) {
      user = userFromJson(response.body);
      setState(() {
        firstName.text = user.firstName!;
        lastName.text = user.lastName!;
        username.text = user.username!;
        email.text = user.email!;
        address.text = user.adresse!;
        age.text = user.age!.toString();
      });
    } else {
      throw Exception('Failed to load Card');
    }
  }

  Widget cardWidget(User user) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 9,
              offset: const Offset(0, 3), // changes position of shadow
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const CircleAvatar(
                backgroundColor: rightFloatingButton,
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username!,
                    style: const TextStyle(color: Colors.black87, fontSize: 18),
                  ),
                  Text(
                    user.email!,
                    style: const TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                ],
              )
            ],
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            width: fullWidth,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: rightFloatingButton,
                  size: 28,
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Joind us in",
                        style: TextStyle(color: Colors.black54, fontSize: 12)),
                    Text(
                      "${user.createdAt!.day}-${user.createdAt!.month}-${user.createdAt!.year}",
                      style:
                          const TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 50,
                ),
                const Icon(
                  Icons.ads_click_outlined,
                  color: rightFloatingButton,
                  size: 28,
                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Account Status",
                        style: TextStyle(color: Colors.black54, fontSize: 12)),
                    user.active!
                        ? const Text(
                            "Active",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 14),
                          )
                        : const Text(
                            "Not Active",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 14),
                          ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget shimmerCardWidget() {
    return SizedBox(
      child: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.grey.shade400,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 9,
                  offset: const Offset(0, 3), // changes position of shadow
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.black,
                    highlightColor: Colors.red,
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.black,
                        highlightColor: Colors.red,
                        child: const Text(
                          "Username",
                          style: TextStyle(color: Colors.black87, fontSize: 18),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.black,
                        highlightColor: Colors.red,
                        child: const Text(
                          "Email",
                          style: TextStyle(color: Colors.black87, fontSize: 18),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Shimmer.fromColors(
                baseColor: Colors.black,
                highlightColor: Colors.red,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  width: fullWidth,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.black87,
                      ),
                      Text(
                        "enjoyed us at",
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                      Icon(
                        Icons.ads_click_outlined,
                        color: Colors.black87,
                      ),
                      Text(
                        "Active Account",
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget formUser() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SizedBox(
        width: fullWidth,
        child: Column(
          children: [
            // Row(
            //   children: [
            //     Expanded(
            //       flex: 1,
            //       child: TextField(
            //         decoration: const InputDecoration(
            //           enabledBorder: UnderlineInputBorder(
            //             borderSide: BorderSide(color: Colors.white70),
            //           ),
            //           labelText: 'First Name',
            //           labelStyle: TextStyle(color: Colors.white, fontSize: 12),
            //           hintText: 'Enter Your First Name',
            //           hintStyle: TextStyle(color: Colors.white, fontSize: 14),
            //         ),
            //         controller: firstName,
            //         cursorColor: Colors.green.shade900,
            //         style: const TextStyle(
            //           color: Colors.white,
            //           fontSize: 15,
            //         ),
            //         onChanged: (value) {
            //           setState(() {
            //             isChanging = true;
            //           });
            //         },
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 18,
            //     ),
            //     Expanded(
            //       flex: 1,
            //       child: TextField(
            //         decoration: const InputDecoration(
            //           enabledBorder: UnderlineInputBorder(
            //             borderSide: BorderSide(color: Colors.white70),
            //           ),
            //           labelText: 'Last Name',
            //           labelStyle: TextStyle(color: Colors.white, fontSize: 12),
            //           hintText: 'Enter Your Last Name',
            //           hintStyle: TextStyle(color: Colors.white, fontSize: 14),
            //         ),
            //         controller: lastName,
            //         cursorColor: Colors.green.shade900,
            //         style: const TextStyle(
            //           color: Colors.white,
            //           fontSize: 15,
            //         ),
            //         onChanged: (value) {
            //           setState(() {
            //             isChanging = true;
            //           });
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 18,
            ),
            TextField(
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                labelText: 'User Name',
                labelStyle: TextStyle(color: Colors.white, fontSize: 12),
                hintText: 'Enter Your Last Name',
                hintStyle: TextStyle(color: Colors.white, fontSize: 14),
              ),
              controller: username,
              enabled: false,
              autofocus: false,
              cursorColor: Colors.green.shade900,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              onChanged: (value) {
                setState(() {
                  isChanging = true;
                });
              },
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white70),
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white, fontSize: 12),
                hintText: 'Enter Your Email',
                hintStyle: TextStyle(color: Colors.white, fontSize: 14),
              ),
              controller: email,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              cursorColor: Colors.green.shade900,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              onChanged: (value) {
                setState(() {
                  isChanging = true;
                });
              },
            ),
            const SizedBox(
              height: 18,
            ),
            // Row(
            //   children: [
            //     Expanded(
            //       flex: 3,
            //       child: TextField(
            //         decoration: const InputDecoration(
            //           enabledBorder: UnderlineInputBorder(
            //             borderSide: BorderSide(color: Colors.white70),
            //           ),
            //           labelText: 'Address',
            //           labelStyle: TextStyle(color: Colors.white, fontSize: 12),
            //           hintText: 'Enter Your Address',
            //           hintStyle: TextStyle(color: Colors.white, fontSize: 14),
            //         ),
            //         controller: address,
            //         keyboardType: TextInputType.streetAddress,
            //         autofocus: false,
            //         cursorColor: Colors.green.shade900,
            //         style: const TextStyle(
            //           color: Colors.white,
            //           fontSize: 15,
            //         ),
            //         onChanged: (value) {
            //           setState(() {
            //             isChanging = true;
            //           });
            //         },
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 18,
            //     ),
            //     Expanded(
            //       flex: 1,
            //       child: TextField(
            //         decoration: const InputDecoration(
            //           enabledBorder: UnderlineInputBorder(
            //             borderSide: BorderSide(color: Colors.white70),
            //           ),
            //           labelText: 'Age',
            //           labelStyle: TextStyle(color: Colors.white, fontSize: 12),
            //           hintText: 'Enter Your Age',
            //           hintStyle: TextStyle(color: Colors.white, fontSize: 14),
            //         ),
            //         controller: age,
            //         autofocus: false,
            //         keyboardType: TextInputType.number,
            //         cursorColor: Colors.green.shade900,
            //         style: const TextStyle(
            //           color: Colors.white,
            //           fontSize: 15,
            //         ),
            //         onChanged: (value) {
            //           setState(() {
            //             isChanging = true;
            //           });
            //         },
            //       ),
            //     ),
            //   ],
            // ),
            isChanging
                ? const SizedBox(
                    height: 32,
                  )
                : const SizedBox(),
            isChanging
                ? AnimatedOpacity(
                    opacity: isChanging ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 1000),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                              borderRadius: BorderRadius.circular(30),
                              splashColor: rightFloatingButton,
                              onTap: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                setState(() {
                                  isChanging = false;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(color: Colors.white),
                                    color: Colors.transparent),
                                width: fullWidth / 3,
                                child: const Center(
                                  child: Text(
                                    "CANCEL",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white),
                                  ),
                                ),
                              )),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            splashColor: Colors.white,
                            onTap: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              setState(() {
                                isCallingApi = true;
                              });
                              await updateProfile(
                                  address_: address.text,
                                  age_: age.text.toString(),
                                  email_: email.text,
                                  firstName_: firstName.text,
                                  lastName_: lastName.text);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: rightFloatingButton),
                              width: fullWidth / 3,
                              child: Center(
                                child: isCallingApi
                                    ? const SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 1,
                                        ),
                                      )
                                    : const Text(
                                        "   SAVE   ",
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.white),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget settingWidget() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.white,
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return PasswordDialog(token: token);
                    });
              },
              child: Container(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Text(
                      "Change password",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Material(
          //   color: Colors.transparent,
          //   child: InkWell(
          //     splashColor: Colors.white,
          //     onTap: () {},
          //     child: Container(
          //       padding: const EdgeInsets.only(top: 5, bottom: 5),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisSize: MainAxisSize.max,
          //         children: const [
          //           Text(
          //             "Privacy and security",
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w400),
          //           ),
          //           Icon(
          //             Icons.arrow_forward_ios_rounded,
          //             size: 18,
          //             color: Colors.white,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          // Material(
          //   color: Colors.transparent,
          //   child: InkWell(
          //     splashColor: Colors.white,
          //     onTap: () {},
          //     child: Container(
          //       padding: const EdgeInsets.only(top: 5, bottom: 5),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisSize: MainAxisSize.max,
          //         children: const [
          //           Text(
          //             "Content settings",
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w400),
          //           ),
          //           Icon(
          //             Icons.arrow_forward_ios_rounded,
          //             size: 18,
          //             color: Colors.white,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          // Material(
          //   color: Colors.transparent,
          //   child: InkWell(
          //     splashColor: Colors.white,
          //     onTap: () {},
          //     child: Container(
          //       padding: const EdgeInsets.only(top: 5, bottom: 5),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisSize: MainAxisSize.max,
          //         children: const [
          //           Text(
          //             "Language",
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.w400),
          //           ),
          //           Icon(
          //             Icons.arrow_forward_ios_rounded,
          //             size: 18,
          //             color: Colors.white,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          const SizedBox(
            height: 32,
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                showToast("You need long tap to sign out");
              },
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const LogoutDialog();
                    });
              },
              child: Container(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Text(
                      "SIGN OUT",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateProfile({
    required String email_,
    required String firstName_,
    required String lastName_,
    required String age_,
    required String address_,
  }) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    Map<String, String> body = {
      'email': email_,
      'lastname': lastName_,
      'firstname': firstName_,
      'age': age_,
      'address': address_,
    };
    responseOther = await http.post(
        Uri.parse(
            ApiService.apiUrl + ApiService.user + ApiService.updateProfile2),
        body: body,
        headers: headers);

    if (responseOther.statusCode == 200) {
      setState(() {
        email.text = email_;
        firstName.text = firstName_;
        lastName.text = lastName_;
        age.text = age_;
        address.text = address_;
      });
      showToast("Account updated");
    } else {
      throw Exception('Failed to load Card');
    }
    setState(() {
      isCallingApi = false;
    });
  }

  void showToast(String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        // action: SnackBarAction( label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
