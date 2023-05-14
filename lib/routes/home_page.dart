import 'package:ascii_app/widgets/home_page_select_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;

          return Center(
            child: Container(
              width: screenWidth,
              height: screenHeight,
              color: Theme.of(context).canvasColor,
              child: Padding(
                padding: EdgeInsets.all(
                  (screenHeight * 0.045 < 30) ? screenHeight * 0.045 : 30,
                ),
                child: Column(
                  children: <Widget>[
                    Image(
                      image: const AssetImage("assets/home_image.png"),
                      width: (screenWidth * 0.65 < 440) ? screenWidth * 0.65 : 440,
                      height: (screenHeight * 0.65 < 440) ? screenHeight * 0.65 : 440,
                      fit: BoxFit.fitHeight,
                    ),
                    SizedBox(
                      height: (screenHeight * 0.05 < 40) ? screenHeight * 0.05 : 40,
                    ),
                    HomePageSelectButton(
                      width:
                          (screenWidth * 0.6 < 315) ? screenWidth * 0.6 : 315,
                      height: 
                      (screenHeight * 0.05 < 50) ? screenHeight * 0.05 : 50,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
