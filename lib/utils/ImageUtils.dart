import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageUtils {
  static Widget getImagesSvg(String assetName,
      {Color color = Colors.white, double width = 20, double height = 20, BoxFit boxFit = BoxFit.fill}) {
    return SvgPicture.asset(
      assetName,
      color: color,
      width: width,
      height: height,
      fit: boxFit,
    );
  }
}