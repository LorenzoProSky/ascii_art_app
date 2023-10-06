import 'package:ascii_app/models/notifiers/theme_notifier.dart';
import 'package:ascii_app/theme/theme.dart';
import 'package:ascii_app/widgets/exit_button_custom.dart';
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
                  (screenHeight * 0.03 < 30) ? screenHeight * 0.03 : 30,
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
                            ExitButtonCustom(
                                size: (screenHeight * 0.04 < 40)
                                    ? screenHeight * 0.04
                                    : 40),
                            SizedBox(
                              width: screenWidth * 0.65,
                            ),
                            Consumer<ThemeProvider>(
                              builder: (context, themeProvider, _) {
                                var currentIcon =
                                    themeProvider.getTheme().brightness ==
                                            Brightness.dark
                                        ? Icons.dark_mode
                                        : Icons.light_mode;
                                return IconButton(
                                  icon: Icon(currentIcon),
                                  iconSize: (screenHeight * 0.04 < 40)
                                      ? screenHeight * 0.04
                                      : 40,
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
                          height: (screenHeight * 0.12 < 110)
                              ? screenHeight * 0.12
                              : 110,
                        ),
                        Image(
                          image: (themeProvider.getTheme().brightness ==
                                  Brightness.dark)
                              ? const AssetImage("assets/home_image_dark.png") //TODO
                              : const AssetImage("assets/home_image_light.png"),
                          width: (screenWidth < 500) ? screenWidth : 500,
                          height: (screenHeight * 0.62 < 420)
                              ? screenHeight * 0.62
                              : 420,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: (screenHeight * 0.052 < 52)
                              ? screenHeight * 0.052
                              : 52,
                        ),
                        HomePageSelectButton(
                          width: (screenWidth * 0.8 < 380)
                              ? screenWidth * 0.8
                              : 380,
                          height: (screenHeight * 0.05 < 50)
                              ? screenHeight * 0.05
                              : 50,
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
