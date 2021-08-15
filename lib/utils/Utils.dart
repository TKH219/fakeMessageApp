import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'ColorUtils.dart';

class Utils {
  static void showToastMessage(String message,
      [ToastGravity gravity = ToastGravity.CENTER]) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: gravity,
        timeInSecForIosWeb: 1,
        backgroundColor: gray4,
        textColor: black_4a,
        fontSize: 15);
  }

  static void showDialogForScaleHeight(
      BuildContext context, Widget widgetContent) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    constraints: BoxConstraints(
                        minHeight: 102,
                        maxHeight: MediaQuery.of(context).size.height - 150),
                    // padding: EdgeInsets.only(
                    //     left: BaseDimens.w_dp_16,
                    //     right: BaseDimens.w_dp_16,
                    //     bottom: BaseDimens.w_dp_16),
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).padding.bottom +
                            MediaQuery.of(context).viewInsets.bottom,
                        left: 16,
                        right: 16,
                        top: 12),
                    child: SingleChildScrollView(
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        // padding: padding,
                        child: widgetContent,
                        // child: Column(
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: widgetContent),
                      ),
                    )),
              ],
            ));
  }
}
