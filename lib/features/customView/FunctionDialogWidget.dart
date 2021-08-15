import 'dart:io';

import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/handler/StorageManager.dart';
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

  bool isPremiumUser = false;

  @override
  void initState() {
    super.initState();
    Future.wait([StorageManager().getPremium()]).then((value) {
      setState(() {
        this.isPremiumUser = value[0];
      });
    });
  }

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
            addNewMessageWidget(),
            SaveScreenshotWidget(
              this.screenshotController,
              isPremiumUser: isPremiumUser,
              onBegin: () {},
              onEnd: () {
                Navigator.pop(context);
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

  Widget addNewMessageWidget() {
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
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return AddNewMessageWidget(
                  onDone: (messageModel) {
                      widget.model.contents.add(messageModel);
                      widget.onDone(widget.model);
                  },
                );
              });
        });
  }

  Widget changeReceiverAvatar() {
    return ChangeAvatarWidget((file) {
      if (this.isPremiumUser) {
        if (widget.onChangeAvatar != null) {
          widget.onChangeAvatar!(file);
        }
      } else {
        showToastMessage("You need to become a premium user first to use this function.");
      }
    });
  }
}