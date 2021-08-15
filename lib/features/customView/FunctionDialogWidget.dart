import 'dart:io';

import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/model/MessageDetailModel.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'AddNewMessageWidget.dart';
import 'ChangeAvatarWidget.dart';
import 'ConfirmButton.dart';
import 'CustomTextField.dart';
import 'SaveScreenshotWidget.dart';

class FunctionDialogWidget extends CoreScreenWidget{

  MessageDetailModel model;
  Function(MessageDetailModel) onDone;
  Function(File)? onChangeAvatar;
  FunctionDialogWidget(this.model, this.onDone, {this.onChangeAvatar});

  @override
  FunctionDialogState createState() => FunctionDialogState();
}

class FunctionDialogState extends CoreScreenState<FunctionDialogWidget> {

  @override
  Widget buildMobileLayout(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 12),
            CustomTextField(
              onChanged: (text) {
                setState(() {
                  widget.model.receiverName = text;
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 1, color: gray1),
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 12),
                  hintStyle: TextStyles.NORMAL_LABEL.getStyle
                      .copyWith(color: gray5),
                  hintText: "Change phone number"),
              maxLines: 1,
            ),

            SizedBox(height: 12),
            CustomTextField(
              onChanged: (text) {
                setState(() {
                  widget.model.lastTimeOnline = text;
                });
              },

              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 1, color: gray1),
                  ),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 12),
                  hintStyle: TextStyles.NORMAL_LABEL.getStyle.copyWith(color: gray5),
                  hintText: "Change last time online"),
              maxLines: 1,
            ),
            SizedBox(height: 12),
            changeReceiverAvatar(),
            SaveScreenshotWidget(
              this.screenshotController,
              onBegin: () {
                setState(() {
                  showFunctionButton = false;
                });
              },
              onEnd: () {
                setState(() {
                  showFunctionButton = true;
                });
              },
            ),
            SizedBox(height: 12),
            ConfirmButton("done".toUpperCase(), onTapButton: () {
              widget.onDone(widget.model);
              Navigator.pop(context);
            },)
          ],
        ),
      ),
    );
  }

  Widget addNewMessage() {
    return AddNewMessageWidget(onDone: (messageModel) {
      setState(() {
        Navigator.pop(context);
        widget.model.contents.add(messageModel);
        widget.onDone(widget.model);
      });
    });
  }

  Widget changeReceiverAvatar() {
    return ChangeAvatarWidget((file) {
      if (widget.onChangeAvatar != null) {
        widget.onChangeAvatar!(file);
      }
    });
  }
}