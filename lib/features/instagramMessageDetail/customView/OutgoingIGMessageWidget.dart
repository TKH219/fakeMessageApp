import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/Constants.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OutgoingIGMessageWidget extends StatelessWidget {

  final String message;
  final bool shouldBorderTopRight;
  final bool shouldBorderBottomRight;
  OutgoingIGMessageWidget(this.message, {this.shouldBorderTopRight = true, this.shouldBorderBottomRight = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.only(left: 12, right: 12, bottom: 4, top: 8),
              margin: EdgeInsets.only(left: 60),
              decoration: BoxDecoration(
                  color: purple_400,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(shouldBorderTopRight ? 25 : 6),
                      bottomRight: Radius.circular(shouldBorderBottomRight ? 25 : 6),
                      bottomLeft: Radius.circular(25),
                      topLeft: Radius.circular(25))),
              child: Padding(
                padding: EdgeInsets.only(top: 2, bottom: 6),
                child: Text(
                  this.message,
                  style: TextStyles.BODY_2.getStyle.copyWith(fontSize: 14, color: Colors.white),
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