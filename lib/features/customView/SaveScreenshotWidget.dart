import 'package:fake_message_screen/handler/StorageManager.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:fake_message_screen/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

class SaveScreenshotWidget extends StatelessWidget {
  final ScreenshotController screenshotController;
  final Function? onBegin;
  final Function? onEnd;
  final bool isPremiumUser;
  SaveScreenshotWidget(this.screenshotController, {required this.isPremiumUser, this.onBegin, this.onEnd});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.photo_camera_rounded, size: 24, color: gray9,),
          SizedBox(width: 8),
          Text('Save screenshot to photos', style: TextStyles.NORMAL_LABEL.getStyle.copyWith(color: gray9),),
        ],
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 0),
      onTap: () async {
        if (this.isPremiumUser) {
          if (this.onBegin != null) {
            this.onBegin!();
          }

          double pixelRatio = MediaQuery
              .of(context)
              .devicePixelRatio;
          screenshotController
              .capture(
              delay: Duration(milliseconds: 10),
              pixelRatio: pixelRatio)
              .then((image) async {
            if (image != null) {
              await ImageGallerySaver.saveImage(
                  image,
                  quality: 100,
                  name: "hello");

              if (this.onEnd != null) {
                this.onEnd!();
              }

              Utils.showToastMessage("Screenshot saved in your photos successfully.");
            }
          });
        } else {
          Utils.showToastMessage("You need to become a premium user first to use this function.");
        }
      }
    );
  }

}