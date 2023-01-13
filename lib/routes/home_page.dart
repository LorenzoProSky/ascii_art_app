import 'package:ascii_app/models/image_path_cache.dart';
import 'package:ascii_app/models/permission_handler.dart';
import 'package:ascii_app/routes/image_page.dart';
import 'package:ascii_app/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(
          30.0,
        ),
        child: Column(
          children: <Widget>[
            _homePageImage(),
            _titleText(context),
            _mediaStoragePermissionAndToImagePageButton(context),
            _cameraPermissionAndToImagePageButton(context),
          ],
        ),
      ),
    );
  }

  Widget _homePageImage() {
    return Column(
      children: const <Widget>[
        SizedBox(
          height: 40,
        ),
        SizedBox(
          height: 350,
          width: 380,
          child: Image(
            image: AssetImage("assets/home_image.png"),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _titleText(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "ASCII Art\nImage Converter",
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _mediaStoragePermissionAndToImagePageButton(BuildContext context) {
    return Column(
      children: <Widget>[
        OutlinedButton(
          onPressed: () => _permissionsThenToImagePage(context, false),
          style: const ButtonStyle(
            side: MaterialStatePropertyAll(BorderSide(width: 1)),
            fixedSize: MaterialStatePropertyAll(Size.fromWidth(200)),
          ),
          child: Text(
            "Select Image\nfrom Storage",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }

  Widget _cameraPermissionAndToImagePageButton(BuildContext context) {
    return Column(
      children: <Widget>[
        OutlinedButton(
          onPressed: () => _permissionsThenToImagePage(context, true),
          style: const ButtonStyle(
            side: MaterialStatePropertyAll(BorderSide(width: 1)),
            fixedSize: MaterialStatePropertyAll(Size.fromWidth(200)),
          ),
          child: Text(
            "Take Image\nfrom Camera",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }

  void _permissionsThenToImagePage(BuildContext context, bool needCamera) async {
    if (needCamera) {
      PermissionHandler.requestCameraPermission();
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<ImagePathCache>(
            create: (_) => ImagePathCache(),
            child: const LoadingOverlay(
              child: ImagePage(needCamera: true),
            ),
          ),
        ),
      );
    } else {
      PermissionHandler.requestMediaStoragePermission();
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<ImagePathCache>(
            create: (_) => ImagePathCache(),
            child: const LoadingOverlay(
              child: ImagePage(needCamera: false),
            ),
          ),
        ),
      );
    }
  }
}
