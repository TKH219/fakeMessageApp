import 'dart:io';

import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/customBubbleChat/BubbleType.dart';
import 'package:fake_message_screen/customBubbleChat/ChatBubble.dart';
import 'package:fake_message_screen/customBubbleChat/clippers/ChatBubbleClipper3.dart';
import 'package:fake_message_screen/customBubbleChat/clippers/ChatBubbleClipper5.dart';
import 'package:fake_message_screen/features/customView/AddNewMessageButton.dart';
import 'package:fake_message_screen/features/customView/AddNewMessageWidget.dart';
import 'package:fake_message_screen/features/customView/ChangeAvatarWidget.dart';
import 'package:fake_message_screen/features/customView/ConfirmButton.dart';
import 'package:fake_message_screen/features/customView/CustomTextField.dart';
import 'package:fake_message_screen/features/customView/FunctionButton.dart';
import 'package:fake_message_screen/features/customView/SaveScreenshotWidget.dart';
import 'package:fake_message_screen/model/MessageDetailModel.dart';
import 'package:fake_message_screen/model/MessageItemModel.dart';
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
  int unreadMessage = 1;

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
                itemCount: model.contents.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) return SizedBox(height: MediaQuery.of(context).padding.top + 96);
                  var originalIndex = index - 1;
                  var messageModel = model.contents[originalIndex];
                  int nextIndex = originalIndex + 1;
                  bool showImageBubble = (nextIndex == model.contents.length ||
                      (nextIndex < model.contents.length &&
                          model.contents[nextIndex].messageType !=
                              model.contents[originalIndex].messageType));
                  if (messageModel.messageType ==
                      MessageType.OUTGOING_MESSAGE) {
                    return Padding(
                      padding: EdgeInsets.only(
                          right: showImageBubble ? 6 : 16, top: 2),
                      child: getSenderView(
                          showImageBubble
                              ? ChatBubbleClipper3(BubbleType.sendBubble)
                              : ChatBubbleClipper5(BubbleType.sendBubble),
                          context,
                          messageModel),
                    );
                  }

                  return Padding(
                    padding:
                        EdgeInsets.only(left: showImageBubble ? 6 : 16, top: 2),
                    child: getReceiverView(
                        showImageBubble
                            ? ChatBubbleClipper3(BubbleType.receiverBubble)
                            : ChatBubbleClipper5(BubbleType.receiverBubble),
                        context,
                        messageModel),
                  );
                }),
            Positioned(top: 0, left: 0, right: 0, child: appBarContent()),
            Positioned(
                bottom: 120,
                right: 16,
                child: Visibility(
                  visible: showFunctionButton,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AddNewMessageButton((model) {
                        setState(() {
                          this.model.contents.add(model);
                        });
                      }, haveAttachImageOption: false),
                      SizedBox(width: 16),
                      functionButtonWidget(),
                    ],
                  ),
                )),
            Positioned(
                bottom: 0, left: 0, right: 0, child: IMessageInputField()),
          ],
        ));
  }

  Widget functionButtonWidget() {
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
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12),
                            hintStyle: TextStyles.NORMAL_LABEL.getStyle
                                .copyWith(color: gray5),
                            hintText: "Change phone number"),
                        maxLines: 1,
                      ),
                      SizedBox(height: 12),
                      CustomTextField(
                        onChanged: (text) {
                          setState(() {
                            unreadMessage = int.parse(text);
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(width: 1, color: gray1),
                            ),
                            contentPadding:
                            EdgeInsets.symmetric(horizontal: 12),
                            hintStyle: TextStyles.NORMAL_LABEL.getStyle.copyWith(color: gray5),
                            hintText: "Change number of unread messages"),
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 12),
                      changeReceiverAvatar(),
                      SaveScreenshotWidget(
                        this.screenshotController,
                        onBegin: () {
                          setState(() {
                            showFunctionButton = false;
                          });
                        },
                        onEnd: () {
                          setState(() {
                            showFunctionButton = true;
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

  Widget appBarContent() {
    return Container(
      decoration: BoxDecoration(
        color: white_600.withOpacity(0.95),
        border: Border(bottom: BorderSide(
          color: gray6,
          width: 0.5
        )),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.only(left: 16, top: 12),
              child: Row(
                children: [
                  ImageUtils.getImagesSvg(IC_BACK_ARROW, width: 20, height: 20, color: primaryColor),
                  numberNotification(),
                ],
              ),
            ),
          ),

          Expanded(
            child: Container(
              // color: Colors.red,
              margin: EdgeInsets.only(right: 48),
              padding: EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: MediaQuery.of(context).padding.top),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: avatarWidget),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${model.receiverName}",
                        style: TextStyles.BODY_2.getStyle
                            .copyWith(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(width: 4),
                      ImageUtils.getImagesSvg(IC_FORWARD_ARROW, width: 8, height: 8, color: gray7),
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
    if (unreadMessage == 0) return SizedBox(width: 24);
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Padding(
        padding: EdgeInsets.only(bottom: 2),
        child: Text(
          unreadMessage.toString(),
          style: TextStyles.CAPTION.getStyle
              .copyWith(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget changeReceiverAvatar() {
    return ChangeAvatarWidget((file) {
      setState(() {
        avatarWidget = Image.file(
          file,
          height: 56,
          width: 56,
          fit: BoxFit.cover,
        );
      });
    });
  }

  Widget getSenderView(CustomClipper<Path> clipper, BuildContext context,
          MessageItemModel model) =>
      ChatBubble(
        clipper,
        alignment: Alignment.topRight,
        elevation: 0,
        backGroundColor: blue_7cf5,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            model.content,
            style: TextStyles.BODY_1.getStyle.copyWith(color: white_FDFF),
          ),
        ),
      );

  Widget getReceiverView(CustomClipper<Path> clipper, BuildContext context,
          MessageItemModel model) =>
      ChatBubble(
        clipper,
        backGroundColor: gray_e9eb,
        elevation: 0,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            model.content,
            style: TextStyles.BODY_1.getStyle.copyWith(color: black_0103, fontSize: 16),
          ),
        ),
      );
}
