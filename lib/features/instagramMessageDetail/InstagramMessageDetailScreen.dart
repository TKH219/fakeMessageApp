import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/features/InstagramMessageDetail/CustomView/IGMessageInputWidget.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/ImageAssetsConstant.dart';
import 'package:fake_message_screen/utils/ImageUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'CustomView/IncomingIGMessageWidget.dart';
import 'CustomView/OutgoingIGMessageWidget.dart';

class InstagramMessageDetailScreen extends CoreScreenWidget {

  @override
  InstagramMessageDetailState createState() => InstagramMessageDetailState();
}

class InstagramMessageDetailState extends CoreScreenState<InstagramMessageDetailScreen> {

  @override
  PreferredSizeWidget createAppBarContent(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
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
            TextStyles.NORMAL_LABEL.getStyle.copyWith(color: Colors.black),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 4,
          ),
          Text("Truy cap 20 phut truoc",
              style: TextStyles.CAPTION.getStyle.copyWith(color: gray_600),
              textAlign: TextAlign.left),
        ],
      ),
      actions: [
        IconButton(
          color: Colors.black,
          icon: Icon(Icons.video_camera_back_rounded),
          iconSize: 24,
          padding: EdgeInsets.only(left: 18),
          onPressed: () => Navigator.pop(context),
        ),
        IconButton(
          color: Colors.white,
          icon: ImageUtils.getImagesSvg(IC_IG_INFO,
              boxFit: BoxFit.fill,
              width: 24,
              height: 24,
              color: Colors.black),
          iconSize: 24,
          padding: EdgeInsets.only(left: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ],
      leading: IconButton(
        color: Colors.black,
        icon: Icon(Icons.arrow_back_ios),
        padding: EdgeInsets.only(left: 18),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  @override
  Widget buildMobileLayout(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          ListView.builder(
              itemCount: 9,
              itemBuilder: (context, index) {
                if (index % 3 == 0) {
                  return OutgoingIGMessageWidget(
                      index % 2 == 0
                          ? "testttt"
                          : "Đây là mã vạch khai báo y tế..các cô chú có thể khai ở nhà rồi mình ra xét nghiệm cho nhanh ậ. Xin cảm ơn");
                }

                return IncomingIGMessageWidget(
                    index % 2 == 0
                        ? "testttt"
                        : "Đây là mã vạch khai báo y tế..các cô chú có thể khai ở nhà rồi mình ra xét nghiệm cho nhanh ậ. Xin cảm ơn",);
              }),
          Positioned(
              bottom: MediaQuery.of(context).padding.bottom,
              left: 0,
              right: 0,
              child: IGMessageInputWidget())
        ],
      ),
    );
  }

}