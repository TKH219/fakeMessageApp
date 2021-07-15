import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

enum PERMISSION_NEXT { GO, AKS_REQUEST, GO_SETTING }

class PermissionService {
  static Future<bool> getPhotoPermission(BuildContext context) async {
    // var permission = await Permission.photos.status;
    PermissionStatus permission = await Permission.photos.request();

    if (permission.isGranted || permission.isLimited) {
      return true;
    } else if (permission.isDenied ||
        permission.isRestricted ||
        permission.isPermanentlyDenied) {
      print("${permission.toString()}");
      //   openAppSettings();
      // } else {
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text('Photos Permission'),
                content: Text(
                    'This app needs access to photos to change avatar of receiver user.'),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('Deny'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoDialogAction(
                      child: Text('Settings'),
                      onPressed: () {
                        openAppSettings();
                      }),
                ],
              ));
    }

    return false;
  }
}
