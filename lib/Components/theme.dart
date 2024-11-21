import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samahat_barter/constants.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: barterPrimary,
    fontFamily: "Montserrat",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyLarge: TextStyle(color: bodyText1),
    bodyMedium: TextStyle(color: bodyText2),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
      color: barterPrimary,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
/*       textTheme: TextTheme(
          titleLarge: TextStyle(color: Colors.white, fontSize: 12)
      ), 
       */
      
      systemOverlayStyle: SystemUiOverlayStyle.light
  );
}