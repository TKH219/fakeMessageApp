import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/ImageAssetsConstant.dart';
import 'package:fake_message_screen/utils/ImageUtils.dart';
import 'package:fake_message_screen/handler/InAppPurchaseHandler.dart';
import 'package:fake_message_screen/handler/StorageManager.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'CustomView/InfoProfileItemWidget.dart';

enum ProfileScreenStructure { UPGRADE_PREMIUM, RESTORE_PREMIUM, SIGN_OUT }

extension ProfileScreenStructureExtension on ProfileScreenStructure {
  String getTitle() {
    switch (this) {
      case ProfileScreenStructure.UPGRADE_PREMIUM:
        return "Upgrade VIP";
      case ProfileScreenStructure.SIGN_OUT:
        return "Đăng xuất";
      case ProfileScreenStructure.RESTORE_PREMIUM:
        return "Restore VIP";
      default:
        return "";
    }
  }

  String getImagePath() {
    switch (this) {
      case ProfileScreenStructure.UPGRADE_PREMIUM:
        return IC_CHANGE_PASSWORD;
      case ProfileScreenStructure.RESTORE_PREMIUM:
        return IC_CHANGE_PASSWORD;
      case ProfileScreenStructure.SIGN_OUT:
        return IC_CHANGE_PASSWORD;
      default:
        return IC_CHANGE_PASSWORD;
    }
  }
}

class ProfileScreen extends CoreScreenWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends CoreScreenState<ProfileScreen> {

  bool isPremiumUser = false;

  RefreshController refreshController = RefreshController();

  @override
  PreferredSizeWidget createAppBarContent(BuildContext context) {
    return AppBar(
      backgroundColor: blue_primary_600,
      brightness: Brightness.light,
      title: Text(
        "My Profile",
        overflow: TextOverflow.ellipsis,
        style: TextStyles.HEADING_6.getStyle
            .copyWith(fontSize: 18, color: Colors.white),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getRoleUser();
  }

  @override
  Widget buildMobileLayout(BuildContext context) {
    var numberFields = ProfileScreenStructure.values.length;

    return Container(
      color: backgroundColor,
      child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          header: MaterialClassicHeader(),
          footer: CustomFooter(
            builder: (context, mode) {
              Widget body = SizedBox.shrink();
              if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: refreshController,
          onRefresh: onRefresh,
          child: ListView.builder(
              itemCount: numberFields + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildSubProfileInfo();
                }
                if (index == numberFields + 1) {
                  return Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Version 1.0.0",
                          style: TextStyles.BODY_2.getStyle
                              .copyWith(color: gray9, fontSize: 12),
                        ),
                      ));
                }

                return _buildAccountItem(index - 1);
              })),
    );
  }

  Widget _buildSubProfileInfo() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                color: gray1,
                width: 1,
              ),
              bottom: BorderSide(
                color: gray1,
                width: 1,
              )),
          color: Colors.white),
      margin: EdgeInsets.only(top: 33, bottom: 17),
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 24,
          ),
          ImageUtils.getOriginalImagesSvg(IC_AVATAR_DEFAULT,
              width: 50, height: 50),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(getTitleUser(),
                style: TextStyles.NORMAL_LABEL.getStyle.copyWith(color: gray9)),
          ),
          Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(
                Icons.arrow_forward_ios,
                color: gray3,
                size: 16,
              )),
        ],
      ),
    );
  }

  Widget _buildAccountItem(int index) {
    return InfoProfileItemWidget(
      title: ProfileScreenStructure.values[index].getTitle(),
      imagePath: IC_CHANGE_PASSWORD,
      onTapItem: () => onTapItem(index),
      hasPadding: false,
    );
  }

  void getRoleUser() async {
    await StorageManager().getPremium().then((_isPremium) {
      setState(() {
        this.isPremiumUser = _isPremium;
      });
    });
  }

  String getTitleUser() {
    return this.isPremiumUser ? "Premium User" : "Normal User";
  }

  onRefresh() {
    getRoleUser();
    refreshController.refreshCompleted();
  }

  void onTapItem(int index) {
    if (isPremiumUser) {
      showToastMessage("You already are premium.");
      return;
    }

    switch (ProfileScreenStructure.values[index]) {
      case ProfileScreenStructure.RESTORE_PREMIUM:
        this.showLoadingCircle(true);
        InAppPurchaseHandler().restorePurchase();
        break;
      case ProfileScreenStructure.UPGRADE_PREMIUM:
        InAppPurchaseHandler().makingPurchase();
        break;
      default:
        break;
    }
  }
}
