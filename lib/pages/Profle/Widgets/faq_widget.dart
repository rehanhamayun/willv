import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/util/colors.dart';

class FaqWidget extends StatefulWidget {
  const FaqWidget({Key? key}) : super(key: key);

  @override
  State<FaqWidget> createState() => _AlertsWidgetState();
}

class _AlertsWidgetState extends State<FaqWidget> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                '-Where do you get your data from, and how often does it update?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'All grading totals update daily, and are sourced directly from the PSA, BGS, SGC, and CSG’s Pop Reports by GemRate',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Why do I care about how many Gems a card gets, or how many total cards are graded?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Basic economics are at play: the laws of supply and demand. Assuming a sufficient level of demand, the lower the supply of a specific commodity, the more valuable it is',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                '-Why should I use this app, and not check the Pop Reports myself?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'I mean you could, and you could also drive all the way to the library and check out a book if you want to learn about the rare Venezuelian Red Llama. Or you could just look at Wikpedia. \n With PopCheck, all the crucial data you need is in one location! You don\'t have to look at four different sites, pour through all those charts to try and figure out if a card is worth investing in.',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'What does a subscription get me?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '\$3 a month or \$20 a year will get you unlimited searches and the ability to bookmark cards on your own watchlist.',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                '-Where are the other grading companie\'s data like CSG, GMA, HGA, ISA, AAA, SXE, G4U?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Ok some of those are made up, but we feel these big four have enough graded in their databases to best help you make an informed decision. \n We will always be looking at the hobby to see if other datasets should be added. ',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'What sportscards and non sportscards are you tracking?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Baseball, Basketball, Football, Hockey, TCG, Soccer, Golf, Boxing, Wrestling, and UFC. \n As well as a large amount of Non Sport cards like Marvel and Garbage Pail Kids.\n Our database is constantly growing!',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                '-What do I do if I can\'t find a card I’m looking for, or if I think the data is wrong?\n What if I’m just feeling a little defeated by the struggle of life? ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Email us directly! We’d love to hear from you contact@pop-check.com',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
