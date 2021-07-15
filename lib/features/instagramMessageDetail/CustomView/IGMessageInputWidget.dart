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
          color: gray_8b8b, borderRadius: BorderRadius.circular(40)),
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Row(children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: blue_primary_500,
          ),
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: IconButton(
            color: Colors.white,
            padding: EdgeInsets.all(4),
            icon: Icon(Icons.photo_camera_rounded),
            iconSize: 24,
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Expanded(
            child: Text(
          'Message...',
          style:
              TextStyles.BODY_1.getStyle.copyWith(color: gray3, fontSize: 16),
        )),
        IconButton(
          color: gray5,
          icon: ImageUtils.getImagesSvg(IC_IG_MICRO,
              color: gray5, width: 25, height: 25),
          iconSize: 25,
          padding: EdgeInsets.only(left: 12),
          onPressed: () => Navigator.pop(context),
        ),
        IconButton(
          color: gray5,
          icon: ImageUtils.getImagesSvg(IC_IG_IMAGE,
              color: gray5, width: 25, height: 25),
          iconSize: 25,
          onPressed: () => Navigator.pop(context),
        ),
        IconButton(
          color: gray5,
          icon: Icon(Icons.add_circle, color: Colors.black,),
          iconSize: 32,
          padding: EdgeInsets.only(right: 12),
          onPressed: () => Navigator.pop(context),
        ),
      ]),
    );
  }
}
