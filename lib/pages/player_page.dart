import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/card.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/ApiServices.dart';
import 'package:flutter_application_1/util/colors.dart';
import 'package:flutter_application_1/widgets/jumping_dots.dart';
import 'package:flutter_application_1/widgets/right_float_button.dart';
import 'package:http/http.dart' as http;

class PlayerPage extends StatefulWidget {
  final String? card;
  final String? cardId;
  final String? awsImage;
  final String? grader;

  const PlayerPage({
    Key? key,
    this.card,
    this.cardId,
    this.awsImage,
    this.grader,
  }) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  double fullHeight = 0;
  double fullWidth = 0;

  int gemCount = 0;
  double gemRate = 0.0000;

  String mostCommonGradePSA = "";
  String mostCommonGradeBGS = "";
  String mostCommonGradeSGC = "";
  String mostCommonGradeCSG = "";
  String mostCommonGradeBECKETT = "";

  bool isLoading = true;
  bool isfetchingDone = false;
  late String token;
  late CardResult cardResult;
  List<GradesJson> gradesJsons = [];

  int cardTotalPsaGrades = 0;
  int cardPsaGems = 0;
  String cardGemPsaRate = "";

  int cardTotalBgsGrades = 0;
  int cardBgsGems = 0;
  String cardGemBgsRate = "";

  int cardTotalSgcGrades = 0;
  int cardSgcGems = 0;
  String cardGemSgcRate = "";

  int cardTotalCsgGrades = 0;
  int cardCsgGems = 0;
  String cardGemCsgRate = "";

  int cardTotalBeckettGrades = 0;
  int cardBeckettGems = 0;
  String cardGemBeckettRate = "";

  int totalGemGrades = 0;
  int totalGemCount = 0;
  double totalGemRate = 0;

  @override
  void initState() {
    getUserAttempsAndLogged();
    super.initState();
    fetchCard(
      cardId: widget.cardId!,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchCard({
    required String cardId,
  }) async {
    http.Response response;

    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    var body = {
      'cardId': cardId,
    };

    if (token == null || token == '') {
      response = await http.post(
          Uri.parse(ApiService.apiUrl +
              ApiService.card +
              ApiService.unauthorizedGetCardById),
          body: body,
          headers: headers);
    } else {
      response = await http.post(
          Uri.parse(
              ApiService.apiUrl + ApiService.card + ApiService.getCardById),
          body: body,
          headers: headers);
    }

    if (response.statusCode == 200) {
      setState(() {
        cardResult = CardResult.fromJson(jsonDecode(response.body));
        isLoading = false;
      });
      intitalApiData(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Card');
    }
    setState(() {
      isfetchingDone = true;
    });
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
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 1.5,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        isLoading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  JumpingDots(
                                    numberOfDots: 3,
                                  )
                                ],
                              )
                            : Text(
                                "${cardResult.populationData![0].year!} ${cardResult.populationData![0].setName!}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700),
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Player',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                                isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          JumpingDots(
                                            numberOfDots: 3,
                                          )
                                        ],
                                      )
                                    : SizedBox(
                                        width: fullWidth * .73,
                                        child: Text(
                                          cardResult.populationData![0].name!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 34,
                                              fontWeight: FontWeight.w700),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  'Card',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                                isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          JumpingDots(
                                            numberOfDots: 3,
                                          )
                                        ],
                                      )
                                    : RichText(
                                        text: TextSpan(
                                            text: '#',
                                            style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w300),
                                            children: [
                                              TextSpan(
                                                text: cardResult
                                                    .populationData![0]
                                                    .cardNumber!,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 24,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              )
                                            ]),
                                      ),
                                // isLoading
                                //     ? const JumpingDots()
                                //     : RichText(
                                //         text: TextSpan(
                                //             text: '#',
                                //             style: const TextStyle(
                                //                 color: Colors.white70,
                                //                 fontSize: 18,
                                //                 fontWeight: FontWeight.w300),
                                //             children: [
                                //               TextSpan(
                                //                 text: widget.card!,
                                //                 style: const TextStyle(
                                //                     color: Colors.white,
                                //                     fontSize: 24,
                                //                     fontWeight:
                                //                         FontWeight.w700),
                                //               )
                                //             ]),
                                //       ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          width: fullWidth / 2.6,
                          child: const Divider(
                            color: Colors.white,
                            thickness: 1.5,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            widget.awsImage == null || widget.awsImage!.isEmpty
                                ? Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/auth/Sign_Up_BG_Image.jpg'),
                                      fit: BoxFit.fill,
                                    )),
                                  )
                                : Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(1),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: rightFloatingButton,
                                          spreadRadius: 5,
                                          blurRadius: 0,
                                          offset: Offset(-35, 15),
                                        ),
                                      ],
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.awsImage!,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Center(
                                              child: Container(
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/auth/Sign_Up_BG_Image.jpg'),
                                          fit: BoxFit.fill,
                                        )),
                                      )),
                                    ),
                                  ),
                            Wrap(
                              direction: Axis.vertical,
                              spacing: 8,
                              crossAxisAlignment: WrapCrossAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "STATS",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        isLoading
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: const [
                                                  JumpingDots(
                                                    numberOfDots: 4,
                                                  )
                                                ],
                                              )
                                            : Text(
                                                cardResult.totalPopulation
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 36,
                                                    color: Colors.white),
                                              ),
                                        const Text(
                                          "Total graded",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Image.asset(
                                      'assets/images/icons/arrows.png',
                                      height: 20,
                                      width: 20,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        isLoading
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: const [
                                                  JumpingDots(
                                                    numberOfDots: 4,
                                                  )
                                                ],
                                              )
                                            : Text(
                                                gemCount.toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 36,
                                                    color: Colors.white),
                                              ),
                                        const Text(
                                          "Gem count",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Image.asset(
                                      'assets/images/icons/gemicon.png',
                                      height: 20,
                                      width: 20,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        isLoading
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: const [
                                                  JumpingDots(
                                                    numberOfDots: 4,
                                                  )
                                                ],
                                              )
                                            : Text(
                                                "${totalGemRate.toString().length > 3 ? totalGemRate.toString().substring(0, 4).substring(2) : totalGemRate.toString()}%",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 36,
                                                    color: Colors.white),
                                              ),
                                        const Text(
                                          "Gem rate",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Image.asset(
                                      'assets/images/icons/checkmark.png',
                                      height: 20,
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Wrap(
                              direction: Axis.vertical,
                              spacing: 16,
                              runSpacing: 10,
                              crossAxisAlignment: WrapCrossAlignment.end,
                              children: const [
                                Text(
                                  "Total Graded",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Most Common",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Gem Count",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Gem Rate",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                              ],
                            ),

                            //PSA
                            Wrap(
                              direction: Axis.vertical,
                              spacing: 12,
                              runSpacing: 8,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "PSA",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 22,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: fullWidth / 8,
                                      child: const Divider(
                                        color: Colors.white,
                                        thickness: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                                isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          JumpingDots(
                                            numberOfDots: 3,
                                          )
                                        ],
                                      )
                                    : Text(
                                        cardTotalPsaGrades > 0
                                            ? cardTotalPsaGrades.toString()
                                            : 'N/A',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          JumpingDots(
                                            numberOfDots: 3,
                                          )
                                        ],
                                      )
                                    : Text(
                                        mostCommonGradePSA.isNotEmpty
                                            ? "PSA ${replaceSpecialChar(mostCommonGradePSA)}"
                                            : 'N/A',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16,
                                            color: Colors.white),
                                      ),
                                isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          JumpingDots(
                                            numberOfDots: 3,
                                          )
                                        ],
                                      )
                                    : Text(
                                        cardPsaGems > 0
                                            ? cardPsaGems.toString()
                                            : 'N/A',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          JumpingDots(
                                            numberOfDots: 3,
                                          )
                                        ],
                                      )
                                    : Text(
                                        cardGemPsaRate.isNotEmpty
                                            ? "${cardGemPsaRate.toString().length > 3 ? cardGemPsaRate.toString().substring(0, 4).substring(2) : cardGemPsaRate.toString()}%"
                                            : 'N/A',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                              ],
                            ),

                            // BGS
                            Wrap(
                              direction: Axis.vertical,
                              spacing: 12,
                              runSpacing: 8,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "BGS",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 22,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: fullWidth / 8,
                                      child: const Divider(
                                        color: Colors.white,
                                        thickness: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                                isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          JumpingDots(
                                            numberOfDots: 3,
                                          )
                                        ],
                                      )
                                    : Text(
                                        cardTotalBgsGrades > 0
                                            ? cardTotalBgsGrades.toString()
                                            : 'N/A',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          JumpingDots(
                                            numberOfDots: 3,
                                          )
                                        ],
                                      )
                                    : Text(
                                        mostCommonGradeBGS.isNotEmpty
                                            ? "BGS ${replaceSpecialChar(mostCommonGradeBGS)}"
                                            : 'N/A',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16,
                                            color: Colors.white),
                                      ),
                                isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          JumpingDots(
                                            numberOfDots: 3,
                                          )
                                        ],
                                      )
                                    : Text(
                                        cardBgsGems > 0
                                            ? cardBgsGems.toString()
                                            : 'N/A',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          JumpingDots(
                                            numberOfDots: 3,
                                          )
                                        ],
                                      )
                                    : Text(
                                        cardGemBgsRate.isNotEmpty
                                            ? "${cardGemBgsRate.toString().length > 3 ? cardGemBgsRate.toString().substring(0, 4).substring(2) : cardGemBgsRate.toString()}%"
                                            : 'N/A',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                              ],
                            ),

                            // SGC
                            Wrap(
                              direction: Axis.vertical,
                              spacing: 12,
                              runSpacing: 8,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "SGC",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 22,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: fullWidth / 8,
                                      child: const Divider(
                                        color: Colors.white,
                                        thickness: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                                isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          JumpingDots(
                                            numberOfDots: 3,
                                          )
                                        ],
                                      )
                                    : Text(
                                        cardTotalSgcGrades > 0
                                            ? cardTotalSgcGrades.toString()
                                            : 'N/A',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          JumpingDots(
                                            numberOfDots: 3,
                                          )
                                        ],
                                      )
                                    : Text(
                                        mostCommonGradeSGC.isNotEmpty
                                            ? "SGC ${replaceSpecialChar(mostCommonGradeSGC)}"
                                            : 'N/A',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16,
                                            color: Colors.white),
                                      ),
                                isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          JumpingDots(
                                            numberOfDots: 3,
                                          )
                                        ],
                                      )
                                    : Text(
                                        cardSgcGems > 0
                                            ? cardSgcGems.toString()
                                            : 'N/A',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          JumpingDots(
                                            numberOfDots: 3,
                                          )
                                        ],
                                      )
                                    : Text(
                                        cardGemSgcRate.isNotEmpty
                                            ? "${cardGemSgcRate.toString().length > 3 ? cardGemSgcRate.toString().substring(0, 4).substring(2) : cardGemSgcRate.toString()}%"
                                            : 'N/A',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                              ],
                            ),

                            //CSG
                            Wrap(
                              direction: Axis.vertical,
                              spacing: 12,
                              runSpacing: 8,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "CSG",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 22,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      width: fullWidth / 8,
                                      child: const Divider(
                                        color: Colors.white,
                                        thickness: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                                isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          JumpingDots(
                                            numberOfDots: 3,
                                          )
                                        ],
                                      )
                                    : Text(
                                        cardTotalCsgGrades > 0
                                            ? cardTotalCsgGrades.toString()
                                            : 'N/A',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          JumpingDots(
                                            numberOfDots: 3,
                                          )
                                        ],
                                      )
                                    : Text(
                                        mostCommonGradeCSG.isNotEmpty
                                            ? "CSG ${replaceSpecialChar(mostCommonGradeCSG)}"
                                            : 'N/A',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16,
                                            color: Colors.white),
                                      ),
                                isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          JumpingDots(
                                            numberOfDots: 3,
                                          )
                                        ],
                                      )
                                    : Text(
                                        cardCsgGems > 0
                                            ? cardCsgGems.toString()
                                            : 'N/A',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                                isLoading
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          JumpingDots(
                                            numberOfDots: 3,
                                          )
                                        ],
                                      )
                                    : Text(
                                        cardGemCsgRate.isNotEmpty
                                            ? "${cardGemCsgRate.toString().length > 3 ? cardGemCsgRate.toString().substring(0, 4).substring(2) : cardGemCsgRate.toString()}%"
                                            : 'N/A',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: Colors.white),
                                      ),
                              ],
                            ),
                          ],
                        )
                      ]),
                )
              ],
            ),
            isfetchingDone
                ? RightFloatButton(
                    forAddingToFavorit: true,
                    cardId: widget.cardId,
                    cardName: widget.card,
                    awsImage: widget.awsImage,
                  )
                : Positioned(
                    bottom: -10,
                    right: -10,
                    child: Container(
                        height: 80,
                        width: 100,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(80),
                              topRight: Radius.circular(45),
                              bottomLeft: Radius.circular(20),
                            ),
                            color: rightFloatingButton),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            JumpingDots(
                              numberOfDots: 3,
                            )
                          ],
                        )))
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: "btn1",
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

  void intitalApiData(dynamic body) {
    calucalateData();

    for (int i = 0; i < body['graders_included'].length; i++) {
      switch (body['graders_included'][i].toString()) {
        case "psa":
          {
            int maxValue = 0;
            cardTotalPsaGrades =
                body['population_data'][i]['card_total_grades'];
            cardPsaGems = body['population_data'][i]['card_gems'];
            cardGemPsaRate = body['population_data'][i]['card_gem_rate'];
            totalGemGrades += cardTotalPsaGrades;
            totalGemCount += cardPsaGems;
            if (body['population_data'][i]['grades_json'].entries != null) {
              for (final element
                  in body['population_data'][i]['grades_json'].entries) {
                if (element.value > maxValue) {
                  maxValue = element.value;
                  mostCommonGradePSA = element.key;
                }
              }
            }
          }
          break;

        case "bgs":
          {
            int maxValue = 0;
            cardTotalBgsGrades =
                body['population_data'][i]['card_total_grades'];
            cardBgsGems = body['population_data'][i]['card_gems'];
            cardGemBgsRate = body['population_data'][i]['card_gem_rate'];
            totalGemGrades += cardTotalBgsGrades;
            totalGemCount += cardBgsGems;
            for (final element
                in body['population_data'][i]['grades_json'].entries) {
              if (element.value > maxValue) {
                maxValue = element.value;
                mostCommonGradeBGS = element.key;
              }
            }
          }
          break;

        case "sgc":
          {
            int maxValue = 0;
            cardTotalSgcGrades =
                body['population_data'][i]['card_total_grades'];
            cardSgcGems = body['population_data'][i]['card_gems'];
            cardGemSgcRate = body['population_data'][i]['card_gem_rate'];
            totalGemGrades += cardTotalSgcGrades;
            totalGemCount += cardSgcGems;
            for (final element
                in body['population_data'][i]['grades_json'].entries) {
              if (element.value > maxValue) {
                maxValue = element.value;
                mostCommonGradeSGC = element.key;
              }
            }
          }
          break;

        case "csg":
          {
            int maxValue = 0;
            cardTotalCsgGrades =
                body['population_data'][i]['card_total_grades'];
            cardCsgGems = body['population_data'][i]['card_gems'];
            cardGemCsgRate = body['population_data'][i]['card_gem_rate'];
            totalGemGrades += cardTotalCsgGrades;
            totalGemCount += cardCsgGems;
            for (final element
                in body['population_data'][i]['grades_json'].entries) {
              if (element.value > maxValue) {
                maxValue = element.value;
                mostCommonGradeCSG = element.key;
              }
            }
          }
          break;

        case "beckett":
          {
            int maxValue = 0;
            cardTotalBgsGrades =
                body['population_data'][i]['card_total_grades'];
            cardBgsGems = body['population_data'][i]['card_gems'];
            cardGemBgsRate = body['population_data'][i]['card_gem_rate'];
            totalGemGrades += cardTotalBgsGrades;
            totalGemCount += cardBgsGems;
            for (final element
                in body['population_data'][i]['grades_json'].entries) {
              if (element.value > maxValue) {
                maxValue = element.value;
                mostCommonGradeBGS = element.key;
              }
            }
          }
          break;

        default:
          {}
          break;
      }
    }
    totalGemRate = totalGemCount / totalGemGrades;
  }

  void calucalateData() {
    for (var element in cardResult.populationData!) {
      gemCount = gemCount + element.cardGems!;
      if (element.cardGemRate!.length > 2) {
        gemRate = gemRate + double.parse(element.cardGemRate!);
      }
    }
  }

  String replaceSpecialChar(String char) {
    String result = char.replaceAll(RegExp('[^0-9]'), '.');
    String result2 = result.replaceFirst('.', '');
    return result2.toUpperCase();
  }

  void getUserAttempsAndLogged() async {
    setState(() {
      token = prefs.getString('accessToken') ?? '';
    });
  }
}
