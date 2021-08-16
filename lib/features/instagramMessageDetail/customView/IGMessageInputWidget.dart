import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/ImageAssetsConstant.dart';
import 'package:fake_message_screen/utils/ImageUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IGMessageInputWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: gray_F1F1, borderRadius: BorderRadius.circular(26)),
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(children: <Widget>[
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21),
            color: blue_primary_500,
          ),
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: IconButton(
            color: Colors.white,
            padding: EdgeInsets.all(4),
            icon: Icon(Icons.photo_camera_rounded),
            iconSize: 24,
            onPressed: null,
          ),
        ),
        Expanded(
            child: Text(
          'Message...',
          style:
              TextStyles.BODY_1.getStyle.copyWith(color: gray5, fontSize: 18),
        )),
        IconButton(
          color: gray5,
          icon: ImageUtils.getImagesSvg(IC_IG_MICRO, color: Colors.black.withOpacity(0.8), width: 25, height: 25),
          iconSize: 25,
          padding: EdgeInsets.only(left: 12),
          onPressed: null,
        ),
        SizedBox(width: 12),
        ImageUtils.getImagesSvg(IC_IG_IMAGE, color: Colors.black.withOpacity(0.8), width: 25, height: 25),
        SizedBox(width: 18),
        ImageUtils.getImagesSvg(IC_IG_EMOJI, color: Colors.black.withOpacity(0.8), width: 25, height: 25),
        SizedBox(width: 12),
      ]),
    );
  }
}
