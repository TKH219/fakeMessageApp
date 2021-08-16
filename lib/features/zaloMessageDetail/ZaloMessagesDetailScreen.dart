import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/features/customView/FunctionDialogWidget.dart';
import 'package:fake_message_screen/features/home/selectApp/SelectAppScreen.dart';
import 'package:fake_message_screen/model/MessageDetailModel.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/Constants.dart';
import 'package:fake_message_screen/utils/ImageAssetsConstant.dart';
import 'package:fake_message_screen/utils/ImageUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:fake_message_screen/utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'CustomView/IncomingZaloMessageWidget.dart';
import 'CustomView/OutgoingZaloMessageWidget.dart';
import 'CustomView/ZaloMessageInputWidget.dart';

class ZaloMessagesDetailScreen extends CoreScreenWidget {
  @override
  CoreScreenState<ZaloMessagesDetailScreen> createState() =>
      ZaloMessagesDetailState();
}

class ZaloMessagesDetailState
    extends CoreScreenState<ZaloMessagesDetailScreen> {
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
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
                padding: EdgeInsets.only(right: 24),
                child: ImageUtils.getImagesSvg(IC_BACK_ARROW,
                    width: 18, height: 18, color: Colors.white)),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.receiverName,
                  style: TextStyles.BODY_2.getStyle
                      .copyWith(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.left,
                ),
                Text(model.lastTimeOnline,
                    style: TextStyles.CAPTION.getStyle.copyWith(color: gray0),
                    textAlign: TextAlign.left),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: ImageUtils.getImagesSvg(IC_ZALO_CALL,
              color: Colors.white, width: 20, height: 20),
          padding: EdgeInsets.only(left: 14, right: 14),
          onPressed: null,
        ),
        IconButton(
          icon: ImageUtils.getImagesSvg(IC_ZALO_VIDEO,
              color: Colors.white, width: 26, height: 26),
          onPressed: null,
        ),
        IconButton(
          icon: ImageUtils.getImagesSvg(IC_ZALO_SETTING,
              color: Colors.white, width: 20, height: 20),
          padding: EdgeInsets.only(left: 14, right: 16),
          onPressed: null,
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    model = MessageDetailModel();
    avatarWidget = ImageUtils.getImagesSvg(IC_AVATAR_DEFAULT_IMESS,
        width: 24, height: 24, color: gray5);
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
                  int previousIndex = index - 1;
                  bool shouldShowAvatar = (index == 0 ||
                      (previousIndex >= 0 &&
                          model.contents[previousIndex].messageType !=
                              model.contents[index].messageType));

                  if (messageModel.messageType ==
                      MessageType.OUTGOING_MESSAGE) {
                    return OutgoingZaloMessageWidget(messageModel);
                  }

                  return IncomingZaloMessageWidget(messageModel,
                      avatarWidget: avatarWidget,
                      shouldShowAvatar: shouldShowAvatar);
                }),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: InkWell(
                    onTap: () {
                      Utils.showDialogForScaleHeight(
                          context,
                          FunctionDialogWidget(
                            model,
                            AppSupport.ZALO,
                            screenshotController,
                            (_model) {
                              setState(() {
                                model = _model;
                              });
                            },
                            onChangeAvatar: (file) {
                              setState(() {
                                avatarWidget = Image.file(file,
                                    width: 24, height: 24, fit: BoxFit.cover);
                              });
                            },
                          ));
                    },
                    child: ZaloMessageInputWidget())),
          ],
        ));
  }
}
