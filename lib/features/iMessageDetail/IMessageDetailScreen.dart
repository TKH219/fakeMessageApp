import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/customBubbleChat/BubbleType.dart';
import 'package:fake_message_screen/customBubbleChat/ChatBubble.dart';
import 'package:fake_message_screen/customBubbleChat/clippers/ChatBubbleClipper3.dart';
import 'package:fake_message_screen/customBubbleChat/clippers/ChatBubbleClipper5.dart';
import 'package:fake_message_screen/features/customView/FunctionDialogWidget.dart';
import 'package:fake_message_screen/features/home/selectApp/SelectAppScreen.dart';
import 'package:fake_message_screen/model/MessageDetailModel.dart';
import 'package:fake_message_screen/model/MessageItemModel.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/Constants.dart';
import 'package:fake_message_screen/utils/ImageAssetsConstant.dart';
import 'package:fake_message_screen/utils/ImageUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:fake_message_screen/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                bottom: 0, left: 0, right: 0, child: InkWell(
                onTap: () {
                  Utils.showDialogForScaleHeight(context, FunctionDialogWidget(
                    model,
                    AppSupport.IMESS,
                    this.screenshotController,
                        (_model) {
                      setState(() {
                        unreadMessage = int.tryParse(model.lastTimeOnline) ?? 0;
                        model = _model;
                      });
                    },
                    onChangeAvatar: (file) {
                      setState(() {
                        avatarWidget = Image.file(file,
                            width: 56, height: 56, fit: BoxFit.cover);
                      });
                    },
                  ));
                },
                child: IMessageInputField())),
          ],
        ));
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
