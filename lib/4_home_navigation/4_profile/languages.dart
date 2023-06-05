import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';

import '../../main.dart';

String? languageValue;

class LanguagesScreen extends StatefulWidget {
  static const routeName = '/language';

  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  SharedPreferences? prefs;
  final key = "value";

  @override
  void initState() {
    super.initState();
    _read();
  }

  _read() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      languageValue = prefs!.getString(key) ?? "English";
    });
  }

  void _changeLanguges(String languageCode) async {
    Locale temp = await setLocales(languageCode);

    // ignore: use_build_context_synchronously
    MyApp.setLocale(context, temp);
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 22,
            color: whiteColor,
          ),
        ),
        titleSpacing: 0,
        title: Text(
          getTranslate(context, 'languages.language'),
          style: semibold18white,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: LanguagesList.languageList.length,
        padding: const EdgeInsets.all(fixPadding * 2),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            height: size.height * 0.07,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: fixPadding * 2),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: grey94Color.withOpacity(0.5),
                  blurRadius: 5,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: ListTile(
              onTap: () {
                _changeLanguges(
                    LanguagesList.languageList[index].languageCode!);
                setState(() {
                  languageValue = LanguagesList.languageList[index].name;
                });
                prefs?.setString(key, languageValue!);
              },
              leading: languageValue == LanguagesList.languageList[index].name
                  ? Container(
                      height: size.height * 0.028,
                      width: size.height * 0.028,
                      padding: const EdgeInsets.all(fixPadding / 1.7),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: gradient,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: whiteColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : Container(
                      height: size.height * 0.028,
                      width: size.height * 0.028,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: greyb7Color,
                        ),
                      ),
                    ),
              minLeadingWidth: 0,
              title: Text(
                LanguagesList.languageList[index].name.toString(),
                style: regular16black.copyWith(height: 0.8),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LanguagesList {
  final int? id;
  final String? name;
  final String? languageCode;

  LanguagesList({this.id, this.languageCode, this.name});

  static List<LanguagesList> languageList = [
    LanguagesList(id: 1, name: "English", languageCode: 'en'),
    LanguagesList(id: 3, name: "Indonesia", languageCode: 'id'),
  ];
}
