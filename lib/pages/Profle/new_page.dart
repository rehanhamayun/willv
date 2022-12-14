import 'dart:convert';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/searching_card.dart';
import 'package:flutter_application_1/pages/player_page.dart';
import 'package:flutter_application_1/util/ApiServices.dart';
import 'package:flutter_application_1/util/colors.dart';
import 'package:flutter_application_1/widgets/jumping_dots.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_similarity/string_similarity.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  double fullHeight = 0;
  double fullWidth = 0;
  bool isSearching = false;
  bool isWaiting = false;
  bool isSearchingDone = false;
  int toggle = 0;
  int userAttemps = 0;
  bool isLogged = false;

  List<CardSearchResult> cardSearch = [];

  late AnimationController _con;
  late TextEditingController _textEditingController;
  String messageResponse = "There's no data with this keywords !";
  late SharedPreferences prefs;
  late String token;
  ScrollController textFieldScrollController = ScrollController();
  late FocusNode focusNode;

  @override
  void initState() {
    getUserAttempsAndLogged();
    super.initState();

    _textEditingController = TextEditingController();
    _con = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 375),
    );
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
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
                    padding: const EdgeInsets.only(
                        bottom: 5, left: 20, right: 20, top: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Divider(
                          color: Colors.white,
                          thickness: 2.0,
                        ),
                        isSearchingDone && isLogged
                            ? Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${cardSearch.length.toString()} Results for:",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "' ${_textEditingController.text} '",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ],
                        )
                            : const SizedBox(),
                        isSearching
                            ? !isLogged
                            ? Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${userAttemps.toString()} attemps left. ",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${cardSearch.length.toString()} Results for:",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "' ${_textEditingController.text} '",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        )
                            : const SizedBox()
                            : isLogged
                            ? const Text(
                          "Make search using multiple key words for exact result",
                          style: TextStyle(
                              color: Colors.white, fontSize: 12),
                        )
                            : Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${userAttemps.toString()} attemps left. ",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Make search using multiple key words for \n exact result",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: const Alignment(-1.0, 0.0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 375),
                            height: 50.0,
                            width: (toggle == 0)
                                ? 48.0
                                : MediaQuery.of(context).size.width * .9,
                            curve: Curves.easeOut,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: -10.0,
                                  blurRadius: 10.0,
                                  offset: Offset(0.0, 10.0),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 35, right: 35),
                                    child: TextField(
                                      textInputAction: TextInputAction.search,
                                      onSubmitted: (value) {
                                        submitApiCall();
                                      },
                                      maxLines: 1,
                                      minLines: 1,
                                      controller: _textEditingController,
                                      cursorRadius: const Radius.circular(10.0),
                                      cursorWidth: 2.0,
                                      cursorColor: Colors.green.shade900,
                                      decoration: InputDecoration(
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                        labelText: 'Search...',
                                        labelStyle: const TextStyle(
                                          color: Color(0xff5B5B5B),
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        alignLabelWithHint: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 300),
                                  top: 5.0,
                                  right: 7.0,
                                  curve: Curves.easeOut,
                                  child: AnimatedOpacity(
                                    opacity: (toggle == 0) ? 0.0 : 1.0,
                                    duration: const Duration(milliseconds: 200),
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color:  Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                      ),
                                      child: AnimatedBuilder(
                                          builder: (context, widget) {
                                            return Transform.rotate(
                                              angle: _con.value * 2.0 * pi,
                                              child: widget,
                                            );
                                          },
                                          animation: _con,
                                          child: InkWell(
                                            child: const Icon(
                                              Icons.send,

                                              color: Colors.black,
                                              size: 15.0,
                                            ),
                                            onTap: () {
                                              submitApiCall();
                                            },
                                          )),
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(80.0),
                                  child: IconButton(
                                    splashRadius: 10.0,
                                    iconSize: 30,
                                    icon: const Icon(Icons.search_rounded),
                                    onPressed: () {
                                      setState(
                                            () {
                                          if (toggle == 0) {
                                            toggle = 1;
                                            _con.forward();
                                          } else {
                                            toggle = 0;
                                            _con.reverse();
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 25,
                          child: Row(
                            children: const [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  'Card',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Player",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                if (!isLogged && userAttemps == 0)
                  Expanded(
                    child: Center(
                      child: Text(
                        messageResponse,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                else if (isWaiting && isSearching && cardSearch.isEmpty)
                  const Expanded(
                    child: Center(
                        child: JumpingDots(
                          numberOfDots: 7,
                        )),
                  )
                else if (isWaiting && !isSearching && cardSearch.isEmpty)
                    Expanded(
                      child: Center(
                        child: Text(
                          messageResponse,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  else
                    Expanded(
                        child: Stack(
                          children: [
                            // .contains logic applied here.
                            ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: cardSearch.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return GestureDetector(
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 20, left: 20),
                                        child: Divider(
                                          color: Colors.white,
                                          thickness: 0.2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Stack(
                                              children: [
                                                cardSearch[index].awsUrl == null ||
                                                    cardSearch[index]
                                                        .awsUrl!
                                                        .isEmpty
                                                    ? Container(
                                                  height: 100,
                                                  width: 70,
                                                  decoration:
                                                  const BoxDecoration(
                                                      image:
                                                      DecorationImage(
                                                        image: AssetImage(
                                                            'assets/images/auth/Sign_Up_BG_Image.jpg'),
                                                        fit: BoxFit.fill,
                                                      )),
                                                )
                                                    : CachedNetworkImage(
                                                    height: 100,
                                                    width: 70,
                                                    // URL Images from AWS (added by Rehan)
                                                    imageUrl:
                                                    cardSearch[index].awsUrl!,
                                                    placeholder: (context, url) =>
                                                    const Center(
                                                      child:
                                                      CircularProgressIndicator(),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) {
                                                      return Center(
                                                          child: Container(
                                                            height: 100,
                                                            width: 70,
                                                            decoration:
                                                            const BoxDecoration(
                                                                image:
                                                                DecorationImage(
                                                                  image: AssetImage(
                                                                      'assets/images/auth/Sign_Up_BG_Image.jpg'),
                                                                  fit: BoxFit.fill,
                                                                )),
                                                          ));
                                                    }),
                                                Positioned(
                                                    bottom: 2,
                                                    right: 2,
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                16),
                                                            color: Colors.white),
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              right: 8,
                                                              left: 8,
                                                              top: 2,
                                                              bottom: 2),
                                                          child: Text(
                                                            "${cardSearch[index].grader}",
                                                            style: const TextStyle(
                                                                color: Colors.black),
                                                          ),
                                                        )))
                                              ],
                                            ),
                                            Container(
                                              width:
                                              MediaQuery.of(context).size.width *
                                                  .65,
                                              margin: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Text(
                                                "${cardSearch[index].details}",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 25,
                                              color: Colors.white,
                                              semanticLabel: 'Icon',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Details Page added by Rehan.
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => PlayerPage(
                                          card: cardSearch[index].details,
                                          grader: cardSearch[index].grader,
                                          awsImage: cardSearch[index].awsUrl,
                                          cardId: cardSearch[index].gemrateId,
                                        ),),);
                                  },
                                );
                              },
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: isSearching && isWaiting
                                  ? Center(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.all(8),
                                  child: FloatingActionButton(
                                      backgroundColor: rightFloatingButton,
                                      onPressed: () => {},
                                      child: const CircularProgressIndicator(
                                        color: Colors.white,
                                      )),
                                ),
                              )
                                  : const SizedBox(),
                            )
                          ],
                        )),
                const SizedBox(
                  height: 25,
                )
              ],
            ),
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

  void submitApiCall() {
    FocusScope.of(context).unfocus();
    if (_textEditingController.text.isNotEmpty) {
      setState(() {
        cardSearch.clear();
        // loadedCardNames.clear();
      });
      fetchCards(_textEditingController.text);
      if (userAttemps > 0) {
        setState(() {
          isSearching = true;
          isWaiting = true;
          isSearchingDone = true;
        });
      } else {
        setState(() {
          isWaiting = false;
        });
      }
    }
  }

  void getUserAttempsAndLogged() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userAttemps = prefs.getInt('attemps') ?? 0;
      isLogged = prefs.getBool('isLogged') ?? false;
      token = prefs.getString('accessToken') ?? '';
    });
    await homeFetchingBestCard();
  }

  void setUserAttemps() async {
    int currentAttemps = prefs.getInt('attemps')!;
    int afterSearchAttemps = currentAttemps - 1;
    setState(() {
      prefs.setInt('attemps', afterSearchAttemps);
      userAttemps = afterSearchAttemps;
    });
  }

  String checkDescInSetname(
      String setName, String desc, String player, String card) {
    String result = "";

    if (desc == null || desc.isEmpty) {
      return '$player $setName $card';
    }

    if (setName.contains(desc)) {
      result = '$player $setName $card';
    } else {
      result = '$player $setName $desc $card';
    }
    return result;
  }

  void fetchSearchingData(dynamic data) {
    data.forEach((element) {
      setState(() {
        cardSearch.add(CardSearchResult.fromJson(element));
      });
    });
  }

  String replaceSymboles2(String word) {
    return word.replaceAll(RegExp(r'[^\w\s]+'), '');
  }

  String replaceSymboles(String word) {
    word.replaceAll(' ', '');
    return word.replaceAll(RegExp(r'[^\w\s]+'), '');
  }

  Future<void> fetchCards(String searchText) async {
    http.Response response;
    if (isLogged != null && isLogged == true) {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };

      response = await http.post(
          Uri.parse(ApiService.apiUrl + ApiService.card + ApiService.searching),
          body: {'searchItem': searchText},
          headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        fetchSearchingData(data);
      }
      setState(() {
        isSearching = false;
        isWaiting = false;
      });
    } else if (userAttemps > 0) {
      response = await http.post(
          Uri.parse(ApiService.apiUrl +
              ApiService.card +
              ApiService.unauthorizedSearching),
          body: {'searchItem': searchText});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        fetchSearchingData(data);
      }
      setState(() {
        isWaiting = false;
      });
      setUserAttemps();
    } else {
      setState(() {
        isWaiting = false;
        isSearching = false;
        messageResponse = "You don't have any attemps, please login :D";
      });
    }
  }

  Future<void> homeFetchingBestCard() async {
    http.Response response;
    if (isLogged != null && isLogged == true) {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
      };

      response = await http.post(
          Uri.parse(
              ApiService.apiUrl + ApiService.card + ApiService.homeSearching),
          headers: headers);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        fetchSearchingData(data);
      }
      setState(() {
        isSearching = false;
        isWaiting = false;
      });
    } else if (userAttemps > 0) {
      response = await http.post(Uri.parse(ApiService.apiUrl +
          ApiService.card +
          ApiService.unauthorizedHomeSearching));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        fetchSearchingData(data);
      }
      setState(() {
        isWaiting = false;
      });
    } else {
      setState(() {
        isWaiting = false;
        isSearching = false;
        messageResponse = "You don't have any attemps, please login :D";
      });
    }
  }

  String getImageName(
      String player, String setName, String card, String description) {
    String result = "";
    if (description.isEmpty || description == " ") {
      result = "${("$setName #$card $player Front").replaceAll(" ", "+")}.jpg"
          .replaceAll("#", "%23")
          .replaceAll("*", "");
    } else {
      String name = setName
          .replaceAll("-", " ")
          .replaceAll(description, "- $description");
      result = "${("$name #$card $player Front").replaceAll(" ", "+")}.jpg"
          .replaceAll("#", "%23")
          .replaceAll("*", "");
    }
    return "$ApiService.imageUrl$result";
  }
}
