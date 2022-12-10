import 'package:flutter/material.dart';

// const Color myColor = Color(0xff00bfa5);

class FunkyOverlay extends StatefulWidget {
  final String text;

  const FunkyOverlay({required this.text, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(widget.text)),
                  Divider(
                    thickness: 1,
                    color: Colors.grey.shade300,
                  ),
                  const InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                      child: Text(
                        "Account creation",
                        style: TextStyle(color: Colors.green),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}



// openAlertBox({required BuildContext context, required String text}) {
//   return showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(22.0))),
//           contentPadding: const EdgeInsets.only(top: 10.0),
//           content: SizedBox(
//             width: MediaQuery.of(context).size.width * .7,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 const SizedBox(
//                   height: 5.0,
//                 ),
//                 Padding(padding: const EdgeInsets.all(22), child: Text(text)),
//                 InkWell(
//                   child: Container(
//                     padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
//                     decoration: const BoxDecoration(
//                       color: myColor,
//                       borderRadius: BorderRadius.only(
//                           bottomLeft: Radius.circular(22.0),
//                           bottomRight: Radius.circular(22.0)),
//                     ),
//                     child: const Text(
//                       "Account creation",
//                       style: TextStyle(color: Colors.white),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }).then((value) => {Navigator.pop(context)});
// }
