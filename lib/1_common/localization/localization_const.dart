import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'localization.dart';

String getTranslate(BuildContext context, String key) {
  return DemoLocalizations.of(context).getTranslateValues(key);
}

String translate(String key) {
  return DemoLocalizations.instance.getTranslateValues(key);
}

const String english = 'en';
const String indonesian = 'id';
const String languageKey = "languageCode";

Future<Locale> setLocales(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(languageKey, languageCode);
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  Locale temp;
  switch (languageCode) {
    case english:
      temp = Locale(languageCode);
      break;
    case indonesian:
      temp = Locale(languageCode);
      break;
    default:
      temp = const Locale(english);
  }
  return temp;
}

Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String languageCode = prefs.getString(languageKey) ?? english;
  return _locale(languageCode);
}
