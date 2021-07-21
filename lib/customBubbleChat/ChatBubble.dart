import 'package:flutter/material.dart';

import 'BubbleType.dart';
import 'clippers/ChatBubbleClipper1.dart';
import 'clippers/ChatBubbleClipper10.dart';
import 'clippers/ChatBubbleClipper2.dart';
import 'clippers/ChatBubbleClipper3.dart';
import 'clippers/ChatBubbleClipper4.dart';
import 'clippers/ChatBubbleClipper5.dart';
import 'clippers/ChatBubbleClipper6.dart';
import 'clippers/ChatBubbleClipper7.dart';
import 'clippers/ChatBubbleClipper8.dart';
import 'clippers/ChatBubbleClipper9.dart';

class ChatBubble extends StatelessWidget {
  final CustomClipper<Path> clipper;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final Color? backGroundColor;
  final Color? shadowColor;
  final Alignment? alignment;

  ChatBubble(
    this.clipper, {
    this.child,
    this.elevation,
    this.backGroundColor,
    this.shadowColor,
    this.alignment,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment ?? Alignment.topLeft,
      margin: margin ?? EdgeInsets.all(0),
      child: PhysicalShape(
        clipper: clipper,
        elevation: elevation ?? 2,
        color: backGroundColor ?? Colors.blue,
        shadowColor: shadowColor ?? Colors.grey.shade200,
        child: Padding(
          padding: setPadding(),
          child: child ?? Container(),
        ),
      ),
    );
  }

  EdgeInsets setPadding() {
    if (clipper is ChatBubbleClipper1) {
      if ((clipper as ChatBubbleClipper1).type == BubbleType.sendBubble) {
        return EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20);
      } else {
        return EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 10);
      }
    } else if (clipper is ChatBubbleClipper2) {
      if ((clipper as ChatBubbleClipper2).type == BubbleType.sendBubble) {
        return EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 25);
      } else {
        return EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 10);
      }
    } else if (clipper is ChatBubbleClipper3) {
      if ((clipper as ChatBubbleClipper3).type == BubbleType.sendBubble) {
        return EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20);
      } else {
        return EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 10);
      }
    } else if (clipper is ChatBubbleClipper4) {
      if ((clipper as ChatBubbleClipper4).type == BubbleType.sendBubble) {
        return EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20);
      } else {
        return EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 10);
      }
    } else if (clipper is ChatBubbleClipper5) {
      if ((clipper as ChatBubbleClipper5).type == BubbleType.sendBubble) {
        return EdgeInsets.all(10);
      } else {
        return EdgeInsets.all(10);
      }
    } else if (clipper is ChatBubbleClipper6) {
      if ((clipper as ChatBubbleClipper6).type == BubbleType.sendBubble) {
        return EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 20);
      } else {
        return EdgeInsets.only(top: 10, bottom: 20, left: 20, right: 10);
      }
    } else if (clipper is ChatBubbleClipper7) {
      if ((clipper as ChatBubbleClipper7).type == BubbleType.sendBubble) {
        return EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15);
      } else {
        return EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15);
      }
    } else if (clipper is ChatBubbleClipper8) {
      if ((clipper as ChatBubbleClipper8).type == BubbleType.sendBubble) {
        return EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 15);
      } else {
        return EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 10);
      }
    } else if (clipper is ChatBubbleClipper9) {
      if ((clipper as ChatBubbleClipper9).type == BubbleType.sendBubble) {
        return EdgeInsets.only(top: 10, bottom: 15, left: 10, right: 15);
      } else {
        return EdgeInsets.only(top: 10, bottom: 15, left: 15, right: 10);
      }
    } else if (clipper is ChatBubbleClipper10) {
      if ((clipper as ChatBubbleClipper10).type == BubbleType.sendBubble) {
        return EdgeInsets.only(top: 15, bottom: 10, left: 10, right: 15);
      } else {
        return EdgeInsets.only(top: 15, bottom: 10, left: 15, right: 10);
      }
    }

    return EdgeInsets.all(10);
  }
}
