import 'dart:io';

import 'package:fake_message_screen/PermissionService.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChangeAvatarWidget extends StatelessWidget {

  final Function(File) getImageCallBack;

  ChangeAvatarWidget(this.getImageCallBack);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.add_a_photo_rounded,
              size: 24,
              color: gray9,
            ),
            SizedBox(width: 8),
            Text(
              'Change receiver avatar',
              style: TextStyles.NORMAL_LABEL.getStyle.copyWith(color: gray9),
            ),
          ],
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
                this.getImageCallBack(File(pickedFile.path));
              }
            } catch (e) {
              print(e.toString());
            }
          }
        });
  }
}
