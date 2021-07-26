import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FunctionButton extends StatelessWidget {
  Function()? onTap;

  FunctionButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(28),
      color: blue_primary_600,
      child: InkWell(
        onTap: this.onTap,
        child: Container(
          alignment: Alignment.center,
          width: 56,
          height: 56,
          child: Icon(Icons.edit, color: Colors.white, size: 24),
        ),
      ),
    );
  }

}