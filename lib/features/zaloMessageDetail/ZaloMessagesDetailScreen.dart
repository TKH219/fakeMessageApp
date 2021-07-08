import 'package:fake_message_screen/core/CoreScreenWidget.dart';
import 'package:fake_message_screen/core/CoreStateWidget.dart';
import 'package:fake_message_screen/features/customView/ConfirmButton.dart';
import 'package:fake_message_screen/features/customView/FunctionButton.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'CustomView/IncomingZaloMessageWidget.dart';
import 'CustomView/OutgoingZaloMessageWidget.dart';
import 'CustomView/ZaloMessageInputWidget.dart';

class ZaloMessagesDetailScreen extends CoreScreenWidget {
  @override
  CoreScreenState<ZaloMessagesDetailScreen> createState() => ZaloMessagesDetailState();
}

class ZaloMessagesDetailState extends CoreScreenState<ZaloMessagesDetailScreen> {

  bool _switchValue = true;

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
            "Mr Ha",
            style:
                TextStyles.NORMAL_LABEL.getStyle.copyWith(color: Colors.white),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 4,
          ),
          Text("Truy cap 20 phut truoc",
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
  Widget buildMobileLayout(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          ListView.builder(
              itemCount: 9,
              itemBuilder: (context, index) {
                if (index % 3 == 0) {
                  return OutgoingZaloMessageWidget(
                      index % 2 == 0
                          ? "testttt"
                          : "Đây là mã vạch khai báo y tế..các cô chú có thể khai ở nhà rồi mình ra xét nghiệm cho nhanh ậ. Xin cảm ơn",
                      "11:20");
                }

                return IncomingZaloMessageWidget(
                    index % 2 == 0
                        ? "testttt"
                        : "Đây là mã vạch khai báo y tế..các cô chú có thể khai ở nhà rồi mình ra xét nghiệm cho nhanh ậ. Xin cảm ơn",
                    "11:20");
              }),
          Positioned(
              bottom: 100,
              right: 16,
              child: functionButton()),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ZaloMessageInputWidget()),
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
              return Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 12),
                      TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(width: 1, color: gray1),
                              ),
                              hintText: "Change Name"),
                          onChanged: (text) {
                            print(text);
                          },
                        ),
                      SizedBox(height: 12),
                      TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(width: 1, color: gray1),
                              ),
                              hintText: "Change last time online"),
                          onChanged: (text) {
                            print(text);
                          },
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
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 12),
                      ConfirmButton("done".toUpperCase(), onTapButton: null,)
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  Widget addNewMessage() {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 16,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(width: 1, color: gray1),
                  ),
                  hintText: "Contents..."),
              maxLines: 2,
              onChanged: (text) {
                print(text);
              },
            ),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Nguoi gui"),
                CupertinoSwitch(
                  value: _switchValue,
                  onChanged: (value) {
                    setState(() {
                      _switchValue = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16,),
            ConfirmButton("done".toUpperCase(), onTapButton: null,)
          ],
        ),
      ),
    );
  }
}
