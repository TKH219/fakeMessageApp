import 'dart:io';
import 'package:fake_message_screen/features/home/selectApp/SelectAppScreen.dart';
import 'package:fake_message_screen/handler/StorageManager.dart';
import 'package:fake_message_screen/model/MessageDetailModel.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:fake_message_screen/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import 'AddNewMessageWidget.dart';
import 'ChangeAvatarWidget.dart';
import 'ConfirmButton.dart';
import 'CustomTextField.dart';
import 'SaveScreenshotWidget.dart';

class FunctionDialogWidget extends StatelessWidget {
  MessageDetailModel model;
  Function(MessageDetailModel) onDone;
  Function(File)? onChangeAvatar;
  ScreenshotController screenshotController;
  AppSupport appSupport;

  FunctionDialogWidget(
      this.model, this.appSupport, this.screenshotController, this.onDone,
      {this.onChangeAvatar});

  bool isPremiumUser = false;

  @override
  Widget build(BuildContext context) {
    Future.wait([StorageManager().getPremium()]).then((value) {
      this.isPremiumUser = value[0];
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(height: 12),
        CustomTextField(
          onChanged: (text) {
            this.model.receiverName = text;
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(width: 1, color: gray1),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              hintStyle:
                  TextStyles.NORMAL_LABEL.getStyle.copyWith(color: gray5),
              hintText: this.appSupport == AppSupport.IMESS
                  ? "Change phone number"
                  : "Change username"),
          maxLines: 1,
        ),
        SizedBox(height: 12),
        CustomTextField(
            onChanged: (text) {
              this.model.lastTimeOnline = text;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 1, color: gray1)),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                hintStyle:
                    TextStyles.NORMAL_LABEL.getStyle.copyWith(color: gray5),
                hintText: this.appSupport == AppSupport.IMESS
                    ? "Change number of unread messages"
                    : "Change last time online"),
            maxLines: 1,
            keyboardType: this.appSupport == AppSupport.IMESS
                ? TextInputType.number
                : TextInputType.text),
        SizedBox(height: 12),
        changeReceiverAvatar(),
        addNewMessageWidget(context),
        SaveScreenshotWidget(this.screenshotController,
            isPremiumUser: isPremiumUser, onBegin: () {}, onEnd: () {
          Navigator.pop(context);
        }),
        SizedBox(height: 12),
        ConfirmButton("done".toUpperCase(), onTapButton: () {
          this.onDone(this.model);
          Navigator.pop(context);
        })
      ],
    );
  }

  Widget addNewMessageWidget(BuildContext context) {
    return ListTile(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.add_circle_rounded,
              size: 24,
              color: gray9,
            ),
            SizedBox(width: 8),
            Text(
              'Add new message',
              style: TextStyles.NORMAL_LABEL.getStyle.copyWith(color: gray9),
            ),
          ],
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        onTap: () {
          Navigator.pop(context);
          Utils.showDialogForScaleHeight(context, AddNewMessageWidget(
            haveAttachImageOption: this.appSupport == AppSupport.ZALO,
            onDone: (messageModel) {
              this.model.contents.add(messageModel);
              this.onDone(this.model);
            },
          ));
        });
  }

  Widget changeReceiverAvatar() {
    return ChangeAvatarWidget((file) {
      if (this.isPremiumUser) {
        if (this.onChangeAvatar != null) {
          this.onChangeAvatar!(file);
        }
      } else {
        Utils.showToastMessage(
            "You need to become a premium user first to use this function.");
      }
    });
  }
}
