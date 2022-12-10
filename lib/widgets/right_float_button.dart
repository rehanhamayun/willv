import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/card.dart';
import 'package:flutter_application_1/Models/favorit_card.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/util/ApiServices.dart';
import 'package:flutter_application_1/util/colors.dart';
import 'package:flutter_application_1/widgets/jumping_dots.dart';
import 'package:http/http.dart' as http;

class RightFloatButton extends StatefulWidget {
  final bool? forAddingToFavorit;
  final String? cardName;
  final String? cardId;
  final String? awsImage;

  const RightFloatButton({
    Key? key,
    this.forAddingToFavorit = false,
    this.cardName,
    this.cardId,
    this.awsImage,
  }) : super(key: key);
  @override
  State<RightFloatButton> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<RightFloatButton> {
  final bool isOpened = false;
  final List<String> _listCard2 = [];
  late String token;
  late bool isLogged = false;
  bool isLikePressed = false;
  bool isCardExistInFavorits = false;

  @override
  initState() {
    getUserAttempsAndLogged();
    if (widget.forAddingToFavorit != null &&
        widget.forAddingToFavorit == true) {
      existInFavorits();
      initFavorit();
    }

    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  void getUserAttempsAndLogged() async {
    if (mounted) {
      setState(() {
        isLogged = prefs.getBool('isLogged') ?? false;
        token = prefs.getString('accessToken') ?? '';
      });
    }
  }

  void initFavorit() async {
    await getFavoritCards();
  }

  existInFavorits() {
    if (_listCard2.contains(widget.cardId)) {
      setState(() {
        isCardExistInFavorits = true;
      });
    } else {
      setState(() {
        isCardExistInFavorits = false;
      });
    }
  }

  Future<bool> cardExistInFavorits() async {
    if (_listCard2.contains(widget.cardId)) {
      return true;
    } else {
      return false;
    }
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
        setState(() {
          _listCard2.add(FavoritCard.fromJson(element).gemId!);
        });
      });
      existInFavorits();
    }
  }

  void addFavoritCard() async {
    http.Response response;
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    response = await http.post(
        Uri.parse(
            ApiService.apiUrl + ApiService.card + ApiService.addFavoriteCard),
        body: {
          'cardName': widget.cardName!,
          "GemId": widget.cardId!,
          "CardUrl": widget.awsImage ?? "",
        },
        headers: headers);
    if (response.statusCode == 200) {
      setState(() {
        isLikePressed = false;
      });
      _showToast("Added to favorite");
    }
    getFavoritCards();
  }

  void deleteFavoritCard() async {
    setState(() {
      _listCard2.removeWhere((element) => element == widget.cardId);
    });
    http.Response response;
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
    };

    response = await http.post(
        Uri.parse(
            ApiService.apiUrl + ApiService.card + ApiService.deleteFavoritCard),
        body: {'cardId': widget.cardId},
        headers: headers);

    if (response.statusCode == 200) {
      setState(() {
        isLikePressed = false;
      });
      _showToast("Deleted from favorite");
    }
    existInFavorits();
  }

  void _showToast(String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        // action: SnackBarAction( label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
        child: widget.forAddingToFavorit!
            ? SizedBox(
                child: isLikePressed
                    ? const JumpingDots(
                        numberOfDots: 3,
                      )
                    : FutureBuilder(
                        future: cardExistInFavorits(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return const JumpingDots(
                              numberOfDots: 3,
                            );
                          } else {
                            if (isCardExistInFavorits) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isLikePressed = true;
                                  });
                                  deleteFavoritCard();
                                },
                                child: const Icon(
                                  Icons.favorite_rounded,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isLikePressed = true;
                                  });
                                  addFavoritCard();
                                },
                                child: const Icon(
                                  Icons.favorite_border_rounded,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              );
                            }
                          }
                        },
                      ),
              )
            : const Icon(
                Icons.menu,
                size: 40,
                color: Colors.white,
              ),
      ), //Icon
    );
  }
}
