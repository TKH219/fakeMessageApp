import 'dart:io';
import 'dart:typed_data';
import 'package:fake_message_screen/PermissionService.dart';
import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/features/customView/AddNewMessageWidget.dart';
import 'package:fake_message_screen/features/customView/ConfirmButton.dart';
import 'package:fake_message_screen/features/customView/CustomTextField.dart';
import 'package:fake_message_screen/features/customView/FunctionButton.dart';
import 'package:fake_message_screen/features/zaloMessageDetail/model/MessageDetailModel.dart';
import 'package:fake_message_screen/features/zaloMessageDetail/model/MessageItemModel.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/Constants.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'CustomView/IncomingZaloMessageWidget.dart';
import 'CustomView/OutgoingZaloMessageWidget.dart';
import 'CustomView/ZaloMessageInputWidget.dart';

class ZaloMessagesDetailScreen extends CoreScreenWidget {

  @override
  CoreScreenState<ZaloMessagesDetailScreen> createState() => ZaloMessagesDetailState();
}

class ZaloMessagesDetailState extends CoreScreenState<ZaloMessagesDetailScreen> {

  MessageDetailModel model = MessageDetailModel();

  late Widget avatarWidget;

  @override
  bool get isSafeArea => false;

  @override
  PreferredSizeWidget createAppBarContent(BuildContext context) {
    return AppBar(
      backgroundColor: blue_primary_400,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
      centerTitle: false,
      leadingWidth: 12,
      titleSpacing: 40,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.receiverName,
            style:
                TextStyles.NORMAL_LABEL.getStyle.copyWith(color: Colors.white),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 4,
          ),
          Text(model.lastTimeOnline,
              style: TextStyles.CAPTION.getStyle.copyWith(color: Colors.white),
              textAlign: TextAlign.left),
        ],
      ),
      actions: [
        IconButton(
          color: Colors.white,
          icon: Icon(Icons.call_outlined),
          padding: EdgeInsets.only(left: 18),
          iconSize: 24,
          onPressed: () => Navigator.pop(context),
        ),
        IconButton(
          color: Colors.white,
          icon: Icon(Icons.video_camera_back_rounded),
          iconSize: 24,
          padding: EdgeInsets.only(left: 18),
          onPressed: () => Navigator.pop(context),
        ),
        IconButton(
          color: Colors.white,
          icon: Icon(Icons.storage),
          iconSize: 24,
          padding: EdgeInsets.only(left: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ],

      leading: IconButton(
        color: Colors.white,
        icon: Icon(Icons.arrow_back_ios),
        padding: EdgeInsets.only(left: 18),
        onPressed: () {
          print("pop");
          Navigator.pop(context);
        }
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    model = MessageDetailModel();
    avatarWidget = Image.network(
      "https://picsum.photos/250?image=9",
      height: 32,
      width: 32,
    );
  }

  @override
  Widget buildMobileLayout(BuildContext context) {
    return Container(
        color: backgroundColor,
        padding: EdgeInsets.only(top: 16),
        child: Stack(
          children: [
            ListView.builder(
                itemCount: model.contents.length,
                itemBuilder: (context, index) {
                  var messageModel = model.contents[index];

                  if (messageModel.messageType ==
                      MessageType.OUTGOING_MESSAGE) {
                    return OutgoingZaloMessageWidget(messageModel);
                  }

                  return IncomingZaloMessageWidget(messageModel, avatarWidget: avatarWidget);
                }),
            Positioned(bottom: 100, right: 16, child: functionButton()),
            Positioned(bottom: 0, left: 0, right: 0, child: ZaloMessageInputWidget()),
          ],
        ));
  }

  Widget functionButton() {
    return FunctionButton(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
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
                            model.receiverName = text;
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(width: 1, color: gray1),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            hintStyle: TextStyles.NORMAL_LABEL.getStyle.copyWith(color: gray5),
                            hintText: "Change Name"),
                        maxLines: 1,
                      ),

                      SizedBox(height: 12),
                      CustomTextField(
                        onChanged: (text) {
                          setState(() {
                            model.lastTimeOnline = text;
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(width: 1, color: gray1),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            hintStyle: TextStyles.NORMAL_LABEL.getStyle.copyWith(color: gray5),
                            hintText: "Change last time online"),
                        maxLines: 1,
                      ),
                      SizedBox(height: 12),
                      changeReceiverAvatar(),
                      saveScreenshot(),
                      addNewMessageWidget(),
                      SizedBox(height: 12),
                      ConfirmButton("done".toUpperCase(), onTapButton: () {
                        Navigator.pop(context);
                      },)
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  Widget changeReceiverAvatar() {
    return ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.add_a_photo_rounded, size: 24, color: gray9,),
          SizedBox(width: 8),
          Text('Change receiver avatar', style: TextStyles.NORMAL_LABEL.getStyle.copyWith(color: gray9),),
        ],
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 0),
      onTap: () async {
        var isGranted = await PermissionService.getPhotoPermission(context);
        if (isGranted) {
          try {
            final ImagePicker _picker = ImagePicker();
            final pickedFile = await _picker.getImage(source: ImageSource.gallery);
            setState(() {
              if (pickedFile != null) {
                avatarWidget = Image.file(
                  File(pickedFile.path),
                  height: 32,
                  width: 32,
                  fit: BoxFit.cover,
                );
              }
            });
          } catch (e) {
            print(e.toString());
          }
        }
      }
    );
  }

  Widget saveScreenshot() {
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
        double pixelRatio = MediaQuery.of(context).devicePixelRatio;
        screenshotController
            .capture(
            delay: Duration(milliseconds: 10),
            pixelRatio: pixelRatio)
            .then((image) async {
          if (image != null)  {
            await ImageGallerySaver.saveImage(
                image,
                quality: 60,
                name: "hello");
          }
        });
      },
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
                    setState(() {
                      this.model.contents.add(messageModel);
                    });
                  },
                );
              });
        });
  }
}
