import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'CustomView/IncomingZaloMessageWidget.dart';
import 'CustomView/OutgoingZaloMessageWidget.dart';
import 'CustomView/ZaloMessageInputWidget.dart';

class ZaloMessagesDetailScreen extends CoreScreenWidget {
  @override
  CoreScreenState<ZaloMessagesDetailScreen> createState() => ZaloMessagesDetailState();
}

class ZaloMessagesDetailState extends CoreScreenState<ZaloMessagesDetailScreen> {

  @override
  bool get isSafeArea => false;

  @override
  PreferredSizeWidget createAppBarContent(BuildContext context) {
    return AppBar(
      backgroundColor: blue_primary_400,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
      centerTitle: false,
      leadingWidth: 12,
      titleSpacing: 40,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mr Ha",
            style:
                TextStyles.NORMAL_LABEL.getStyle.copyWith(color: Colors.white),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 4,
          ),
          Text("Truy cap 20 phut truoc",
              style: TextStyles.CAPTION.getStyle.copyWith(color: Colors.white),
              textAlign: TextAlign.left),
        ],
      ),
      actions: [
        IconButton(
          color: Colors.white,
          icon: Icon(Icons.call_outlined),
          padding: EdgeInsets.only(left: 18),
          iconSize: 24,
          onPressed: () => Navigator.pop(context),
        ),
        IconButton(
          color: Colors.white,
          icon: Icon(Icons.video_camera_back_rounded),
          iconSize: 24,
          padding: EdgeInsets.only(left: 18),
          onPressed: () => Navigator.pop(context),
        ),
        IconButton(
          color: Colors.white,
          icon: Icon(Icons.storage),
          iconSize: 24,
          padding: EdgeInsets.only(left: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ],
      leading: IconButton(
        color: Colors.white,
        icon: Icon(Icons.arrow_back_ios),
        padding: EdgeInsets.only(left: 18),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Widget buildMobileLayout(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          ListView.builder(
              itemCount: 9,
              itemBuilder: (context, index) {
                if (index % 3 == 0) {
                  return OutgoingZaloMessageWidget(
                      index % 2 == 0
                          ? "testttt"
                          : "Đây là mã vạch khai báo y tế..các cô chú có thể khai ở nhà rồi mình ra xét nghiệm cho nhanh ậ. Xin cảm ơn",
                      "11:20");
                }

                return IncomingZaloMessageWidget(
                    index % 2 == 0
                        ? "testttt"
                        : "Đây là mã vạch khai báo y tế..các cô chú có thể khai ở nhà rồi mình ra xét nghiệm cho nhanh ậ. Xin cảm ơn",
                    "11:20");
              }),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ZaloMessageInputWidget())
        ],
      ),
    );
  }
}
