
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:flutter/material.dart';
import 'CoreScreenWidget.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class CoreScreenState<CS extends CoreScreenWidget> extends State<CS> {

  GlobalKey<ScaffoldState> scaffoldToastKey = new GlobalKey();

  bool haveInitialized = false;
  var isLargeScreen = false;
  var isSafeArea = true;
  var textScaleFactor = 1.0;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 300), () {
      stateIsReady(context);
    });

    Widget mainContent = GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: buildMobileLayout(context),
    );
    Widget scaffold = Material(
        child: MediaQuery(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            key: scaffoldToastKey,
            appBar: createAppBarContent(context),
            body: isSafeArea
                ? SafeArea(bottom: false, child: mainContent)
                : mainContent,
            bottomNavigationBar: bottomNavigationBar(context),
          ),
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        ));

    return Stack(
        children: <Widget>[scaffold],
        alignment: Alignment.center);
  }

  @protected
  Widget buildMobileLayout(BuildContext context);

  @protected
  PreferredSizeWidget createAppBarContent(BuildContext context) {
    return null;
  }
  @protected
  Widget bottomNavigationBar(BuildContext context){
    return null;
  }

  @protected
  void stateIsReady(BuildContext context) {}

  void showToastMessage(String message,
      [ToastGravity gravity = ToastGravity.CENTER]) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: gray5,
        textColor: Colors.black,
        fontSize: 15);
  }
}