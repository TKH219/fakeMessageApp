import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/features/InstagramMessageDetail/CustomView/IGMessageInputWidget.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
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
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black),
      centerTitle: false,
      leadingWidth: 12,
      titleSpacing: 40,
      title: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                "https://picsum.photos/250?image=9",
                height: 32,
                width: 32,
              ),
            ),
          ),
          Column(
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
                  return OutgoingIGMessageWidget(
                      index % 2 == 0
                          ? "testttt"
                          : "Đây là mã vạch khai báo y tế..các cô chú có thể khai ở nhà rồi mình ra xét nghiệm cho nhanh ậ. Xin cảm ơn",
                      "11:20");
                }

                return IncomingIGMessageWidget(
                    index % 2 == 0
                        ? "testttt"
                        : "Đây là mã vạch khai báo y tế..các cô chú có thể khai ở nhà rồi mình ra xét nghiệm cho nhanh ậ. Xin cảm ơn",
                    "11:20");
              }),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: IGMessageInputWidget())
        ],
      ),
    );
  }

}