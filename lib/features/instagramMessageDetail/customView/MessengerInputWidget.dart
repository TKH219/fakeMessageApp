import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/ImageAssetsConstant.dart';
import 'package:fake_message_screen/utils/ImageUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessengerInputWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: gray50, width: 0.75))),
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
          top: 10,
          left: 14,
          right: 14),
      child: Row(children: <Widget>[
        Icon(
          Icons.add_circle_outlined,
          size: 28,
          color: primaryColor,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: ImageUtils.getImagesSvg(IC_CAMERA,
              color: primaryColor, height: 24, width: 24),
        ),
        Icon(
          Icons.image,
          size: 28,
          color: primaryColor,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Icon(
            Icons.mic,
            size: 28,
            color: primaryColor,
          ),
        ),
        Expanded(child: buildTextField()),
        SizedBox(width: 12),
        Icon(
          Icons.thumb_up_alt_rounded,
          size: 28,
          color: primaryColor,
        ),
      ]),
    );
  }

  Widget buildTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      decoration: BoxDecoration(
          color: gray0, borderRadius: BorderRadius.circular(22.0)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 12),
          Expanded(
              child: Text('Aa',
                  style: TextStyles.NORMAL_LABEL.getStyle.copyWith(
                      color: gray7,
                      fontSize: 18,
                      fontWeight: FontWeight.w400))),
          Icon(
            Icons.emoji_emotions_rounded,
            size: 28,
            color: primaryColor,
          ),
          SizedBox(width: 4),
        ],
      ),
    );
  }
}
