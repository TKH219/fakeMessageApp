import 'package:fake_message_screen/utils/ColorUtils.dart';
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
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom,),
      child: Row(
        children: <Widget>[
          IconButton(
            color: gray5,
            icon: Icon(Icons.emoji_emotions_outlined),
            iconSize: 24,
            padding: EdgeInsets.only(left: 18),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(child: Text('Tin nhan', style: TextStyles.BODY_1.getStyle.copyWith(color: gray3, fontSize: 16),)),
          IconButton(
            color: gray5,
            icon: Icon(Icons.emoji_emotions_outlined),
            iconSize: 24,
            padding: EdgeInsets.only(left: 18),
            onPressed: () => Navigator.pop(context),
          ),
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
        ]

      ),
    );
  }

}