import 'dart:io';

import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/features/zaloMessageDetail/model/ItemKey.dart';
import 'package:fake_message_screen/features/zaloMessageDetail/model/MessageItemModel.dart';
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

class AddNewMessageWidget extends CoreScreenWidget {
  final Function(MessageItemModel)? onDone;
  final bool haveAttachImageOption = false;

  AddNewMessageWidget({this.onDone, haveAttachImageOption = false});

  @override
  AddNewMessageState createState() => AddNewMessageState();
}

class AddNewMessageState extends CoreScreenState<AddNewMessageWidget> {
  MessageItemModel model = MessageItemModel();

  late List<ItemKey> listMessageType = [];

  @override
  void initState() {
    MessageType.values.forEach((item) {
      listMessageType.add(ItemKey(item, item.getTitleDisplay()));
    });

    super.initState();
  }

  @override
  Widget buildMobileLayout(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).padding.bottom +
              MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Column(
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
                setState(() {
                  model.content = text;
                });
              },
            ),
            SizedBox(height: 16),
            SelectMessageTypeWidget(listMessageType),
            attachImage(),
            SizedBox(height: 16),
            ConfirmButton("done".toUpperCase(), onTapButton: onTapDone)
          ],
        ),
      ),
    );
  }

  Widget attachImage() {
    if (!widget.haveAttachImageOption) return SizedBox.shrink();

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
              setState(() {
                if (pickedFile != null) {
                  model.imageFile = File(pickedFile.path);
                }

                onTapDone();
              });
            } catch (e) {
              print(e.toString());
            }
          }
        });
  }

  void onTapDone() {
    ItemKey? selectedItemKey =
        listMessageType.firstWhere((item) => item.isSelected == true);
    if (selectedItemKey != null) {
      this.model.messageType = selectedItemKey.key as MessageType;
      if (widget.onDone != null) {
        widget.onDone!(model);
      }
    }

    Navigator.of(context).pop();
  }
}
