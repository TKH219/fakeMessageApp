import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IGMessageInputWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: gray_8b8b,
        borderRadius: BorderRadius.circular(40)
      ),

      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
          children: <Widget>[
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
            Expanded(child: Text('Message...', style: TextStyles.BODY_1.getStyle.copyWith(color: gray3, fontSize: 16),)),
            IconButton(
              color: gray5,
              icon: Icon(Icons.mic_none_rounded),
              iconSize: 30,
              padding: EdgeInsets.only(left: 18),
              onPressed: () => Navigator.pop(context),
            ),
            IconButton(
              color: gray5,
              icon: Icon(Icons.image),
              iconSize: 24,
              padding: EdgeInsets.only(left: 18),
              onPressed: () => Navigator.pop(context),
            ),
            IconButton(
              color: gray5,
              icon: Icon(Icons.emoji_emotions_outlined),
              iconSize: 24,
              padding: EdgeInsets.only(left: 18),
              onPressed: () => Navigator.pop(context),
            ),
          ]

      ),
    );
  }
}