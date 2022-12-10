import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/Profle/Widgets/profile_widget_list.dart';
import 'package:flutter_application_1/pages/Profle/my_info_page.dart';
import 'package:flutter_application_1/util/colors.dart';
import 'package:flutter_application_1/widgets/spacer_sizer_boxer.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  double fullHeight = 0;
  double fullWidth = 0;
  late String token;

  @override
  void initState() {
    super.initState();
    getUserAttempsAndLogged();
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
              physics: const AlwaysScrollableScrollPhysics(),
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
                            "My Account",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          GestureDetector(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(25.0),
                                    child: Text('My info',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 26)),
                                  ),
                                ]),
                            onTap: () {
                              if (token.isEmpty || token != '') {
                                showToast(
                                    "Feature required to login.", context);
                                Future.delayed(const Duration(seconds: 2), () {
                                  goBackToLog(context);
                                });
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyInfoPage()),
                                );
                              }
                            },
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 25,
                              right: 25,
                            ),
                            child: MySpaceSizedBoxer(),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 15, left: 25, right: 25, bottom: 65),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: itemData.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 8.0, top: 8.0),
                                      child: ExpansionPanelList(
                                        animationDuration:
                                            const Duration(milliseconds: 500),
                                        dividerColor: Colors.white60,
                                        elevation: 0,
                                        children: [
                                          ExpansionPanel(
                                            headerBuilder:
                                                (BuildContext context,
                                                    bool isExpanded) {
                                              return Container(
                                                color: Colors.transparent,
                                                child: Text(
                                                  itemData[index].headerItem,
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 26),
                                                ),
                                              );
                                            },
                                            body: itemData[index].widget,
                                            isExpanded:
                                                itemData[index].expanded,
                                            canTapOnHeader: true,
                                            backgroundColor: Colors.transparent,
                                          )
                                        ],
                                        expansionCallback:
                                            (int item, bool status) {
                                          setState(() {
                                            itemData[index].expanded =
                                                !itemData[index].expanded;
                                          });
                                        },
                                        expandedHeaderPadding:
                                            const EdgeInsets.all(4),
                                      ),
                                    ),
                                    const MySpaceSizedBoxer(),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            // const Positioned(
            //     bottom: 0,
            //     child: Divider(
            //       color: Colors.white,
            //       thickness: 2,
            //       height: 2,
            //     )),
            // const RightFloatButton()
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
  }
}
