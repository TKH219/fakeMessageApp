import 'package:fake_message_screen/features/home/HomeScreen.dart';
import 'package:fake_message_screen/features/home/selectApp/SelectAppScreen.dart';
import 'package:fake_message_screen/features/iMessageDetail/IMessageDetailScreen.dart';
import 'package:fake_message_screen/features/instagramMessageDetail/InstagramMessageDetailScreen.dart';
import 'package:fake_message_screen/features/zaloMessageDetail/ZaloMessagesDetailScreen.dart';
import 'package:flutter/material.dart';
import 'RouterConstant.dart';

Route<dynamic> generateRouter(RouteSettings setting) {
  switch (setting.name) {
    case HomeScreenRouter:
      return MaterialPageRoute(builder: (context) => HomeScreen());
    case ZaloMessageDetailRouter:
      return MaterialPageRoute(builder: (context) => ZaloMessagesDetailScreen());
    case InstagramMessageDetailRouter:
      return MaterialPageRoute(builder: (context) => setting.arguments == null ? InstagramMessageDetailScreen() : InstagramMessageDetailScreen(appSupport: setting.arguments! as AppSupport));
    case IMessageDetailRouter:
      return MaterialPageRoute(builder: (context) => IMessageDetailScreen());
    default:
      return MaterialPageRoute(builder: (context) => HomeScreen());
  }
}