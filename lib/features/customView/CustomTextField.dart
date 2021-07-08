import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  Function(String)? onChanged;
  InputDecoration? decoration;
  int maxLines;
  @override
  CustomTextFieldState createState() => CustomTextFieldState();

  CustomTextField({this.onChanged, this.decoration, this.maxLines = 1});
}

class CustomTextFieldState extends State<CustomTextField> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardAppearance: Brightness.light,
        controller: textEditingController,
        onSubmitted: (text) {
          FocusScope.of(context).unfocus();
          if (widget.onChanged != null) {
            widget.onChanged!(text);
          }
        },
        obscureText: false,
        maxLines: widget.maxLines,
        style: TextStyles.BODY_1.getStyle,
        decoration: widget.decoration ?? InputDecoration(
          border: InputBorder.none,
          hintText: "",
          contentPadding: const EdgeInsets.all(15),
          errorMaxLines: 1,
        ),
        onChanged: (text) {
          if (widget.onChanged != null) {
            widget.onChanged!(text);
          }
        });
  }
}
