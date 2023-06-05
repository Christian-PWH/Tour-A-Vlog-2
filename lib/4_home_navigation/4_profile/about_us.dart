import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';

class AboutUs extends StatelessWidget {
  static const routeName = '/about_us';

  const AboutUs({super.key});

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
          getTranslate(context, 'about_us.about_us'),
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
        padding: const EdgeInsets.all(fixPadding * 2),
        children: [
          termsAndCondition(context),
          heightSpace,
          dataPolicy(context),
        ],
      ),
    );
  }

  dataPolicy(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslate(context, 'about_us.data_policy'),
          style: semibold16black,
        ),
        height5Space,
        const Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sem maecenas proin nec, turpis iaculis viverra massa malesuada lacus.",
          style: regular14black,
        ),
        height5Space,
        const Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sem maecenas proin nec, turpis iaculis viverra massa malesuada lacus.",
          style: regular14black,
        ),
      ],
    );
  }

  termsAndCondition(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslate(context, 'about_us.terms_condition'),
          style: semibold16black,
        ),
        height5Space,
        const Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sem maecenas proin nec, turpis iaculis viverra massa malesuada lacus.",
          style: regular14black,
        )
      ],
    );
  }
}
