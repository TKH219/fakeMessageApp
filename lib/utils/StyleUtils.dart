

import 'package:flutter/cupertino.dart';

import 'ColorUtils.dart';

enum TextStyles {
  HEADING_1,
  HEADING_2,
  HEADING_3,
  HEADING_4,
  HEADING_5,
  HEADING_6,
  SUB_HEADING_1,
  SUB_HEADING_2,
  BODY_1,
  BODY_2,
  CAPTION,
  NORMAL_LABEL,
  BUTTON
}

extension TextStylesExtension on TextStyles {
  TextStyle get getStyle {
    switch (this) {
      case TextStyles.HEADING_1:
        return TextStyle(
            fontFamily: "Source Sans Pro",
            fontSize: 72.0,
            fontWeight: FontWeight.w400,
            color: gray9
        );
      case TextStyles.HEADING_2:
        return TextStyle(
            fontFamily: "Source Sans Pro",
            fontWeight: FontWeight.w400,
            fontSize: 60.0,
            color: gray9
        );
      case TextStyles.HEADING_3:
        return TextStyle(
            fontFamily: "Source Sans Pro",
            fontWeight: FontWeight.w400,
            fontSize: 48.0,
            color: gray9
        );
      case TextStyles.HEADING_4:
        return TextStyle(
            fontFamily: "Source Sans Pro",
            fontWeight: FontWeight.w400,
            fontSize: 36.0,
            color: gray9
        );
      case TextStyles.HEADING_5:
        return TextStyle(
            fontFamily: "Source Sans Pro",
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
            color: gray9
        );
      case TextStyles.HEADING_6:
        return TextStyle(
            fontFamily: "Source Sans Pro",
            fontWeight: FontWeight.w600,
            fontSize: 24.0,
            color: gray9
        );
      case TextStyles.SUB_HEADING_1:
        return TextStyle(
            fontFamily: "Source Sans Pro",
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
            color: gray9
        );
      case TextStyles.SUB_HEADING_2:
        return TextStyle(
            fontFamily: "Source Sans Pro",
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
            color: gray9
        );
      case TextStyles.BODY_1:
        return TextStyle(
            fontFamily: "Source Sans Pro",
            fontWeight: FontWeight.w400,
            fontSize: 16.0,
            color: gray9
        );
      case TextStyles.BODY_2:
        return TextStyle(
            fontFamily: "Source Sans Pro",
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
            color: gray9
        );
      case TextStyles.CAPTION:
        return TextStyle(
            fontFamily: "Source Sans Pro",
            fontWeight: FontWeight.w400,
            fontSize: 12.0,
            color: gray9
        );
      case TextStyles.NORMAL_LABEL:
        return TextStyle(
            fontFamily: "Source Sans Pro",
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
            color: gray9
        );

      case TextStyles.BUTTON:
        return TextStyle(
            fontFamily: "Source Sans Pro",
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
            color: gray9
        );
      default:
        return TextStyle(
            fontFamily: "Source Sans Pro",
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
            color: gray9
        );
    }
  }
}