import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/ImageAssetsConstant.dart';
import 'package:fake_message_screen/utils/ImageUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

enum AppSupport {INSTAGRAM, MESSENGER, ZALO, IMESS}

extension AppSupportExtension on AppSupport {
  String get getImagePath {
    switch (this) {
      case AppSupport.INSTAGRAM:
        return IC_CHANGE_PASSWORD;
      case AppSupport.MESSENGER:
        return IC_CHANGE_PASSWORD;
      case AppSupport.ZALO:
        return IC_CHANGE_PASSWORD;
      case AppSupport.IMESS:
        return IC_CHANGE_PASSWORD;
      default:
        return "";
    }
  }

  String get getTitle {
    switch (this) {
      case AppSupport.INSTAGRAM:
        return "Instagram";
      case AppSupport.MESSENGER:
        return "Messenger";
      case AppSupport.ZALO:
        return "Zalo";
      case AppSupport.IMESS:
        return "iMessage";
      default:
        return "";
    }
  }
}

class SelectAppScreen extends CoreScreenWidget {
  @override
  SelectAppState createState() => SelectAppState();
}

class SelectAppState extends CoreScreenState<SelectAppScreen> {

  @override
  PreferredSizeWidget createAppBarContent(BuildContext context) {
    return AppBar(
      backgroundColor: blue_primary_600,
      brightness: Brightness.light,
      title: Text(
        "Fake Chat",
        overflow: TextOverflow.ellipsis,
        style: TextStyles.HEADING_6.getStyle.copyWith(
            fontSize: 18, color: Colors.white),
      ),
    );
  }

  @override
  Widget buildMobileLayout(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20, childAspectRatio: 1),
        itemCount: AppSupport.values.length,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        itemBuilder: (context, index) {
          return _itemAppWidget(AppSupport.values[index].getImagePath);
        });
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
      return Container(
        child: Text("testtt"),
      );
    });
  }

  Widget _itemAppWidget(String imagePath) {
    double size = (MediaQuery.of(context).size.width - 52) / 2;
    return imagePath == ""
        ? SizedBox.shrink()
        : InkWell(
      onTap: () {

      },
          child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: ImageUtils.getOriginalImagesSvg(imagePath,
                  height: size, width: size),
            ),
        );
  }
}