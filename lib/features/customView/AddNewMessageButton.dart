import 'package:fake_message_screen/features/zaloMessageDetail/model/MessageItemModel.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AddNewMessageWidget.dart';

class AddNewMessageButton extends StatelessWidget {

  final Function(MessageItemModel) onAddNewMessage;

  AddNewMessageButton(this.onAddNewMessage);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(28),
      color: blue_primary_600,
      child: InkWell(
        onTap: () => onTap(context),
        child: Container(
          alignment: Alignment.center,
          width: 56,
          height: 56,
          child: Icon(Icons.message_outlined, color: Colors.white, size: 24),
        ),
      ),
    );
  }

  void onTap(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return AddNewMessageWidget(onDone: this.onAddNewMessage,);
        });
  }
}