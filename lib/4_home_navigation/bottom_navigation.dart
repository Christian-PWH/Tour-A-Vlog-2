import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/models/user_model.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/1_common/widgets/error_screen.dart';
import 'package:tour_a_vlog/3_auth/controller/user_controller.dart';
import 'package:tour_a_vlog/3_auth/screens/signin.dart';
import 'package:tour_a_vlog/4_home_navigation/1_home/home.dart';
import 'package:tour_a_vlog/4_home_navigation/2_booking/booking.dart';
import 'package:tour_a_vlog/4_home_navigation/3_favorites/favorites.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/profile.dart';

class BottomNavigationScreen extends ConsumerStatefulWidget {
  static const routeName = '/bottom_navigation';

  const BottomNavigationScreen({super.key});

  @override
  ConsumerState<BottomNavigationScreen> createState() =>
      _BottomNavigationScreenState();
}

class _BottomNavigationScreenState
    extends ConsumerState<BottomNavigationScreen> {
  int selectedIndex = 0;

  DateTime? backPressTime;

  @override
  Widget build(BuildContext context) {
    ref.listen(userControllerProvider, (previous, next) {
      debugPrint('Employee Home Screen - ref listen profileControllerProvider');
      if (!next.hasValue || next.value == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, SignInScreen.routeName, (route) => false);
        return;
      }
    });

    final currentUser = ref.watch(userControllerProvider);
    debugPrint('Main navigation - build scaffold');
    return currentUser.when(
      data: (user) {
        return WillPopScope(
          onWillPop: () async {
            bool backStatus = onWillPop(context);
            if (backStatus) {
              exit(0);
            } else {
              return false;
            }
          },
          child: Scaffold(
            body: pages(selectedIndex, user),
            bottomNavigationBar: bottomNavigationBar(),
          ),
        );
      },
      error: (error, stackTrace) {
        return const ErrorScreen(text: 'Navigator Screen - Call Developer');
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget pages(int selectedIndex, UserModel? userModel) {
    switch (selectedIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const BookingScreen();
      case 2:
        return const FavoriteScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: whiteColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: secondaryColor,
      unselectedItemColor: const Color(0xffb7b7b7),
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w200,
        color: secondaryColor,
        fontSize: 14,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.w200,
        color: Color(0xffb7b7b7),
        fontSize: 14,
      ),
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      currentIndex: selectedIndex,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_rounded),
          label: getTranslate(context, 'bottom_navigation.home'),
          activeIcon: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: gradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            child: const Icon(
              Icons.home_rounded,
              color: whiteColor,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/bottomavigation/fluent_ticket-diagonal-16-filled.png",
            height: 24,
            width: 24,
          ),
          label: getTranslate(context, 'bottom_navigation.booking'),
          activeIcon: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: gradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            child: Image.asset(
              "assets/bottomavigation/fluent_ticket-diagonal-16-filled.png",
              height: 24,
              width: 24,
              color: whiteColor,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite),
          label: getTranslate(context, 'bottom_navigation.favorites'),
          activeIcon: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: gradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            child: const Icon(
              Icons.favorite,
              color: whiteColor,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: getTranslate(context, 'bottom_navigation.profile'),
          activeIcon: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: gradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            child: const Icon(
              Icons.person,
              color: whiteColor,
            ),
          ),
        ),
      ],
    );
  }

  onWillPop(context) {
    DateTime now = DateTime.now();

    if (backPressTime == null ||
        now.difference(backPressTime!) > const Duration(seconds: 2)) {
      backPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: blackColor,
            content: Text(
              getTranslate(context, 'app_exit.exit_text'),
              style: const TextStyle(
                color: whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            duration: const Duration(milliseconds: 1500),
            behavior: SnackBarBehavior.floating),
      );
      return false;
    } else {
      return true;
    }
  }
}
