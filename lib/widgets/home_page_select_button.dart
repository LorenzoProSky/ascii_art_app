import 'package:ascii_app/models/permission_handler.dart';
import 'package:ascii_app/routes/image_page/image_page_arguments.dart';
import 'package:ascii_app/routes/routes.dart';
import 'package:flutter/material.dart';

class HomePageSelectButton extends StatelessWidget {
  const HomePageSelectButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 50,
        width: 315,
        child: Material(
          elevation: 8.0,
          borderRadius: BorderRadius.circular(50.0),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Container(
                height: 50.0,
                width: 315.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              Container(
                height: 50.0,
                width: 105.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _mediaStoragePermissionAndToImagePageButton(context),
                  SizedBox(
                    height: 30.0,
                    width: 1,
                    child: VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  _cameraPermissionAndToImagePageButton(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mediaStoragePermissionAndToImagePageButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        PermissionHandler.requestMediaStoragePermission();
        await Navigator.of(context).pushNamed(RouteGenerator.imagePage,
            arguments: ImagePageArguments(false));
      },
      borderRadius: BorderRadius.circular(50.0),
      child: Container(
        height: 50.0,
        width: 148.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "Storage",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            SizedBox(
              height: 50.0,
              width: 50.0,
              child: Icon(
                Icons.photo,
                size: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cameraPermissionAndToImagePageButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        PermissionHandler.requestCameraPermission();
        await Navigator.of(context).pushNamed(RouteGenerator.imagePage,
            arguments: ImagePageArguments(true));
      },
      borderRadius: BorderRadius.circular(50.0),
      child: Container(
        height: 50.0,
        width: 148.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 50.0,
              width: 50.0,
              child: Icon(
                Icons.camera_alt,
                size: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Expanded(
              child: Text(
                "Camera",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
