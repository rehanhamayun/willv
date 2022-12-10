import 'package:flutter/material.dart';

class MySpaceSizedBoxer extends StatelessWidget {
  const MySpaceSizedBoxer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(2),
      child: Divider(
        color: Colors.white24,
        thickness: 1,
      ),
    );
  }
}
