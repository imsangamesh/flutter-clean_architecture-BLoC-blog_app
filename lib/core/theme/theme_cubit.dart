import 'dart:developer';

import 'package:blog_app/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit(GetStorage box)
      : _box = box,
        super(false);

  final GetStorage _box;

  bool get isDark {
    log((_box.read<bool>(BoxKeys.isDark) ?? false).toString());
    return _box.read<bool>(BoxKeys.isDark) ?? false;
  }

  ThemeMode get mode => isDark ? ThemeMode.dark : ThemeMode.light;

  void setUp() {
    emit(isDark);
    log(' - - - - THEME setup complete | isDark: $isDark - - - - ');
  }

  void toggleTheme() {
    final newTheme = !isDark;
    emit(newTheme);
    _box.write(BoxKeys.isDark, newTheme);
  }
}
