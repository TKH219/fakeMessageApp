
import 'package:permission_handler/permission_handler.dart';

enum PERMISSION_NEXT{
  GO,
  AKS_REQUEST,
  GO_SETTING
}

class PermissionService {
  static PermissionHandler _permissionHandler = PermissionHandler();

  static Future<PERMISSION_NEXT> havePermissionForAccessPhoto() async {
    var permission = Platform.isAndroid ? PermissionGroup.storage : PermissionGroup.photos;
    PermissionStatus result=  await _permissionHandler.checkPermissionStatus(permission);
    return _returnPermission(result);
  }

  static requestPermissionForAccessPhoto(Function onGranted) async{
    PermissionGroup permission = Platform.isAndroid ? PermissionGroup.storage : PermissionGroup.photos;
    var result =  await _permissionHandler.requestPermissions([permission]);
    if (result[permission]== PermissionStatus.granted) {
      // permission was granted
      onGranted();
    }else{
      //denied show dialog custom

    }
  }

  static Future<bool> handleRequestingAccessPhoto() async {
    List<PermissionGroup> permissionList = [];
//    permissionList.add(PermissionGroup.camera);
    if (Platform.isAndroid) {
      permissionList.add(PermissionGroup.storage);
    } else {
      permissionList.add(PermissionGroup.photos);
    }
    for (var permissionItem in permissionList) {
      PermissionStatus checkStatus = await _permissionHandler.checkPermissionStatus(permissionItem);
      if (Platform.isAndroid) {
        if (checkStatus == PermissionStatus.neverAskAgain) {
          throw HandlePermissionDeniedException(permissionGroup: permissionItem, message: checkStatus);
        }
      } else if (Platform.isIOS) {
        if (checkStatus == PermissionStatus.denied) {
          throw HandlePermissionDeniedException(permissionGroup: permissionItem, message: checkStatus);
        }
      }
    }
    var result =  await _permissionHandler.requestPermissions(permissionList);
    bool isGranted = true;
    result.forEach((group, value) {
      if (permissionList.contains(group)) {
        isGranted = isGranted && (value == PermissionStatus.granted);
      }
    });
    return isGranted;
  }

  static openSettingPage() async{
    await _permissionHandler.openAppSettings();
  }
  static PERMISSION_NEXT _returnPermission(PermissionStatus result){
    switch(result){
      case PermissionStatus.granted:
        return PERMISSION_NEXT.GO;
      case PermissionStatus.neverAskAgain:
      case PermissionStatus.restricted:
        return PERMISSION_NEXT.GO_SETTING;
      case PermissionStatus.denied:
        if(Platform.isIOS){
          return PERMISSION_NEXT.GO_SETTING;
        }else{
          return PERMISSION_NEXT.AKS_REQUEST;
        }
        break;
      case PermissionStatus.unknown:
      //show request
        return PERMISSION_NEXT.AKS_REQUEST;
      case PermissionStatus.limited:
        // TODO: Handle this case.
        break;
      case PermissionStatus.permanentlyDenied:
        // TODO: Handle this case.
        break;
    }
    return PERMISSION_NEXT.GO_SETTING;
  }
  //check permission android notification android and ios
  static havePermissionNotification()async{
    ServiceStatus result=  await _permissionHandler.checkServiceStatus(PermissionGroup.notification);
    switch(result){
      case ServiceStatus.disabled:
      case ServiceStatus.notApplicable:
        return PERMISSION_NEXT.GO_SETTING;
      default:
        return PERMISSION_NEXT.GO;
    }
  }
  static requestPermissionNotification(Function onGranted) async{
    var result =  await _permissionHandler.requestPermissions([PermissionGroup.notification]);
    if (result[PermissionGroup.notification]== PermissionStatus.granted) {
      // permission was granted
      onGranted();
    }else{
      //denied show dialog custom

    }
  }
}