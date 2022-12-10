import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/favorit_card.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/pages/player_page.dart';
import 'package:flutter_application_1/pages/search_page.dart';
import 'package:flutter_application_1/util/ApiServices.dart';
import 'package:flutter_application_1/util/colors.dart';
import 'package:flutter_application_1/widgets/right_float_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:http/http.dart' as http;

class WatchList extends StatefulWidget {
  const WatchList({Key? key}) : super(key: key);

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {
  double fullHeight = 0;
  double fullWidth = 0;
  late String token;
  final List<FavoritCard> listFavoritCard = [];
  bool isLoading = true;

  @override
  void initState() {
    getUserAttempsAndLogged();
    super.initState();
    getFavoritCards();
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
            Column(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Icon(
                              Icons.search_rounded,
                              size: 25,
                              color: Colors.white,
                            ),
                            Text(
                              "My Watchlist",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 2),
                            )
                          ],
                        )
                      ],
                    )),
                isLoading
                    ? Align(
                        alignment: Alignment.center,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.all(8),
                            child: FloatingActionButton(
                                heroTag: "btn2",
                                backgroundColor: rightFloatingButton,
                                onPressed: () => {},
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                          ),
                        ))
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 25, top: 25, bottom: 25),
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 14,
                                crossAxisSpacing: 10,
                                childAspectRatio:
                                    MediaQuery.of(context).size.width /
                                        MediaQuery.of(context).size.height,
                              ),
                              itemCount: listFavoritCard.length + 1,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext ctx, index) {
                                if (index == listFavoritCard.length) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: DottedBorder(
                                            dashPattern: const [10, 8],
                                            strokeWidth: 3,
                                            strokeCap: StrokeCap.round,
                                            borderType: BorderType.RRect,
                                            color: Colors.white60,
                                            child: GestureDetector(
                                              child: const Center(
                                                child: ClipOval(
                                                  child: Material(
                                                    color: rightFloatingButton,
                                                    child: Icon(
                                                      Icons.add_rounded,
                                                      color: Colors.white70,
                                                      size: 32,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            const Search()));
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  );
                                } else {
                                  final String cardName =
                                      listFavoritCard[index].cardName ?? "";
                                  final String cardUrl =
                                      listFavoritCard[index].cardUrl ?? "";
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  PlayerPage(
                                                    awsImage:
                                                        listFavoritCard[index]
                                                                .cardUrl ??
                                                            "",
                                                    card: listFavoritCard[index]
                                                        .cardName,
                                                    cardId:
                                                        listFavoritCard[index]
                                                            .gemId,
                                                  )));
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        cardUrl == ""
                                            ? Expanded(
                                                child: Container(
                                                decoration: const BoxDecoration(
                                                    image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/auth/Sign_Up_BG_Image.jpg'),
                                                  fit: BoxFit.fill,
                                                )),
                                              ))
                                            : Expanded(
                                                child: CachedNetworkImage(
                                                  imageUrl: cardUrl,
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Center(
                                                    child: Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                        Text(cardName,
                                            style: const TextStyle(
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 11),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }),
                        ),
                      ),
                const SizedBox(
                  height: 28,
                )
              ],
            ),
            //const RightFloatButton()
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "btn1",
          backgroundColor: rightFloatingButton,
          onPressed: () {
            Navigator.pop(context);
          },
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

  Future<void> getFavoritCards() async {
    http.Response response;
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    response = await http.get(
        Uri.parse(
            ApiService.apiUrl + ApiService.card + ApiService.getFavoritCards),
        headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      data.forEach((element) {
        if (mounted) {
          setState(() {
            listFavoritCard.add(FavoritCard.fromJson(element));
          });
        }
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}
