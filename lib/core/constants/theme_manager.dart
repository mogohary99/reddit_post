
import 'package:flutter/material.dart';

import 'colors_manager.dart';

ThemeData get appTheme => ThemeData(
  fontFamily: "Lato",
  scaffoldBackgroundColor: Colors.black,
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: AppColors.white2,
      fontWeight: FontWeight.w900,
      fontSize: 16,
    )
  ),
  appBarTheme: AppBarTheme(
    color: Colors.black,
    elevation: 0
  )

);