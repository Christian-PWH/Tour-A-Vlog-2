import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/about_us.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/profile_booking.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/edit_profile.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/feed_back.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/settings.dart';
import 'package:tour_a_vlog/5_pages/1_notification/notification.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          topImageContainer(size, context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                  horizontal: fixPadding * 2, vertical: fixPadding * 2),
              physics: const BouncingScrollPhysics(),
              children: [
                imageOptions(
                  "assets/profile/Shopicon.png",
                  getTranslate(context, 'profile.edit_profile'),
                  17.0,
                  () {
                    Navigator.pushNamed(context, EditProfile.routeName);
                  },
                ),
                divider(),
                iconOptions(
                  Icons.notifications_rounded,
                  getTranslate(context, 'profile.notification'),
                  () {
                    Navigator.pushNamed(context, NotificationScreen.routeName);
                  },
                ),
                divider(),
                imageOptions(
                  "assets/profile/fluent_ticket-diagonal-16-filled.png",
                  getTranslate(context, 'profile.my_booking'),
                  20,
                  () {
                    Navigator.pushNamed(
                        context, ProfileBookingScreen.routeName);
                  },
                ),
                divider(),
                iconOptions(
                  Icons.settings,
                  getTranslate(context, 'profile.settings'),
                  () {
                    Navigator.pushNamed(context, SettingScreen.routeName);
                  },
                ),
                divider(),
                iconOptions(
                  Icons.info,
                  getTranslate(context, 'profile.about_us'),
                  () {
                    Navigator.pushNamed(context, AboutUs.routeName);
                  },
                ),
                divider(),
                // iconOptions(Icons.thumb_up_alt,
                //     getTranslate(context, 'profile.feedback'), () {
                //   Navigator.pushNamed(context, FeedbackScreen.routeName);
                // }),
              ],
            ),
          )
        ],
      ),
    );
  }

  divider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 2,
      width: double.infinity,
      color: const Color(0xfff0f0f0),
    );
  }

  imageOptions(icon, title, double size, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: fixPadding),
        child: Row(
          children: [
            Image.asset(
              icon,
              height: size,
              width: size,
              fit: BoxFit.cover,
            ),
            widthSpace,
            widthSpace,
            Expanded(
              child: Text(
                title,
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
    );
  }

  iconOptions(icon, title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: fixPadding),
        child: Row(
          children: [
            ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                        colors: gradient,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)
                    .createShader(bounds);
              },
              child: Icon(
                icon,
                size: 22,
                color: whiteColor,
              ),
            ),
            widthSpace,
            widthSpace,
            Expanded(
              child: Text(
                title,
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
    );
  }

  topImageContainer(Size size, BuildContext context) {
    return SizedBox(
      height: size.height * 0.3,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: size.height * 0.21,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
                horizontal: fixPadding * 2, vertical: fixPadding * 2),
            decoration: BoxDecoration(
              color: primaryColor,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: const AssetImage("assets/auth/signin.png"),
                colorFilter: ColorFilter.mode(
                    primaryColor.withOpacity(0.4), BlendMode.dstIn),
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(getTranslate(context, 'profile.profile'),
                          style: semibold20white),
                      GestureDetector(
                        onTap: () {
                          logout(context);
                        },
                        child: Container(
                          height: size.height * 0.04,
                          padding: const EdgeInsets.all(fixPadding / 2),
                          width: size.height * 0.04,
                          decoration: const BoxDecoration(
                            color: whiteColor,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            "assets/profile/ant-design_logout-outlined.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  height: size.height * 0.13,
                  width: size.height * 0.13,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    "assets/profile/User Image.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                const Text(
                  "Terasaki",
                  style: semibold16black,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  logout(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(fixPadding * 2),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                getTranslate(context, 'profile.logout_text'),
                style: semibold16black,
              ),
              heightSpace,
              heightSpace,
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding:
                              const EdgeInsets.symmetric(vertical: fixPadding),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: grey94Color.withOpacity(0.5),
                                  blurRadius: 5,
                                )
                              ]),
                          alignment: Alignment.center,
                          child: Text(
                            getTranslate(context, 'profile.cancel'),
                            style: semibold16black.copyWith(color: grey94Color),
                          )),
                    ),
                  ),
                  widthSpace,
                  widthSpace,
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                          padding:
                              const EdgeInsets.symmetric(vertical: fixPadding),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              gradient: const LinearGradient(
                                  colors: gradient,
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.25),
                                  blurRadius: 5,
                                )
                              ]),
                          alignment: Alignment.center,
                          child: Text(
                            getTranslate(context, 'profile.logout'),
                            style: semibold16white,
                          )),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
