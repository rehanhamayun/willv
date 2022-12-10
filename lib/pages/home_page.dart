import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/app_routes.dart';
import 'package:sizer/sizer.dart';
import 'dart:math' as math;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double fullHeight = 0;
  double fullWidth = 0;
  bool? isLogged;
  String? token;

  @override
  void initState() {
    checkTokenValidation();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    fullHeight = MediaQuery.of(context).size.height;
    fullWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff006F70),
              Color(0xff006F70),
              Color(0xff006F70),
              Color(0xff008062),
              Color.fromARGB(255, 20, 148, 52),
              Color(0xff2F855E),
              //#6CC46D
              // Color(0xff2A9745),
            ],
          )),
          child: Stack(children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(
                  child: SizedBox(
                    width: fullWidth / 1.2,
                    child: Image.asset(
                      'assets/images/auth/div.png',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                item(context,
                    headerText: "Search",
                    subHeader: "Trading Cards",
                    imagePath: "basketball.png",
                    direction: AppRoutes.searchPage,
                    icon: Icons.search_rounded),
                item(context,
                    headerText: "Watchlist",
                    subHeader: "What you have eyes on",
                    imagePath: "watchlist.png",
                    direction: AppRoutes.watchList,
                    icon: Icons.arrow_forward_ios_rounded),
                item(context,
                    headerText: "My Account",
                    subHeader: "Settings and FAQ",
                    imagePath: "account.png",
                    direction: AppRoutes.account,
                    icon: Icons.arrow_forward_ios_rounded),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget item(
    BuildContext context, {
    required String headerText,
    required String subHeader,
    required String imagePath,
    required String direction,
    required IconData icon,
  }) {
    return GestureDetector(
      child: Container(
        width: fullWidth,
        height: fullHeight * 0.28,
        color: Colors.green.shade300,
        child: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  'assets/images/$imagePath',
                ),
              ),
            ),
            width: fullWidth,
            height: fullHeight * 0.28,
          ),
          SizedBox(
            width: fullWidth,
            height: fullHeight * 0.28,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    height: 10.5.h, // height: 70,
                    width: 13.5.w, // width: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(45),
                          bottomRight: Radius.circular(45)),
                      color: Color(0xff6CC46D),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: icon == Icons.search_rounded
                          ? Transform.rotate(
                              angle: 180 * math.pi / 360,
                              child: Icon(
                                icon,
                                color: Colors.white70,
                                size: 25.sp,
                              ),
                            )
                          : Icon(
                              icon,
                              color: Colors.white70,
                              size: 20.sp,
                            ),
                    )),
                const SizedBox(
                  width: 24,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        headerText,
                        style: TextStyle(
                            fontSize: 24.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 3),
                      ),
                      Text(
                        subHeader,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
      onTap: () {
        if (direction == AppRoutes.searchPage) {
          Navigator.pushNamed(context, direction);
        } else {
          if (isLogged != null && token != null && isLogged == true) {
            Navigator.pushNamed(context, direction);
          } else {
            if (direction == AppRoutes.account) {
              Navigator.pushNamed(context, direction);
            } else {
              showToast("Feature required to login.", context);
              Future.delayed(const Duration(seconds: 2), () {
                goBackToLog(context);
              });
            }
          }
        }
      },
    );
  }

  void checkTokenValidation() async {
    isLogged = prefs.getBool('isLogged');
    token = prefs.getString('accessToken') ?? '';
  }
}
