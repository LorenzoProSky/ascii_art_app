import 'package:ascii_app/models/image_path_cache.dart';
import 'package:ascii_app/models/image_selector.dart';
import 'package:ascii_app/models/permission_handler.dart';
import 'package:ascii_app/routes.dart';
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
            _selectImageButton(context),
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

  Widget _selectImageButton(BuildContext context) {
    return Column(
      children: <Widget>[
        OutlinedButton(
          onPressed: () async {
            PermissionHandler.requestMultiplePermissions();
            Provider.of<ImagePathCache>(context).imagePath = "assets/inv_pixel.png";
            ImageSelector.selectImage(
                Provider.of<ImagePathCache>(context, listen: false));
            await Navigator.of(context).pushNamed(RouteGenerator.imagePage);
          },
          style: const ButtonStyle(
            side: MaterialStatePropertyAll(BorderSide(width: 1)),
            fixedSize: MaterialStatePropertyAll(Size.fromWidth(200)),
          ),
          child: Text(
            "Select Image",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
