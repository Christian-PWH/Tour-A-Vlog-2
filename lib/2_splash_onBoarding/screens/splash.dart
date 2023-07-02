import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/1_common/widgets/error_screen.dart';
import 'package:tour_a_vlog/2_splash_onBoarding/screens/onboarding.dart';
import 'package:tour_a_vlog/3_auth/controller/user_controller.dart';
import 'package:tour_a_vlog/4_home_navigation/bottom_navigation.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/notification_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _requestPermission(context);
  }

  void _requestPermission(context) async {
    if (Platform.isAndroid) {
      if (await Permission.location.isPermanentlyDenied) {
        Permission.location.request();
      }
      if (await Permission.storage.isPermanentlyDenied) {
        Permission.storage.request();
      }
      if (await Permission.camera.isPermanentlyDenied) {
        Permission.camera.request();
      }
      if (await Permission.microphone.isPermanentlyDenied) {
        Permission.microphone.request();
      }
      Map<Permission, PermissionStatus> _ = await [
        Permission.location,
        Permission.storage,
        Permission.camera,
        Permission.microphone,
      ].request();
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(notificationControllerProvider);
    notifications.when(
      data: (data) {},
      error: (error, stackTrace) {},
      loading: () {},
    );
    final size = MediaQuery.of(context).size;
    final currentUser = ref.watch(userControllerProvider);
    ref.listen(userControllerProvider, (previous, next) {
      debugPrint("Splash Screen - ref listen profileControllerProvider");
      if (!next.hasValue || next.value == null) {
        Timer(const Duration(seconds: 2), () {
          Navigator.popAndPushNamed(context, OnBoardingScreen.routeName);
        });
        return;
      }
      Timer(const Duration(seconds: 2), () {
        Navigator.popAndPushNamed(context, BottomNavigationScreen.routeName);
      });
    });
    return Scaffold(
      body: currentUser.when(
        data: (user) {
          return _splashWidget(size);
        },
        error: (error, stackTrace) {
          return const ErrorScreen(text: 'Splash Screen - Call Developer');
        },
        loading: () {
          return _splashWidget(size);
        },
      ),
    );
  }

  Widget _splashWidget(Size size) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/splash/App Logo Inspiration 132.png",
              height: size.height * 0.12,
              width: size.height * 0.12,
            ),
            const Text(
              "Touravelog",
              style: bold60white,
            )
          ],
        ),
      ),
    );
  }
}
