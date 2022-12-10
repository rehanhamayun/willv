import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/pages/Auth/auth_accces.dart';
import 'package:flutter_application_1/pages/Profle/account_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/player_page.dart';
import 'package:flutter_application_1/pages/search_page.dart';
import 'package:flutter_application_1/pages/splash_screen.dart';
import 'package:flutter_application_1/pages/watch_list_page.dart';
import 'package:flutter_application_1/util/ApiServices.dart';
import 'package:flutter_application_1/util/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

late SharedPreferences prefs;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((instance) {
    prefs = instance;
    checkUserAttempsAndLogged();
    runApp(const MyApp());
  });

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xff006F70),
  ));
}

void checkUserAttempsAndLogged() async {
  final int? userAttemps = prefs.getInt('attemps');
  final bool? isLogged = prefs.getBool('isLogged');
  final String? accessToken = prefs.getString('accessToken');

  if (userAttemps == null) await prefs.setInt('attemps', 3);
  if (isLogged == null) await prefs.setBool('isLogged', false);
  if (accessToken == null) await prefs.setString('accessToken', '');
}

void goBackToLog(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (c) => const AuthAccess()), (route) => false);
}

void showToast(String message, BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 1),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppScreenState();
}

class _MyAppScreenState extends State<MyApp> {
  bool? isLogged;
  String? token;

  @override
  void initState() {
    super.initState();
    checkTokenValidation();
  }

  void checkTokenValidation() async {
    isLogged = prefs.getBool('isLogged');
    token = prefs.getString('accessToken') ?? '';

    http.Response response;
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };
    response = await http.get(
        Uri.parse(ApiService.apiUrl + ApiService.user + ApiService.profile),
        headers: headers);

    if (response.statusCode == 401) {
      prefs.setBool("isLogged", false);
      prefs.remove("accessToken");
      setState(() {
        isLogged = false;
        token = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: getUserDirection(),
        routes: {
          AppRoutes.splash: (context) => const SplachScreen(),
          AppRoutes.home: (context) => const Home(),
          AppRoutes.watchList: (context) => const WatchList(),
          AppRoutes.searchPage: (context) => const Search(),
          AppRoutes.account: (context) => const Account(),
          AppRoutes.playerCard: (context) => const PlayerPage(),
        },
      );
    });
  }

  String getUserDirection() {
    if (isLogged == null || isLogged == false) {
      return '/';
    } else {
      return '/home';
    }
  }
}
