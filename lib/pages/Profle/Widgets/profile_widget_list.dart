import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Profle/Widgets/alerts_widget.dart';
import 'package:flutter_application_1/pages/Profle/Widgets/faq_widget.dart';
import 'package:flutter_application_1/pages/Profle/Widgets/notifications_widget.dart';
import 'package:flutter_application_1/pages/Profle/Widgets/subscription_widget.dart';

class ItemModel {
  bool expanded;
  String headerItem;
  Widget widget;

  ItemModel({
    this.expanded = false,
    required this.headerItem,
    required this.widget,
  });
}

List<ItemModel> itemData = <ItemModel>[
  // ItemModel(headerItem: 'Notification', widget: const NotificationWidget()),
  // ItemModel(headerItem: 'Subscription', widget: const SubscriptiionWidget()),
  // ItemModel(headerItem: 'Alert', widget: const AlertsWidget()),
  ItemModel(headerItem: 'FAQ', widget: const FaqWidget()),
];
