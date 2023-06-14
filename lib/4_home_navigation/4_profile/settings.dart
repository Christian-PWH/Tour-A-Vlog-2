import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/languages.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = '/setting';

  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
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
          getTranslate(context, 'settings.settings'),
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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: fixPadding * 2),
        children: [
          appSetting(),
          heightSpace,
          divider(),
          heightSpace,
        ],
      ),
    );
  }

  divider() {
    return Container(
      width: double.infinity,
      height: 2,
      color: const Color(0xfff0f0f0),
    );
  }

  appSetting() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, 'settings.app_setting'),
            style: semibold18black,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, LanguagesScreen.routeName);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: fixPadding),
              child: Row(
                children: [
                  Image.asset(
                    "assets/profile/Shopicons_Filled_World.png",
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                  ),
                  widthSpace,
                  width5Space,
                  Expanded(
                    child: Text(
                      getTranslate(context, 'settings.languages'),
                      style: regular16black,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: blackColor,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
