import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/features/InstagramMessageDetail/CustomView/IGMessageInputWidget.dart';
import 'package:fake_message_screen/features/customView/AddNewMessageWidget.dart';
import 'package:fake_message_screen/features/customView/ConfirmButton.dart';
import 'package:fake_message_screen/features/customView/CustomTextField.dart';
import 'package:fake_message_screen/features/customView/FunctionButton.dart';
import 'package:fake_message_screen/features/customView/FunctionDialogWidget.dart';
import 'package:fake_message_screen/features/zaloMessageDetail/model/MessageDetailModel.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/Constants.dart';
import 'package:fake_message_screen/utils/ImageAssetsConstant.dart';
import 'package:fake_message_screen/utils/ImageUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'CustomView/IncomingIGMessageWidget.dart';
import 'CustomView/OutgoingIGMessageWidget.dart';

class InstagramMessageDetailScreen extends CoreScreenWidget {
  @override
  InstagramMessageDetailState createState() => InstagramMessageDetailState();
}

class InstagramMessageDetailState
    extends CoreScreenState<InstagramMessageDetailScreen> {
  late MessageDetailModel model;

  @override
  void initState() {
    super.initState();
    model = MessageDetailModel();
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.arrow_back_ios_sharp, size: 24, color: Colors.black.withOpacity(0.8),),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: (this.model.receiverAvatar == null ||
                      (this.model.receiverAvatar?.isEmpty == null))
                  ? ImageUtils.getImagesSvg(IC_AVATAR_DEFAULT_IMESS,
                      width: 40, height: 40, color: gray5)
                  : Image.network(
                      this.model.receiverAvatar!,
                      height: 40,
                      width: 40,
                    ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.receiverName,
                style: TextStyles.NORMAL_LABEL.getStyle.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              Text(model.lastTimeOnline,
                  style: TextStyles.CAPTION.getStyle
                      .copyWith(color: gray_600, fontSize: 11),
                  textAlign: TextAlign.left),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          color: Colors.black,
          icon: ImageUtils.getImagesSvg(IC_IG_VIDEO, width: 22, height: 25, color: Colors.black),
          iconSize: 24,
          padding: EdgeInsets.only(left: 18),
          onPressed: () => Navigator.pop(context),
        ),
        IconButton(
          color: Colors.white,
          icon: ImageUtils.getImagesSvg(IC_IG_INFO,
              boxFit: BoxFit.fill, width: 24, height: 24, color: Colors.black),
          iconSize: 24,
          padding: EdgeInsets.only(left: 18, right: 24),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }

  @override
  Widget buildMobileLayout(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16),
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
                    ? OutgoingIGMessageWidget(
                        model.contents[index].content,
                        shouldBorderBottomRight: shouldShowBorderBottom,
                        shouldBorderTopRight: shouldShowBorderTop,
                      )
                    : IncomingIGMessageWidget(
                        model.contents[index].content,
                        model.receiverAvatar,
                        shouldBorderBottomLeft: shouldShowBorderBottom,
                        shouldBorderTopLeft: shouldShowBorderTop,
                      );
              }),
          Positioned(bottom: 100, right: 16, child: functionButton()),
          Positioned(
              bottom: MediaQuery.of(context).padding.bottom,
              left: 0,
              right: 0,
              child: IGMessageInputWidget())
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
              return FunctionDialogWidget(model, (_model) {
                setState(() {
                  model = _model;
                });
              });
            });
      },
    );
  }
}
