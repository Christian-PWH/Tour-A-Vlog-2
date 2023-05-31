import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tour_a_vlog/2_splash_onBoarding/screens/onboarding.dart';
import 'package:tour_a_vlog/3_auth/screens/signin.dart';
import 'package:tour_a_vlog/3_auth/screens/signup.dart';
import 'package:tour_a_vlog/4_home_navigation/1_home/home.dart';
import 'package:tour_a_vlog/4_home_navigation/2_booking/booking.dart';
import 'package:tour_a_vlog/4_home_navigation/3_favorites/favorites.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/profile.dart';
import 'package:tour_a_vlog/4_home_navigation/bottom_navigation.dart';
import 'package:tour_a_vlog/5_pages/detail/detail.dart';
import 'package:tour_a_vlog/5_pages/international_destination/international_destination.dart';
import 'package:tour_a_vlog/5_pages/latest_collection/latest_collection.dart';
import 'package:tour_a_vlog/5_pages/notification/notification.dart';
import 'package:tour_a_vlog/5_pages/search/search.dart';
import 'package:tour_a_vlog/5_pages/top_indonesia_destination/top_indonesia_destination.dart';

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
    case '/bottom_navigation':
      return PageTransition(
          child: const BottomNavigationScreen(),
          type: PageTransitionType.leftToRight);
    case '/home':
      return PageTransition(
          child: const HomeScreen(), type: PageTransitionType.leftToRight);
    case '/booking':
      return PageTransition(
          child: const BookingScreen(), type: PageTransitionType.leftToRight);
    case '/favorites':
      return PageTransition(
          child: const FavoriteScreen(), type: PageTransitionType.leftToRight);
    case '/profile':
      return PageTransition(
          child: const ProfileScreen(), type: PageTransitionType.leftToRight);

    case '/detail':
      return PageTransition(
          child: const DetailScreen(), type: PageTransitionType.leftToRight);
    case '/international_destination':
      return PageTransition(
          child: const InternationalDestination(),
          type: PageTransitionType.leftToRight);
    case '/latest_collection':
      return PageTransition(
          child: LatestCollection(), type: PageTransitionType.leftToRight);
    case '/notification':
      return PageTransition(
          child: const NotificationScreen(),
          type: PageTransitionType.leftToRight);
    case '/search':
      return PageTransition(
          child: const SearchScreen(), type: PageTransitionType.leftToRight);
    case '/top_indonesia_destination':
      return PageTransition(
          child: TopIndonesiaDestination(),
          type: PageTransitionType.leftToRight);
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
