import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/features/zaloMessageDetail/model/MessageItemModel.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ConfirmButton.dart';
import 'CustomTextField.dart';

class AddNewMessageWidget extends CoreScreenWidget {

  final Function(MessageItemModel)? onDone;

  @override
  AddNewMessageState createState() => AddNewMessageState();

  AddNewMessageWidget({this.onDone});
}

class AddNewMessageState extends CoreScreenState<AddNewMessageWidget> {

  bool _switchValue = true;
  MessageItemModel model = MessageItemModel();

  @override
  Widget buildMobileLayout(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 16, right: 16,
          bottom: MediaQuery.of(context).padding.bottom + MediaQuery.of(context).viewInsets.bottom
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 16,
            ),
            CustomTextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 1, color: gray1),
                  ),
                  hintText: "Contents..."),
              maxLines: 2,
              onChanged: (text) {
                setState(() {
                  model.content = text;
                });
              },
            ),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Nguoi gui"),
                CupertinoSwitch(
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            ConfirmButton("done".toUpperCase(), onTapButton: () {
              this.model.messageType = _switchValue
                  ? MessageType.OUTGOING_MESSAGE
                  : MessageType.INCOMING_MESSAGE;

              if (widget.onDone != null) {
                widget.onDone!(model);
              }

              Navigator.of(context).pop();
            })
          ],
        ),
      ),
    );
  }
}