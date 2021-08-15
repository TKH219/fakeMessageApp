import 'dart:async';

import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/features/home/selectApp/SelectAppScreen.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/ImageAssetsConstant.dart';
import 'package:fake_message_screen/utils/ImageUtils.dart';
import 'package:fake_message_screen/handler/InAppPurchaseHandler.dart';
import 'package:fake_message_screen/handler/StorageManager.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'profile/ProfileScreen.dart';

enum TabType { HOME, PROFILE }

class HomeScreen extends CoreScreenWidget {

  @override
  HomeState createState() => HomeState();
}

class HomeState extends CoreScreenState<HomeScreen> {

  int _currentIndex = 0;
  DateTime? clickedLastTime;

  late StreamSubscription<List<PurchaseDetails>> _subscription;

  final List<Widget> _screensTab = [
    SelectAppScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    final Stream<List<PurchaseDetails>> purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _subscription = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      print("Error");
      // handle error here.
    });

    InAppPurchaseHandler().fetchAllProduct();
  }

  @override
  bool get isSafeArea => false;

  @override
  PreferredSizeWidget? createAppBarContent(BuildContext context) {
    return null;
  }

  @override
  Widget buildMobileLayout(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: IndexedStack(
          children: _screensTab,
          index: _currentIndex,
        )
    );
  }

  @override
  Widget bottomNavigationBar(BuildContext context) {
    return buildBottomNavigationBar();
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: onTabTapped,
      backgroundColor: Colors.white,
      currentIndex: _currentIndex,
      selectedLabelStyle: TextStyles.CAPTION.getStyle.copyWith(color: blue_primary_600),
      unselectedLabelStyle: TextStyles.CAPTION.getStyle.copyWith(color: gray5),
      selectedItemColor: blue_primary_600,
      unselectedItemColor: gray5,
      elevation: 4,
      items: [
        _createBottomBarItem(IC_HOME_TAB_BAR, "Home", TabType.HOME,),
        _createBottomBarItem(IC_PROFILE_TAB_BAR, "Profile", TabType.PROFILE),
      ],
    );
  }

  BottomNavigationBarItem _createBottomBarItem(String icon,
      [String text = "",
        TabType? type,
        bool isCircle = false]) {
    double widthOfIcon = isCircle ? 25 : 20;
    double heightOfIcon = 25;

    final inactiveIcon = ImageUtils.getImagesSvg(icon,
        boxFit: BoxFit.fill,
        width: widthOfIcon,
        height: heightOfIcon,
        color: gray4);

    final activeIcon = ImageUtils.getImagesSvg(icon,
        boxFit: BoxFit.fill,
        width: widthOfIcon,
        height: heightOfIcon,
        color: blue_primary_600);

    return BottomNavigationBarItem(
      icon: inactiveIcon,
      activeIcon: activeIcon,
      label: text,
    );
  }

  void onTabTapped(int index) {
    if(index == _currentIndex) return;
    setState(() {
      _currentIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    bool isBack = false;
    if (clickedLastTime == null) {
      clickedLastTime = DateTime.now();
    } else {
      var now = DateTime.now();
      var diff = now.difference(clickedLastTime ?? now);
      clickedLastTime = now;
      isBack = diff.inMilliseconds < 3000;
    }
    if (!isBack) {
      showToastMessage("Press twice to back", ToastGravity.BOTTOM);
    }
    return isBack;
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          this.showLoadingCircle(true);
          break;
        case PurchaseStatus.error:
          print("errror");
          this.showLoadingCircle(false);
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          print("Payment success");
          StorageManager().setPremium();
          this.showLoadingCircle(false);

          if (purchaseDetails.status == PurchaseStatus.restored) {
            showToastMessage("Your purchase have been restored successfully! Please refresh my profile screen to update.");
          }
          break;
      }

      if (purchaseDetails.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}