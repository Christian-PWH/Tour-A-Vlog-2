import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/4_home_navigation/bottom_navigation.dart';

class SuccessScreen extends StatelessWidget {
  static const routeName = '/success';

  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
          physics: const BouncingScrollPhysics(),
          children: [
            heightBox(size.height * 0.2),
            image(size),
            heightBox(size.height * 0.07),
            successText(context),
            heightBox(size.height * 0.12),
            textButton(context),
          ],
        ),
      ),
    );
  }

  textButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, BottomNavigationScreen.routeName);
      },
      child: Text(
        getTranslate(context, 'success.back_home'),
        style: medium14primary,
      ),
    );
  }

  successText(context) {
    return Column(
      children: [
        Text(
          getTranslate(context, 'success.success_text'),
          style: semibold16primary,
          textAlign: TextAlign.center,
        ),
        height5Space,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
          child: Text(
            getTranslate(context, 'success.success_content'),
            style: regular12grey,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  image(Size size) {
    return Image.asset(
      "assets/success/Mobile payments-pana 1.png",
      height: size.height * 0.4,
      width: size.height * 0.4,
      fit: BoxFit.cover,
    );
  }
}
