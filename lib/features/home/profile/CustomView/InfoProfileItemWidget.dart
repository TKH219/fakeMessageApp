
import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/ImageUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoProfileItemWidget extends StatelessWidget {

  final String imagePath;
  final String title;
  final Function()? onTapItem;
  final bool hasPadding;

  InfoProfileItemWidget(
      {this.onTapItem, this.imagePath = "", this.title = "", this.hasPadding = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: this.hasPadding? 20: 0),
      child: InkWell(
        onTap: this.onTapItem,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            this.imagePath == ""
                ? SizedBox.shrink()
                : Container(
              color: Colors.white,
              padding:
              EdgeInsets.symmetric(horizontal: 28),
              child: ImageUtils.getOriginalImagesSvg(this.imagePath, height: 24, width: 24),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: 18,
                        bottom: 18,
                        left: (this.imagePath == "") ? 16 : 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                            child: _text()
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: gray9,
                            size: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                  this.hasPadding?SizedBox():Container(width: double.infinity,
                    color: gray1,
                    height: 1.0,)
                ],
              ),
            ),
          ],

        ),
      ),
    );
  }

  Widget _text(){
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(this.title, style: TextStyles.BODY_2.getStyle.copyWith(color: gray9),
              maxLines: 1,
              overflow: TextOverflow.ellipsis, textAlign: TextAlign.left,),
          ),
        ),
      ],
    );
  }
}