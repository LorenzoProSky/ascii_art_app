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
            const SizedBox(
              height: 40.0,
            ),
            const HomePageSelectButton(),
          ],
        ),
      ),
    );
  }

  // TODO Redo Image
  Widget _homePageImage() {
    return const SizedBox(
      height: 440,
      width: 440,
      child: Image(
        image: AssetImage("assets/home_image.png"),
      ),
    );
  }
}
