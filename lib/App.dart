import 'package:fake_message_screen/route/Router.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'features/home/HomeScreen.dart';
import 'utils/StyleUtils.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          onGenerateRoute: generateRouter,
          theme: ThemeData(
              primaryColor: blue_primary_600,
              fontFamily: "Source Sans Pro",
              focusColor: primaryLightColor,
              selectedRowColor: primaryLightColor,
              disabledColor: gray5,
              textTheme: TextTheme(
                bodyText1: TextStyles.BODY_1.getStyle,
                caption: TextStyles.SUB_HEADING_2.getStyle,
              )),
          home: HomeScreen(),
    );
  }
}
