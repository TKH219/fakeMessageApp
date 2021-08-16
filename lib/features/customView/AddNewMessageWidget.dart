import 'dart:io';

import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/model/ItemKey.dart';
import 'package:fake_message_screen/model/MessageItemModel.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/Constants.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../PermissionService.dart';
import 'ConfirmButton.dart';
import 'CustomTextField.dart';
import 'SelectMessageTypeWidget.dart';

class AddNewMessageWidget extends StatelessWidget {
  final Function(MessageItemModel)? onDone;
  final bool haveAttachImageOption;

  AddNewMessageWidget({this.onDone, this.haveAttachImageOption = false});

  MessageItemModel model = MessageItemModel();

  late List<ItemKey> listMessageType = [];

  @override
  Widget build(BuildContext context) {
    MessageType.values.forEach((item) {
      listMessageType.add(ItemKey(item, item.getTitleDisplay()));
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomTextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(width: 1, color: gray1),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              hintStyle:
              TextStyles.NORMAL_LABEL.getStyle.copyWith(color: gray5),
              hintText: "Contents..."),
          maxLines: 1,
          onChanged: (text) {
              model.content = text;
          },
        ),
        SizedBox(height: 16),
        SelectMessageTypeWidget(listMessageType),
        attachImage(context),
        SizedBox(height: 16),
        ConfirmButton("done".toUpperCase(), onTapButton: () => onTapDone(context))
      ],
    );
  }

  Widget attachImage(BuildContext context) {
    return SizedBox.shrink();
    if (!this.haveAttachImageOption) return SizedBox.shrink();

    return ListTile(
        title: Text(
          'Attach image file',
          style: TextStyles.NORMAL_LABEL.getStyle.copyWith(color: gray9),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 0),
        onTap: () async {
          var isGranted = await PermissionService.getPhotoPermission(context);
          if (isGranted) {
            try {
              final ImagePicker _picker = ImagePicker();
              final pickedFile =
                  await _picker.getImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  model.imageFile = File(pickedFile.path);
                }

                onTapDone(context);
            } catch (e) {
              print(e.toString());
            }
          }
        });
  }

  void onTapDone(BuildContext context) {
    ItemKey? selectedItemKey =
        listMessageType.firstWhere((item) => item.isSelected == true);
    if (selectedItemKey != null) {
      this.model.messageType = selectedItemKey.key as MessageType;
      if (this.onDone != null) {
        this.onDone!(model);
      }
    }

    Navigator.of(context).pop();
  }
}
