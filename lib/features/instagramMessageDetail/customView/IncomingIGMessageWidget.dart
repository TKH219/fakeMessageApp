import 'package:fake_message_screen/features/home/selectApp/SelectAppScreen.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/ImageAssetsConstant.dart';
import 'package:fake_message_screen/utils/ImageUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncomingIGMessageWidget extends StatelessWidget {
  final String message;
  final Widget? avatar;
  final bool shouldBorderTopLeft;
  final bool shouldBorderBottomLeft;
  final AppSupport appSupport;

  IncomingIGMessageWidget(this.message, this.avatar,
      {this.shouldBorderBottomLeft = true, this.shouldBorderTopLeft = true, this.appSupport = AppSupport.INSTAGRAM});

  @override
  Widget build(BuildContext context) {
    bool isInstagram = this.appSupport == AppSupport.INSTAGRAM;

    return Container(
      margin: EdgeInsets.only(bottom: shouldBorderBottomLeft ? 6 : 0),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 28,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(left: 16, right: 12),
            child: shouldBorderBottomLeft ? ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: avatar
            ) : SizedBox.shrink(),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.only(left: 12, right: 12, bottom: 4, top: 8),
              margin: EdgeInsets.only(right: 54),
              decoration: BoxDecoration(
                  color: isInstagram ? gray_efef : gray_F1F1,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(shouldBorderTopLeft ? 25 : 6),
                      bottomLeft: Radius.circular(shouldBorderBottomLeft ? 25 : 6),
                      bottomRight: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Padding(
                padding: EdgeInsets.only(top: 2, bottom: 6),
                child: Text(
                  this.message,
                  style: TextStyles.BODY_2.getStyle
                      .copyWith(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
                  maxLines: 9,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
