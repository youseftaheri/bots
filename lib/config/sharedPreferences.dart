import 'package:shared_preferences/shared_preferences.dart';

Future<Null> removeFromSF({String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}

Future<Null>  addStringToSF({String key, String value}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<Null>  addIntToSF({String key, int value}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt(key, value);
}

Future<Null>  addDoubleToSF({String key, double value}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setDouble(key, value);
}

Future<Null>  addBoolToSF({String key, bool value}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key, value);
}

Future<String> getStringValuesSF({String key, String defaultValue = ''}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String stringValue = prefs != null ? prefs.getString(key) ?? defaultValue : defaultValue;
  return stringValue;
}

Future<bool> getBoolValuesSF({String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return bool
  bool boolValue = prefs != null ? prefs.getBool(key) ?? false : false;
  return boolValue;
}

Future<int> getIntValuesSF({String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return int
  int intValue = prefs != null ? prefs.getInt(key) ?? 0 : 0;
  return intValue;
}

Future<double> getDoubleValuesSF({String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return double
  double doubleValue = prefs != null ? prefs.getDouble(key) ?? 0.0 : 0.0;
  return doubleValue;
}

