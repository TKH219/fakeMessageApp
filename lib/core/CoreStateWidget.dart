
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'CoreScreenWidget.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class CoreScreenState<CS extends CoreScreenWidget> extends State<CS> {

  GlobalKey<ScaffoldState> scaffoldToastKey = new GlobalKey();

  bool haveInitialized = false;
  var isLargeScreen = false;
  var isSafeArea = true;
  var textScaleFactor = 1.0;
  bool showFunctionButton = true;

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 300), () {
      stateIsReady(context);
    });

    Widget mainContent = GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
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

    return Screenshot(
        controller: screenshotController,
        child: Stack(children: <Widget>[scaffold], alignment: Alignment.center));
  }

  @protected
  Widget buildMobileLayout(BuildContext context);

  @protected
  PreferredSizeWidget? createAppBarContent(BuildContext context) {
    return null;
  }
  @protected
  Widget? bottomNavigationBar(BuildContext context){
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
        backgroundColor: gray4,
        textColor: black_4a,
        fontSize: 15);
  }

  void showLoadingCircle(bool isLoading) {
    if (isLoading) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>
            Center(
              child: Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: gray2,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CupertinoActivityIndicator(
                    animating: true, radius: 15,),
                ),
              ),
            ),
      );
    } else {
      Navigator.of(context).pop();
    }
  }
}