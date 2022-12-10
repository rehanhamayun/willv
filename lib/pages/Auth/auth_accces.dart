import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Auth/login_page.dart';
import 'package:flutter_application_1/pages/Auth/register_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';

class AuthAccess extends StatefulWidget {
  const AuthAccess({Key? key}) : super(key: key);

  @override
  State<AuthAccess> createState() => _AuthAccessState();
}

class _AuthAccessState extends State<AuthAccess> {
  @override
  void initState() {
    super.initState();
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
                child: Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      'Bummer...',
                      style: TextStyle(
                          fontSize: 58,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    ),
                    const Text(
                      'Want to view more?',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Image.asset(
                      'assets/images/auth/div.png',
                      width: size.width * .75,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text(
                      'More Features are only available',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    const Text(
                      'in the paid version.',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: size.height * .16,
                    ),
                    const Text(
                      'Get access to thousands of reports!',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        height: 60,
                        width: size.width * .75,
                        child: Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                      },
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                      },
                    ),
                  ],
                ))),
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
      ),
    );
  }
}
