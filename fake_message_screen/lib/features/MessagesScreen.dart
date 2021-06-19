import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends CoreScreenWidget {
  @override
  CoreScreenState<MessagesScreen> createState() => MessagesState();
}

class MessagesState extends CoreScreenState<MessagesScreen> {

  @override
  PreferredSizeWidget createAppBarContent(BuildContext context) {
    return AppBar(
      backgroundColor: blue_primary_400,
      leading: IconButton(
        color: Colors.white,
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
    );
    // return PreferredSize(child: Container(
    //   child: ,
    // ), preferredSize: Size.fromHeight(40));
  }

  @override
  Widget buildMobileLayout(BuildContext context) {
    return Container(
        child: Center(
          child: Text('TESTTTT'),
        ),
    );
  }


}