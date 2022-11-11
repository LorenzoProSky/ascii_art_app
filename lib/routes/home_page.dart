import 'package:ascii_app/routes.dart';
import 'package:ascii_app/utilities/img_cache.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 40),
            const SizedBox(
              height: 350,
              width: 380,
              child: Image(
                image: AssetImage("assets/homeImage.png"),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "ASCII Art\nImage Converter",
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                requestMultiplePermissions();
                imgCacheInizializeAndNavigate(
                    context.read<ImgCache>(), Navigator.of(context));
              },
              style: const ButtonStyle(
                side: MaterialStatePropertyAll(BorderSide(width: 1)),
                fixedSize: MaterialStatePropertyAll(Size.fromWidth(200)),
              ),
              child: Text("Select Image",
                  style: Theme.of(context).textTheme.bodyText1),
            ),
          ],
        ),
      ),
    );
  }
}

void requestMultiplePermissions() async {
  var statuses = await [
    Permission.storage,
    Permission.mediaLibrary,
  ].request();

  if (!(statuses[Permission.storage] as PermissionStatus).isGranted &&
      !(statuses[Permission.mediaLibrary] as PermissionStatus).isGranted) {
    await openAppSettings();
  }
}

void imgCacheInizializeAndNavigate(
    ImgCache cache, NavigatorState navState) async {
  final picker = ImagePicker();
  final selectedFile = await picker.pickImage(source: ImageSource.gallery);

  final path = selectedFile!.path;
  cache.imgPath = path;
  final bytes = await selectedFile.readAsBytes();
  cache.imgCache = bytes;

  await navState.pushNamed(RouteGenerator.imagePage);
}
