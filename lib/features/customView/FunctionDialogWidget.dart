import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/features/zaloMessageDetail/model/MessageDetailModel.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'AddNewMessageWidget.dart';
import 'ConfirmButton.dart';
import 'CustomTextField.dart';

class FunctionDialogWidget extends CoreScreenWidget{

  MessageDetailModel model;
  Function(MessageDetailModel) onDone;

  FunctionDialogWidget(this.model, this.onDone);

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
                  hintText: "Change Name"),
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
                  hintText: "Change last time online"),
              maxLines: 1,
            ),

            SizedBox(height: 12),
            ListTile(
              leading: new Icon(Icons.photo),
              title: new Text('Add new message'),
              onTap: () {
                // Navigator.pop(context);
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return addNewMessage();
                    });
              },
            ),
            SizedBox(height: 12),
            ListTile(
              leading: new Icon(Icons.music_note),
              title: new Text('Change receiver avatar'),
              onTap: () {
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

  Widget addNewMessage() {
    return AddNewMessageWidget(onDone: (messageModel) {
      setState(() {
        widget.model.contents.add(messageModel);
      });
    },);
  }
}