import 'package:blog_app/core/constants/colors.dart';
import 'package:blog_app/core/services/injection_container.dart';
import 'package:flutter/material.dart';

class AppTStyles {
  AppTStyles._();

  // ------------------------------------------------------

  static final caption = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  );

  static final midCaption = TextStyle(
    fontSize: 15.5,
    fontWeight: FontWeight.w500,
    color: AppColors.mid,
  );

  static const body = TextStyle(fontSize: 16);

  static final primary = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: slTheme.isDark ? AppColors.purple : AppColors.pink,
  );

  static const heading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const large = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
}

/*
// 1 playfairDisplay
// 1 berkshireSwash
// 2 quicksand
// 3 zillaSlab - M

// amaticSc
*/
