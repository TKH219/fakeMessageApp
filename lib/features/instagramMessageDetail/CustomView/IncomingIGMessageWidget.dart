import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncomingIGMessageWidget extends StatelessWidget {
  final String message;

  IncomingIGMessageWidget(this.message);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                "https://picsum.photos/250?image=9",
                height: 32,
                width: 32,
              ),
            ),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.only(left: 12, right: 12, bottom: 4, top: 8),
              margin: EdgeInsets.only(right: 60),
              decoration: BoxDecoration(
                  color: gray_efef,
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    this.message,
                    style: TextStyles.BODY_2.getStyle.copyWith(fontSize: 14, color: Colors.black),
                    maxLines: 9,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}