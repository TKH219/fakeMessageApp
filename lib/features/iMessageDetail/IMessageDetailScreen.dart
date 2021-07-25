import 'dart:io';

import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/customBubbleChat/BubbleType.dart';
import 'package:fake_message_screen/customBubbleChat/ChatBubble.dart';
import 'package:fake_message_screen/customBubbleChat/clippers/ChatBubbleClipper3.dart';
import 'package:fake_message_screen/customBubbleChat/clippers/ChatBubbleClipper5.dart';
import 'package:fake_message_screen/features/customView/AddNewMessageWidget.dart';
import 'package:fake_message_screen/features/customView/ConfirmButton.dart';
import 'package:fake_message_screen/features/customView/CustomTextField.dart';
import 'package:fake_message_screen/features/customView/FunctionButton.dart';
import 'package:fake_message_screen/features/zaloMessageDetail/model/MessageDetailModel.dart';
import 'package:fake_message_screen/features/zaloMessageDetail/model/MessageItemModel.dart';
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
    avatarWidget = ImageUtils.getImagesSvg(IC_AVATAR_DEFAULT_IMESS,
        width: 56, height: 56, color: gray5);
  }

  @override
  bool get isSafeArea => false;

  @override
  PreferredSizeWidget? createAppBarContent(BuildContext context) {
    return null;
  }

  @override
  Widget buildMobileLayout(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Stack(
          children: [
            ListView.builder(
                itemCount: model.contents.length,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) {
                  var messageModel = model.contents[index];
                  int nextIndex = index + 1;
                  bool shouldBorderCorner =
                      (index != model.contents.length - 1 ||
                          (nextIndex < model.contents.length &&
                              model.contents[nextIndex].messageType ==
                                  model.contents[index].messageType));
                  if (messageModel.messageType ==
                      MessageType.OUTGOING_MESSAGE) {
                    return getSenderView(
                        shouldBorderCorner
                            ? ChatBubbleClipper5(BubbleType.sendBubble)
                            : ChatBubbleClipper3(BubbleType.sendBubble),
                        context,
                        messageModel);
                  }

                  return getReceiverView(
                      shouldBorderCorner
                          ? ChatBubbleClipper5(BubbleType.receiverBubble)
                          : ChatBubbleClipper3(BubbleType.receiverBubble),
                      context,
                      messageModel);
                }),
            Positioned(top: 0, left: 0, right: 0, child: appBarContent()),
            Positioned(bottom: 100, right: 16, child: functionButton()),
            Positioned(
                bottom: 0, left: 0, right: 0, child: IMessageInputField()),
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

  Widget appBarContent() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 4,
              offset: Offset(0.0, -2))
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              color: primaryColor,
              padding: EdgeInsets.only(top: 26),
              alignment: Alignment.center,
              icon: Icon(
                Icons.arrow_back_ios,
                size: 24,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          // numberNotification(),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 48),
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  avatarWidget,
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${model.receiverName}",
                        style: TextStyles.NORMAL_LABEL.getStyle
                            .copyWith(color: black_0103),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(width: 4),
                      Text(
                        ">",
                        style: TextStyles.NORMAL_LABEL.getStyle
                            .copyWith(color: gray7),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
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

  getSenderView(CustomClipper<Path> clipper, BuildContext context,
          MessageItemModel model) =>
      ChatBubble(
        clipper,
        alignment: Alignment.topRight,
        elevation: 0,
        margin: EdgeInsets.only(top: 4),
        backGroundColor: blue_7cf5,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            model.content,
            style: TextStyle(color: white_FDFF),
          ),
        ),
      );

  getReceiverView(CustomClipper<Path> clipper, BuildContext context,
          MessageItemModel model) =>
      ChatBubble(
        clipper,
        backGroundColor: gray_e9eb,
        elevation: 0,
        margin: EdgeInsets.only(top: 4),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            model.content,
            style: TextStyle(color: black_0103),
          ),
        ),
      );
}
