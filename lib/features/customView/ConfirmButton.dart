import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  String title;
  Function? onTapButton;

  ConfirmButton(this.title, {this.onTapButton});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => onTapButton ?? Navigator.of(context).pop(),
        child: Container(
          height: 56,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: blue_primary_600,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            this.title,
            style: TextStyles.BUTTON.getStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
