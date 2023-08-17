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
                  (screenHeight * 0.05 < 50) ? screenHeight * 0.05 : 50,
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: (screenHeight * 0.03 < 30)
                              ? screenHeight * 0.03
                              : 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BackButtonCustom(
                                size: (screenHeight * 0.045 < 45)
                                    ? screenHeight * 0.045
                                    : 45),
                            SizedBox(
                              width: screenWidth * 0.62,
                            ),
                            Consumer<ThemeProvider>(
                              builder: (context, themeProvider, _) {
                                var currentIcon =
                                    themeProvider.getTheme().brightness ==
                                            Brightness.dark
                                        ? Icons.dark_mode_outlined
                                        : Icons.light_mode_outlined;
                                return IconButton(
                                  icon: Icon(currentIcon),
                                  iconSize: (screenHeight * 0.045 < 45)
                                      ? screenHeight * 0.045
                                      : 45,
                                  onPressed: () {
                                    if (themeProvider.getTheme().brightness ==
                                        Brightness.dark) {
                                      themeProvider
                                          .setTheme(AppTheme.lightTheme);
                                    } else {
                                      themeProvider
                                          .setTheme(AppTheme.darkTheme);
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: (screenHeight * 0.08 < 80)
                              ? screenHeight * 0.08
                              : 80,
                        ),
                        Image(
                          image: (themeProvider.getTheme().brightness ==
                                  Brightness.dark)
                              ? const AssetImage("assets/home_image_dark.png")
                              : const AssetImage("assets/home_image_dark.png"),
                          width: (screenWidth < 500) ? screenWidth : 500,
                          height: (screenHeight * 0.65 < 450)
                              ? screenHeight * 0.65
                              : 450,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: (screenHeight * 0.05 < 50)
                              ? screenHeight * 0.05
                              : 50,
                        ),
                        HomePageSelectButton(
                          width: (screenWidth * 0.75 < 350)
                              ? screenWidth * 0.75
                              : 350,
                          height: (screenHeight * 0.055 < 55)
                              ? screenHeight * 0.055
                              : 55,
                        ),
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
