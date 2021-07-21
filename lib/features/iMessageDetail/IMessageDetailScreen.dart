import 'dart:io';

import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/customBubbleChat/BubbleType.dart';
import 'package:fake_message_screen/customBubbleChat/ChatBubble.dart';
import 'package:fake_message_screen/customBubbleChat/clippers/ChatBubbleClipper3.dart';
import 'package:fake_message_screen/features/customView/AddNewMessageWidget.dart';
import 'package:fake_message_screen/features/customView/ConfirmButton.dart';
import 'package:fake_message_screen/features/customView/CustomTextField.dart';
import 'package:fake_message_screen/features/customView/FunctionButton.dart';
import 'package:fake_message_screen/features/zaloMessageDetail/model/MessageDetailModel.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/Constants.dart';
import 'package:fake_message_screen/utils/ImageAssetsConstant.dart';
import 'package:fake_message_screen/utils/ImageUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

import '../../PermissionService.dart';
import 'customView/IMessageInputField.dart';

class IMessageDetailScreen extends CoreScreenWidget {
  @override
  IMessageDetailState createState() => IMessageDetailState();
}

class IMessageDetailState extends CoreScreenState<IMessageDetailScreen> {
  MessageDetailModel model = MessageDetailModel();

  late Widget avatarWidget;

  @override
  void initState() {
    super.initState();
    avatarWidget = ImageUtils.getOriginalImagesSvg(IC_AVATAR_DEFAULT,
        width: 56, height: 56);
  }

  @override
  bool get isSafeArea => false;

  @override
  PreferredSizeWidget createAppBarContent(BuildContext context) {
    return PreferredSize(
        // preferredSize: Size(double.infinity, kToolbarHeight),
        preferredSize:
            Size.fromHeight(100 + MediaQuery.of(context).padding.top),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  color: primaryColor,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 24,
                  ),
                  onPressed: () {
                    print("pop");
                    Navigator.pop(context);
                  }),
              numberNotification(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top),
                    avatarWidget,
                    Text(
                      "model.receiverName",
                      style: TextStyles.NORMAL_LABEL.getStyle
                          .copyWith(color: Colors.red),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  @override
  Widget buildMobileLayout(BuildContext context) {
    return Container(
        color: backgroundColor,
        child: Stack(
          children: [
            ListView.builder(
                itemCount: model.contents.length,
                itemBuilder: (context, index) {
                  var messageModel = model.contents[index];
                  if (messageModel.messageType ==
                      MessageType.OUTGOING_MESSAGE) {
                    return getSenderView(ChatBubbleClipper3(BubbleType.sendBubble), context);
                  }

                  return getReceiverView(ChatBubbleClipper3(BubbleType.receiverBubble), context);
                }),

            Positioned(bottom: 100, right: 16, child: functionButton()),
            Positioned(bottom: 0, left: 0, right: 0, child: IMessageInputField()),
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
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom +
                        MediaQuery.of(context).viewInsets.bottom,
                    left: 16,
                    right: 16),
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
                            hintText: "Change last time online"),
                        maxLines: 1,
                      ),
                      SizedBox(height: 12),
                      ListTile(
                        leading: new Icon(Icons.photo),
                        title: new Text('Add new message'),
                        onTap: () {
                          Navigator.pop(context);
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
                        onTap: () async {
                          var isGranted =
                              await PermissionService.getPhotoPermission(
                                  context);
                          if (isGranted) {
                            try {
                              final ImagePicker _picker = ImagePicker();
                              final pickedFile = await _picker.getImage(
                                  source: ImageSource.gallery);
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
                        },
                      ),
                      ListTile(
                        leading: new Icon(Icons.music_note),
                        title: new Text('Change receiver avatar'),
                        onTap: () async {
                          double pixelRatio =
                              MediaQuery.of(context).devicePixelRatio;
                          screenshotController
                              .capture(
                                  delay: Duration(milliseconds: 10),
                                  pixelRatio: pixelRatio)
                              .then((image) async {
                            if (image != null) {
                              await ImageGallerySaver.saveImage(image,
                                  quality: 60, name: "hello");
                            }
                          });
                        },
                      ),
                      SizedBox(height: 12),
                      ConfirmButton(
                        "done".toUpperCase(),
                        onTapButton: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  Widget addNewMessage() {
    return AddNewMessageWidget(
      onDone: (messageModel) {
        setState(() {
          this.model.contents.add(messageModel);
        });
      },
    );
  }

  Widget numberNotification() {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Text(
        "1",
        style: TextStyles.BUTTON.getStyle.copyWith(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }

  getSenderView(CustomClipper<Path> clipper, BuildContext context) =>
      ChatBubble(
        clipper,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 20),
        backGroundColor: Colors.blue,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  getReceiverView(CustomClipper<Path> clipper, BuildContext context) =>
      ChatBubble(
        clipper,
        backGroundColor: Color(0xffE7E7ED),
        margin: EdgeInsets.only(top: 20),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
            style: TextStyle(color: Colors.black),
          ),
        ),
      );
}
