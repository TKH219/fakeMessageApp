import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/route/RouterConstant.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/ImageAssetsConstant.dart';
import 'package:fake_message_screen/utils/ImageUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AppSupport {INSTAGRAM, MESSENGER, ZALO, IMESS}

extension AppSupportExtension on AppSupport {
  String get getImagePath {
    switch (this) {
      case AppSupport.INSTAGRAM:
        return IC_IG_PNG;
      case AppSupport.MESSENGER:
        return IC_MESSAGER_PNG;
      case AppSupport.ZALO:
        return IC_ZALO_PNG;
      case AppSupport.IMESS:
        return IC_IMESS_PNG;
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
        "Fake Chat Screen",
        overflow: TextOverflow.ellipsis,
        style: TextStyles.HEADING_6.getStyle.copyWith(fontSize: 20, color: Colors.white),
      ),
    );
  }

  @override
  Widget buildMobileLayout(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 16,
            childAspectRatio: 1),
        itemCount: AppSupport.values.length,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        // shrinkWrap: true,
        itemBuilder: (context, index) {
          return _itemAppWidget(AppSupport.values[index]);
        });
  }

  Widget _itemAppWidget(AppSupport appSupport) {

    double size = (MediaQuery.of(context).size.width - 48) / 2;

    return  Card(
      elevation: 2.0,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0))),
      child: InkWell(
        onTap: () {
          switch (appSupport) {
            case AppSupport.IMESS:
              Navigator.of(context).pushNamed(IMessageDetailRouter);
              break;
            case AppSupport.INSTAGRAM:
              Navigator.of(context).pushNamed(InstagramMessageDetailRouter);
              break;
            case AppSupport.MESSENGER:
              Navigator.of(context).pushNamed(InstagramMessageDetailRouter, arguments: AppSupport.MESSENGER);
              break;
            case AppSupport.ZALO:
              Navigator.of(context).pushNamed(ZaloMessageDetailRouter);
              break;
            default:
              break;
          }
        },
        child: Column(
          children: [
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              child: appSupport == AppSupport.ZALO || appSupport == AppSupport.MESSENGER
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: ImageUtils.getPngImage(appSupport.getImagePath,
                          height: size - 56, width: size - 56),
                    )
                  : ImageUtils.getPngImage(appSupport.getImagePath,
                      height: size - 56, width: size - 56),
            ),
            Text(appSupport.getTitle, style: TextStyles.BODY_2.getStyle.copyWith(color: Colors.black),)
          ],
        ),
      ),
    );
  }
}