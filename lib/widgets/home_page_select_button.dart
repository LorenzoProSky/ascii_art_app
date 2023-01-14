import 'package:ascii_app/models/permission_handler.dart';
import 'package:ascii_app/routes/image_page/image_page_arguments.dart';
import 'package:ascii_app/routes/routes.dart';
import 'package:flutter/material.dart';

class HomePageSelectButton extends StatelessWidget {
  const HomePageSelectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 45.0,
        width: 105.0,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _mediaStoragePermissionAndToImagePageButton(context),
            const SizedBox(
              height: 30.0,
              width: 1,
              child: VerticalDivider(
                width: 1,
                thickness: 1,
              ),
            ),
            _cameraPermissionAndToImagePageButton(context),
          ],
        ),
      ),
    );
  }

  Widget _mediaStoragePermissionAndToImagePageButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.photo),
      iconSize: 24,
      color: Theme.of(context).colorScheme.primary,
      onPressed: () async {
        PermissionHandler.requestMediaStoragePermission();
        await Navigator.of(context).pushNamed(RouteGenerator.imagePage,
            arguments: ImagePageArguments(false));
      },
    );
  }

  Widget _cameraPermissionAndToImagePageButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.camera_alt),
      iconSize: 24,
      color: Theme.of(context).colorScheme.primary,
      onPressed: () async {
        PermissionHandler.requestCameraPermission();
        await Navigator.of(context).pushNamed(RouteGenerator.imagePage,
            arguments: ImagePageArguments(true));
      },
    );
  }
}
