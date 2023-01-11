import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static void requestMediaStoragePermission() async {
    var statuses = await [
      Permission.storage,
      Permission.mediaLibrary,
    ].request();

    if (!(statuses[Permission.storage] as PermissionStatus).isGranted &&
        !(statuses[Permission.mediaLibrary] as PermissionStatus).isGranted) {
      await openAppSettings();
    }
  }

  static void requestCameraPermission() async {
    var statuses = await [
      Permission.camera,
    ].request();

    if (!(statuses[Permission.camera] as PermissionStatus).isGranted) {
      await openAppSettings();
    }
  }
}
