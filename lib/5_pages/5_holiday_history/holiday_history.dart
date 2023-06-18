import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/1_package_detail.dart/package_detail.dart';
import 'package:tour_a_vlog/5_pages/5_rate/rate.dart';

class HolidayHistory extends StatelessWidget {
  static const routeName = '/holiday_history';

  const HolidayHistory({super.key});

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
          getTranslate(context, 'holiday_ongoing_history.holiday_package'),
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
        padding: const EdgeInsets.all(fixPadding * 2),
        physics: const BouncingScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              detailText(getTranslate(context, 'holiday_ongoing_history.date'),
                  "11 dec 2022 - 15 dec 2022"),
              divider(size),
              detailText(
                  getTranslate(
                      context, 'holiday_ongoing_history.no_travellers'),
                  "2 ${getTranslate(context, 'holiday_ongoing_history.person')}"),
            ],
          ),
          heightSpace,
          packageContainer(context, size),
          heightBox(40.0),
          giverateButton(size, context),
        ],
      ),
    );
  }

  giverateButton(Size size, context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return const Rate();
            });
      },
      child: Container(
        width: double.infinity,
        height: size.height * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: gradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.25),
              blurRadius: 5,
            )
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslate(context, 'holiday_ongoing_history.give_rate'),
          style: semibold18white,
        ),
      ),
    );
  }

  packageContainer(BuildContext context, Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PackageDetail.routeName);
      },
      child: Container(
        padding: const EdgeInsets.all(fixPadding),
        margin: const EdgeInsets.symmetric(vertical: fixPadding),
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
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                "assets/packages/package1.png",
                height: size.height * 0.17,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            height5Space,
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTranslate(
                            context, 'holiday_ongoing_history.experiance_text'),
                        style:
                            medium16black.copyWith(fontWeight: FontWeight.w500),
                      ),
                      height5Space,
                      Text(
                        getTranslate(context, 'holiday_ongoing_history.text'),
                        style: medium14grey94,
                      ),
                      height5Space,
                      RichText(
                        text: TextSpan(
                          text: "\$11500",
                          style: semibold16primary,
                          children: [
                            TextSpan(
                              text: getTranslate(context,
                                  'holiday_ongoing_history.per_person'),
                              style: medium14grey94.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: fixPadding, vertical: fixPadding / 2),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        blurRadius: 5,
                      )
                    ],
                    border: Border.all(color: primaryColor),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "4N/5D",
                    style: medium14primary,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  divider(Size size) {
    return Container(
      height: size.height * 0.06,
      width: 1,
      color: grey94Color,
    );
  }

  detailText(title, text) {
    return Column(
      children: [
        Text(
          title,
          style: medium14black,
        ),
        Text(
          text,
          style: medium12grey94,
        )
      ],
    );
  }
}
