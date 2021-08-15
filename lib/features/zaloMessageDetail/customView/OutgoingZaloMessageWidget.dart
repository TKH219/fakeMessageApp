import 'package:fake_message_screen/model/MessageItemModel.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OutgoingZaloMessageWidget extends StatelessWidget {
  final MessageItemModel model;

  OutgoingZaloMessageWidget(this.model);

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
                  color: blue_primary_200,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  border: Border.all(color: gray2, width: 1)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    this.model.content,
                    style: TextStyles.BODY_2.getStyle.copyWith(fontSize: 14),
                    maxLines: 9,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  if (this.model.time.isNotEmpty)
                    Text(
                      this.model.time,
                      style: TextStyles.CAPTION.getStyle.copyWith(fontSize: 10),
                      textAlign: TextAlign.left,
                      maxLines: 1,
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
