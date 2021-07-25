import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/ImageAssetsConstant.dart';
import 'package:fake_message_screen/utils/ImageUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IMessageInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          border: Border(top: BorderSide(color: gray50, width: 0.75))),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom,
        top: 6
      ),
      child: Row(children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ImageUtils.getImagesSvg(IC_CAMERA, color: gray_9999, height: 24, width: 24),
        ),
        ImageUtils.getPngImage(IC_APP_STORE_PNG, height: 24, width: 32),
        SizedBox(width: 16),
        Expanded(child: iMessageInput()),
        SizedBox(width: 16),
      ]),
    );
  }

  Widget iMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: gray2),
          borderRadius: BorderRadius.circular(18.0)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 4),
          Expanded(
              child: Text('iMessage',
                  style: TextStyles.BODY_2.getStyle
                      .copyWith(color: gray_b3c8, fontSize: 18))),
          ImageUtils.getImagesSvg(IC_CAMERA,
              color: gray5, height: 24, width: 24),
          SizedBox(width: 4),
        ],
      ),
    );
  }
}
