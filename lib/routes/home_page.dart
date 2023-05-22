import 'package:ascii_app/models/notifiers/theme_notifier.dart';
import 'package:ascii_app/theme/theme.dart';
import 'package:ascii_app/widgets/back_button_custom.dart';
import 'package:ascii_app/widgets/home_page_select_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

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
                      image: (themeProvider.getTheme().brightness ==
                              Brightness.dark)
                          ? const AssetImage("assets/home_image_dark.png")
                          : const AssetImage("assets/home_image_dark.png"),
                      width:
                          (screenWidth * 0.65 < 440) ? screenWidth * 0.65 : 440,
                      height: (screenHeight * 0.65 < 440)
                          ? screenHeight * 0.65
                          : 440,
                      fit: BoxFit.fitHeight,
                    ),
                    SizedBox(
                      height:
                          (screenHeight * 0.05 < 40) ? screenHeight * 0.05 : 40,
                    ),
                    HomePageSelectButton(
                      width:
                          (screenWidth * 0.6 < 315) ? screenWidth * 0.6 : 315,
                      height:
                          (screenHeight * 0.05 < 50) ? screenHeight * 0.05 : 50,
                    ),
                    SizedBox(
                      height: (screenHeight * 0.025 < 20)
                          ? screenHeight * 0.025
                          : 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<ThemeProvider>(
                          builder: (context, themeProvider, _) {
                            var currentIcon =
                                themeProvider.getTheme().brightness ==
                                        Brightness.dark
                                    ? Icons.dark_mode_outlined
                                    : Icons.light_mode_outlined;

                            return IconButton(
                              icon: Icon(currentIcon),
                              iconSize: (screenHeight * 0.05 < 50)
                                  ? screenHeight * 0.05
                                  : 50,
                              onPressed: () {
                                if (themeProvider.getTheme().brightness ==
                                    Brightness.dark) {
                                  themeProvider.setTheme(AppTheme.lightTheme);
                                } else {
                                  themeProvider.setTheme(AppTheme.darkTheme);
                                }
                              },
                            );
                          },
                        ),
                        BackButtonCustom(
                            size: (screenHeight * 0.05 < 50)
                                ? screenHeight * 0.05
                                : 50),
                      ],
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
