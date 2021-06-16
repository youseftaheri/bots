import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_flutter_test_app1/config/theme.dart';

ThemeData light_mode = ThemeData(
  primaryColor: AppColors.colorPrimary,
  primaryColorLight: AppColors.lightGray,
  accentColor: AppColors.colorPrimaryDark,
  bottomAppBarColor: AppColors.lightGray,
  backgroundColor: AppColors.background,
  dialogBackgroundColor: AppColors.backgroundLight,
  scaffoldBackgroundColor: AppColors.white,
  errorColor: AppColors.red,
  dividerColor: Colors.transparent,
  appBarTheme: AppBarTheme(
      color: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.colorPrimary),
      textTheme: TextTheme(
          caption: TextStyle(
              color: AppColors.colorPrimary,
              fontSize: 18,
              fontFamily: 'Iransans',
              fontWeight: FontWeight.w400))),
);

ThemeData dark_mode = ThemeData(
  primaryColor: AppColors.colorPrimary,
  primaryColorLight: AppColors.lightGray,
  accentColor: AppColors.colorPrimaryDark,
  bottomAppBarColor: AppColors.lightGray,
  backgroundColor: AppColors.black,
  dialogBackgroundColor: AppColors.backgroundLight,
  scaffoldBackgroundColor: AppColors.black,
  errorColor: AppColors.red,
  dividerColor: Colors.transparent,
  appBarTheme: AppBarTheme(
      color: AppColors.black,
      iconTheme: IconThemeData(color: AppColors.colorPrimary),
      textTheme: TextTheme(
          caption: TextStyle(
              color: AppColors.colorPrimary,
              fontSize: 18,
              fontFamily: 'Iransans',
              fontWeight: FontWeight.w400))),
);

class ThemeNotifier extends ChangeNotifier {
  final String key = "theme";
  SharedPreferences _preferences;
  bool _darkMode;

  bool get darkMode => _darkMode;

  ThemeNotifier() {
    _darkMode = false;
    _loadFromPreferences();
  }

  _initialPreferences() async {
    if(_preferences == null)
      _preferences = await SharedPreferences.getInstance();
  }

  _savePreferences()async {
    await _initialPreferences();
    _preferences.setBool(key, _darkMode);
  }

  _loadFromPreferences() async {
    await _initialPreferences();
    _darkMode = _preferences.getBool(key) ?? false;
    notifyListeners();
  }

  toggleChangeTheme() {
    _darkMode = !_darkMode;
    _savePreferences();
    notifyListeners();
  }


}