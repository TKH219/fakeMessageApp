import 'package:fake_message_screen/model/MessageItemModel.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IncomingZaloMessageWidget extends StatelessWidget {
  final MessageItemModel model;
  final Widget avatarWidget;
  final bool shouldShowAvatar;

  IncomingZaloMessageWidget(this.model, {required this.avatarWidget, required this.shouldShowAvatar});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: (this.model.imageFile == null) ? EdgeInsets.symmetric(vertical: 2) : EdgeInsets.only(bottom: 12, top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16, right: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: this.shouldShowAvatar ? this.avatarWidget : Container(height: 24, width: 24),
            ),
          ),
          Flexible(
              child: (this.model.imageFile == null)
                  ? Container(
                      padding: EdgeInsets.only(left: 12, right: 12, bottom: 4, top: 8),
                      margin: EdgeInsets.only(right: 60),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          border: Border.all(color: gray2, width: 1)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            this.model.content,
                            style: TextStyles.BODY_2.getStyle
                                .copyWith(fontSize: 14),
                            maxLines: 9,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          if (this.model.time.isNotEmpty)
                            Text(
                              this.model.time,
                              style: TextStyles.CAPTION.getStyle
                                  .copyWith(fontSize: 10),
                              maxLines: 1,
                            ),
                        ],
                      ),
                    )
                  : Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          this.model.imageFile!,
                          height: (MediaQuery.of(context).size.width * 3 / 5) /
                              3 *
                              4,
                          width: MediaQuery.of(context).size.width * 3 / 5,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
        ],
      ),
    );
  }
}
