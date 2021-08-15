import 'package:fake_message_screen/model/ItemKey.dart';
import 'package:fake_message_screen/utils/ColorUtils.dart';
import 'package:fake_message_screen/utils/StyleUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectMessageTypeWidget extends StatefulWidget {
  final List<ItemKey> listData;

  SelectMessageTypeWidget(this.listData);

  @override
  SelectMessageTypeState createState() => SelectMessageTypeState();
}

class SelectMessageTypeState extends State<SelectMessageTypeWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: widget.listData.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.trailing,
            contentPadding: EdgeInsets.zero,
            title: Text(
              widget.listData[index].value,
              style: TextStyles.NORMAL_LABEL.getStyle.copyWith(color: gray9),
            ),
            value: widget.listData[index].isSelected,
            activeColor: blue_primary_600,
            onChanged: (_) {
              setState(() {
                widget.listData.forEach((item) {
                  item.isSelected = false;
                });

                widget.listData[index].isSelected = true;
              });
            },
          );
        });
  }
}