import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/features/InstagramMessageDetail/CustomView/IGMessageInputWidget.dart';
import 'package:fake_message_screen/features/customView/AddNewMessageButton.dart';
import 'package:fake_message_screen/features/customView/FunctionButton.dart';
import 'package:fake_message_screen/features/customView/FunctionDialogWidget.dart';
import 'package:fake_message_screen/features/home/selectApp/SelectAppScreen.dart';
import 'package:fake_message_screen/features/instagramMessageDetail/customView/MessengerInputWidget.dart';
import 'package:fake_message_screen/model/MessageDetailModel.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/Constants.dart';
import 'package:fake_message_screen/utils/ImageAssetsConstant.dart';
import 'package:fake_message_screen/utils/ImageUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'CustomView/IncomingIGMessageWidget.dart';
import 'CustomView/OutgoingIGMessageWidget.dart';

class InstagramMessageDetailScreen extends CoreScreenWidget {
  final AppSupport appSupport;

  InstagramMessageDetailScreen({this.appSupport = AppSupport.INSTAGRAM});

  @override
  InstagramMessageDetailState createState() => InstagramMessageDetailState();
}

class InstagramMessageDetailState
    extends CoreScreenState<InstagramMessageDetailScreen> {
  late MessageDetailModel model;
  late Widget avatarWidget;

  @override
  void initState() {
    super.initState();
    model = MessageDetailModel();
    avatarWidget = ImageUtils.getImagesSvg(IC_AVATAR_DEFAULT_IMESS,
        width: 34, height: 34, color: gray5);
  }

  @override
  PreferredSizeWidget createAppBarContent(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
      centerTitle: false,
      automaticallyImplyLeading: false,
      leading: null,
      elevation: 1,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
                padding: EdgeInsets.only(right: 16),
                child: ImageUtils.getImagesSvg(IC_BACK_ARROW,
                    width: 18,
                    height: 18,
                    color: Colors.black.withOpacity(0.8))),
          ),
          Container(
            padding: EdgeInsets.only(right: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17),
              child: avatarWidget,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.receiverName,
                style: TextStyles.HEADING_5.getStyle
                    .copyWith(color: Colors.black, fontSize: 18),
                textAlign: TextAlign.left,
              ),
              Text(model.lastTimeOnline,
                  style: TextStyles.CAPTION.getStyle
                      .copyWith(color: gray_600, fontSize: 13),
                  textAlign: TextAlign.left),
            ],
          ),
        ],
      ),
      actions: listActionButtonAppBar(),
    );
  }

  @override
  Widget buildMobileLayout(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 16),
      child: Stack(
        children: [
          ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 1,
                );
              },
              padding: EdgeInsets.symmetric(vertical: 16),
              itemCount: model.contents.length,
              itemBuilder: (context, index) {
                int previousIndex = index - 1;
                int nextIndex = index + 1;
                bool shouldShowBorderTop = (index == 0 ||
                    (previousIndex >= 0 &&
                        model.contents[previousIndex].messageType !=
                            model.contents[index].messageType));
                bool shouldShowBorderBottom =
                    (index == model.contents.length - 1 ||
                        (nextIndex < model.contents.length &&
                            model.contents[nextIndex].messageType !=
                                model.contents[index].messageType));
                return (model.contents[index].messageType ==
                        MessageType.OUTGOING_MESSAGE)
                    ? OutgoingIGMessageWidget(model.contents[index].content,
                        shouldBorderBottomRight: shouldShowBorderBottom,
                        shouldBorderTopRight: shouldShowBorderTop,
                        appSupport: widget.appSupport)
                    : IncomingIGMessageWidget(
                        model.contents[index].content, avatarWidget,
                        shouldBorderBottomLeft: shouldShowBorderBottom,
                        shouldBorderTopLeft: shouldShowBorderTop,
                        appSupport: widget.appSupport);
              }),
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
                    functionButton(),
                  ],
                ),
              )),
          buildInputWidget()
        ],
      ),
    );
  }

  Widget functionButton() {
    return FunctionButton(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return FunctionDialogWidget(
                model,
                (_model) {
                  setState(() {
                    model = _model;
                  });
                },
                onChangeAvatar: (file) {
                  setState(() {
                    avatarWidget = Image.file(file,
                        width: 34, height: 34, fit: BoxFit.cover);
                  });
                },
              );
            });
      },
    );
  }

  Widget buildInputWidget() {
    bool isInstagram = widget.appSupport == AppSupport.INSTAGRAM;

    return Positioned(
        bottom: isInstagram ? MediaQuery.of(context).padding.bottom : 0,
        left: 0,
        right: 0,
        child: isInstagram ? IGMessageInputWidget() : MessengerInputWidget());
  }

  List<Widget> listActionButtonAppBar() {
    List<Widget> listButton = [];

    if (widget.appSupport == AppSupport.INSTAGRAM) {
      listButton.add(IconButton(
        color: Colors.black,
        icon: ImageUtils.getImagesSvg(IC_IG_VIDEO,
            width: 20, height: 26, color: Colors.black),
        padding: EdgeInsets.only(left: 18),
        onPressed: () => Navigator.pop(context),
      ));

      listButton.add(IconButton(
        color: Colors.white,
        icon: ImageUtils.getImagesSvg(IC_IG_INFO,
            boxFit: BoxFit.fill, width: 24, height: 24, color: Colors.black),
        padding: EdgeInsets.only(left: 18, right: 24),
        onPressed: () => Navigator.pop(context),
      ));
    } else {
      listButton.add(IconButton(
        color: primaryColor,
        icon: ImageUtils.getImagesSvg(IC_MESSENGER_CALL,
            width: 22, height: 22, color: purple_500),
        padding: EdgeInsets.only(left: 18),
        onPressed: () => Navigator.pop(context),
      ));

      listButton.add(IconButton(
        color: Colors.white,
        icon: ImageUtils.getImagesSvg(IC_MESSENGER_CAMERA,
            boxFit: BoxFit.fill, width: 24, height: 30, color: purple_500),
        padding: EdgeInsets.only(left: 18, right: 24),
        onPressed: () => Navigator.pop(context),
      ));
    }

    return listButton;
  }
}
