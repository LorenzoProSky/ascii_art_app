import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static void requestMultiplePermissions() async {
    var statuses = await [
      Permission.storage,
      Permission.mediaLibrary,
    ].request();

    if (!(statuses[Permission.storage] as PermissionStatus).isGranted &&
        !(statuses[Permission.mediaLibrary] as PermissionStatus).isGranted) {
      await openAppSettings();
    }
  }
}
