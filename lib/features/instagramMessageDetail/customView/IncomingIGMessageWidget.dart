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

  IncomingIGMessageWidget(this.message, this.avatar,
      {this.shouldBorderBottomLeft = true, this.shouldBorderTopLeft = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            width: 60,
            height: 32,
            padding: EdgeInsets.only(left: 16, right: 12),
            child: shouldBorderBottomLeft ? ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: avatar
            ) : SizedBox.shrink(),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.only(left: 12, right: 12, bottom: 4, top: 8),
              margin: EdgeInsets.only(right: 60),
              decoration: BoxDecoration(
                  color: gray_efef,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(shouldBorderTopLeft ? 25 : 6),
                      bottomLeft:
                          Radius.circular(shouldBorderBottomLeft ? 25 : 6),
                      bottomRight: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Padding(
                padding: EdgeInsets.only(top: 2, bottom: 6),
                child: Text(
                  this.message,
                  style: TextStyles.BODY_2.getStyle
                      .copyWith(fontSize: 14, color: Colors.black),
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
