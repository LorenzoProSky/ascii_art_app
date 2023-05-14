import 'package:ascii_app/models/permission_handler.dart';
import 'package:ascii_app/routes/image_page/image_page_arguments.dart';
import 'package:ascii_app/routes/routes.dart';
import 'package:flutter/material.dart';

class HomePageSelectButton extends StatelessWidget {
  const HomePageSelectButton({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: Material(
          elevation: 8.0,
          borderRadius: BorderRadius.circular(height),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(height),
                ),
              ),
              Container(
                width: width * 0.25,
                height: height,
                decoration: BoxDecoration(
                  color: Theme.of(context).focusColor,
                  borderRadius: BorderRadius.circular(height),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _mediaStoragePermissionAndToImagePageButton(context),
                  SizedBox(
                    width: 1,
                    height: height * 0.8,
                    child: VerticalDivider(
                      width: 1,
                      thickness: 1,
                      color: Theme.of(context).primaryColor,
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
      borderRadius: BorderRadius.circular(height),
      child: Container(
        width: width * 0.49,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height),
        ),
        child: Row(
          children: [
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Storage",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
            SizedBox(
              width: width * 0.11,
              height: height,
              child: Icon(
                Icons.photo,
                size: height * 0.63,
                color: Theme.of(context).primaryColor,
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
      borderRadius: BorderRadius.circular(height),
      child: Container(
        width: width * 0.49,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height),
        ),
        child: Row(
          children: [
            SizedBox(
              width: width * 0.11,
              height: height,
              child: Icon(
                Icons.camera_alt,
                size: height * 0.63,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Camera",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
