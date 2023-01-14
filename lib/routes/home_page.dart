import 'package:ascii_app/widgets/home_page_select_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(
          30.0,
        ),
        child: Column(
          children: <Widget>[
            _homePageImage(),
            _titleText(context),
            const HomePageSelectButton(),
          ],
        ),
      ),
    );
  }

  Widget _homePageImage() {
    return Column(
      children: const <Widget>[
        SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 350,
          width: 380,
          child: Image(
            // TODO Redo Image
            image: AssetImage("assets/home_image.png"),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _titleText(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Text(
          // TODO Title
          "ASCII Art\nConverter",
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
