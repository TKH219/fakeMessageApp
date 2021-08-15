import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/ImageAssetsConstant.dart';
import 'package:fake_message_screen/utils/ImageUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ZaloMessageInputWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: gray50, width: 0.75))
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 12, top: 16),
      child: Row(children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 12, right: 10),
            child: ImageUtils.getImagesSvg(IC_IG_EMOJI, color: gray8, width: 25, height: 25),
        ),
        Expanded(
            child: Text(
          'Messages',
          style:
              TextStyles.BODY_1.getStyle.copyWith(color: gray5, fontSize: 18),
        )),
        Padding(
          padding: EdgeInsets.only(left: 10, right: 24),
          child: ImageUtils.getImagesSvg(IC_ZALO_MORE, color: gray7, width: 25, height: 25),
        ),
        ImageUtils.getImagesSvg(IC_ZALO_MICRO, color: Colors.black, width: 25, height: 25),
        Padding(
          padding: EdgeInsets.only(left: 24, right: 12),
          child: ImageUtils.getImagesSvg(IC_IG_IMAGE, color: gray8, width: 25, height: 25),
        ),
      ]),
    );
  }

}