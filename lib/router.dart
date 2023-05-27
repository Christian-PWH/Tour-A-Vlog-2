import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tour_a_vlog/2_splash_onBoarding/screens/onboarding.dart';
import 'package:tour_a_vlog/3_auth/screens/signin.dart';
import 'package:tour_a_vlog/3_auth/screens/signup.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case '/onBoarding':
      return PageTransition(
          child: const OnBoardingScreen(), type: PageTransitionType.fade);
    case '/signIn':
      return PageTransition(
          child: SignInScreen(), type: PageTransitionType.rightToLeft);
    case '/signUp':
      return PageTransition(
          child: SignUpScreen(), type: PageTransitionType.rightToLeft);
    default:
      return PageTransition(
          child: Container(), type: PageTransitionType.rightToLeft);
  }
}
