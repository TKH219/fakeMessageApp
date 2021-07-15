import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageUtils {
  static Image getPngImage(String imagePath,
      {BoxFit scaleStyle = BoxFit.fill,
        double width = 0.0,
        double height = 0.0}) {
    var assetsImage = AssetImage(imagePath); //<- Creates an object that fetches an image.
    if (width == 0 || height == 0) {
      return Image(image: assetsImage, fit: scaleStyle);
    } else {
      return Image(
        image: assetsImage,
        fit: scaleStyle,
        width: width,
        height: height,

      );
    }
  }

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

  static Widget getOriginalImagesSvg(String assetName,
      {double width = 20, double height = 20, BoxFit boxFit = BoxFit.fill}) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      fit: boxFit,
    );
  }
}