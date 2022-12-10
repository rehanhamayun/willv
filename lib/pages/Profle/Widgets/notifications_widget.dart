import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/colors.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Notification',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Transform.scale(
                  scale: 1,
                  child: Switch(
                    onChanged: (value) {
                      setState(() {
                        status = !status;
                      });
                    },
                    value: status,
                    activeColor: rightFloatingButton,
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: rightFloatingButton,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Notification',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Transform.scale(
                  scale: 1,
                  child: Switch(
                    onChanged: (value) {
                      setState(() {
                        status = !status;
                      });
                    },
                    value: status,
                    activeColor: rightFloatingButton,
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: rightFloatingButton,
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Notification',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Transform.scale(
                  scale: 1,
                  child: Switch(
                    onChanged: (value) {
                      setState(() {
                        status = !status;
                      });
                    },
                    value: status,
                    activeColor: rightFloatingButton,
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: rightFloatingButton,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
