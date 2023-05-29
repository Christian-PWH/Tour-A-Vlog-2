import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tour_a_vlog/2_splash_onBoarding/screens/onboarding.dart';
import 'package:tour_a_vlog/3_auth/screens/signin.dart';
import 'package:tour_a_vlog/3_auth/screens/signup.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case '/on_boarding':
      return PageTransition(
          child: const OnBoardingScreen(), type: PageTransitionType.fade);
    case '/sign_in':
      return PageTransition(
          child: SignInScreen(), type: PageTransitionType.fade);
    case '/sign_up':
      return PageTransition(
          child: SignUpScreen(), type: PageTransitionType.fade);
    default:
      return PageTransition(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Page Not Found'),
              centerTitle: true,
            ),
            body: const Center(
              child: Text("This page does not exists"),
            ),
          ),
          type: PageTransitionType.scale);
  }
}
