import 'package:flutter/material.dart';
import 'constants.dart';

final lightTheme = _buildLightTheme();
final darkTheme = _buildDarkTheme();

ThemeData _buildLightTheme() {
  const Color primaryColor = kPrimaryColor;
  const Color secondaryColor = kDarkPrimaryColor;
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
  );
  final ThemeData base = ThemeData(
    brightness: Brightness.light,
    accentColorBrightness: Brightness.dark,
    colorScheme: colorScheme,
    primaryColor: primaryColor,
    buttonColor: primaryColor,
    indicatorColor: Colors.white,
    toggleableActiveColor: secondaryColor,
    splashColor: Colors.white60,
    splashFactory: InkRipple.splashFactory,
    accentColor: secondaryColor,
    canvasColor: Colors.white,
    scaffoldBackgroundColor: kScaffoldBg,
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: Colors.white,
        textTheme: TextTheme(
            bodyText1: TextStyle(
          color: Colors.black,
        ))),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
    errorColor: Colors.red[400],
    buttonTheme: ButtonThemeData(
      colorScheme: colorScheme,
      textTheme: ButtonTextTheme.primary,
    ),
  );
  return base.copyWith(
    textTheme: base.textTheme.apply(fontFamily: 'Montserrat'),
    primaryTextTheme: base.primaryTextTheme.apply(fontFamily: 'Montserrat'),
    accentTextTheme: base.accentTextTheme.apply(fontFamily: 'Montserrat'),
  );
}

ThemeData _buildDarkTheme() {
  final ColorScheme colorScheme = const ColorScheme.light().copyWith(
    primary: kDarkBodyColor,
    secondary: kDarkSecondaryColor,
  );
  ThemeData darkMode = ThemeData.dark().copyWith(
    colorScheme: colorScheme,
    brightness: Brightness.dark,
    accentColor: kDarkAccentColor,
    cursorColor: kPrimaryColor,
    focusColor: kDarkAccentColor,
    primaryColor: kDarkSecondaryColor, //
    scaffoldBackgroundColor: kDarkBodyColor,
    canvasColor: kDarkBodyColor,
    iconTheme: IconThemeData(color: kDarkAccentColor),
    buttonTheme: ButtonThemeData(buttonColor: kDarkAccentColor),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: kDarkSecondaryColor,
      selectedItemColor: kDarkAccentColor,
      unselectedItemColor: kDarkAccentColor.withOpacity(0.5),
    ),

    accentIconTheme: IconThemeData(color: kDarkAccentColor),
    textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'Montserrat',
        bodyColor: Colors.white,
        displayColor: Colors.white),
    primaryTextTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'Montserrat',
        bodyColor: Colors.white,
        displayColor: Colors.white),
    accentTextTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'Montserrat',
        bodyColor: Colors.white,
        displayColor: Colors.white),
    appBarTheme: AppBarTheme(
        color: kDarkSecondaryColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: kDarkAccentColor)),
  );
  return darkMode;
}
