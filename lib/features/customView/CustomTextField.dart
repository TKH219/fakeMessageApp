import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  Function(String)? onChanged;
  InputDecoration? decoration;
  int maxLines;
  TextInputType? keyboardType;
  @override
  CustomTextFieldState createState() => CustomTextFieldState();

  CustomTextField({this.onChanged, this.decoration, this.maxLines = 1, this.keyboardType});
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
        keyboardType: widget.keyboardType ?? (widget.maxLines == 1 ? TextInputType.text : TextInputType.multiline),
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
