import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tour_a_vlog/1_common/models/tour_model.dart';
import 'package:tour_a_vlog/1_common/models/city_model.dart';
import 'package:tour_a_vlog/2_splash_onBoarding/screens/onboarding.dart';
import 'package:tour_a_vlog/3_auth/screens/signin.dart';
import 'package:tour_a_vlog/3_auth/screens/signup.dart';
import 'package:tour_a_vlog/4_home_navigation/1_home/home.dart';
import 'package:tour_a_vlog/4_home_navigation/2_booking/booking.dart';
import 'package:tour_a_vlog/4_home_navigation/2_booking/open_trip.dart';
import 'package:tour_a_vlog/4_home_navigation/2_booking/private_tour.dart';
import 'package:tour_a_vlog/4_home_navigation/3_favorites/favorites.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/about_us.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/profile_booking.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/edit_profile.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/feed_back.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/languages.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/profile.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/settings.dart';
import 'package:tour_a_vlog/4_home_navigation/bottom_navigation.dart';
import 'package:tour_a_vlog/5_pages/1_credit_card/credit_card.dart';
import 'package:tour_a_vlog/5_pages/1_detail/detail.dart';
import 'package:tour_a_vlog/5_pages/1_discover_by_categories/discover_by_categories.dart';
import 'package:tour_a_vlog/5_pages/1_recommendation/recommendation.dart';
import 'package:tour_a_vlog/5_pages/1_notification/notification.dart';
import 'package:tour_a_vlog/5_pages/1_package_detail.dart/package_detail.dart';
import 'package:tour_a_vlog/5_pages/1_packages/packages.dart';
import 'package:tour_a_vlog/5_pages/1_review/review.dart';
import 'package:tour_a_vlog/5_pages/1_search/search.dart';
import 'package:tour_a_vlog/5_pages/1_success/success.dart';
import 'package:tour_a_vlog/5_pages/1_top_indonesia_destination/top_indonesia_destination.dart';
import 'package:tour_a_vlog/5_pages/1_travel_detail/travel_detail.dart';
import 'package:tour_a_vlog/5_pages/2_holiday_package/holiday_packages.dart';
import 'package:tour_a_vlog/5_pages/3_place_detail/place_detail.dart';
import 'package:tour_a_vlog/5_pages/3_similar_place/similar_place.dart';
import 'package:tour_a_vlog/5_pages/4_pick_location/pick_location.dart';
import 'package:tour_a_vlog/5_pages/5_holiday_history/holiday_history.dart';
import 'package:tour_a_vlog/5_pages/5_holiday_ongoing/holiday_ongoing.dart';
import 'package:tour_a_vlog/5_pages/5_rate/rate.dart';

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

    //home screen
    case '/home':
      return PageTransition(
          child: const HomeScreen(), type: PageTransitionType.leftToRight);
    //home - 1
    case '/top_indonesia_destination':
      final cities = routeSettings.arguments as List<CityModel>;
      return PageTransition(
          child: TopIndonesiaDestination(cities: cities),
          type: PageTransitionType.leftToRight);
    //home - 2 - detail screen
    case '/detail':
      final city = routeSettings.arguments as CityModel;
      return PageTransition(
          child: DetailScreen(city: city),
          type: PageTransitionType.leftToRight);
    case '/packages':
      final packageMap = routeSettings.arguments as Map<String, dynamic>;
      return PageTransition(
          child: Packages(packageMap: packageMap),
          type: PageTransitionType.leftToRight);
    case '/packages_detail':
      final tour = routeSettings.arguments as TourModel;
      return PageTransition(
          child: PackageDetail(tour: tour),
          type: PageTransitionType.leftToRight);
    case '/travel_detail':
      return PageTransition(
          child: const TravelDetail(), type: PageTransitionType.leftToRight);
    case '/credit_card':
      return PageTransition(
          child: const CreditCard(), type: PageTransitionType.leftToRight);
    case '/success':
      return PageTransition(
          child: const SuccessScreen(), type: PageTransitionType.leftToRight);
    case '/review':
      return PageTransition(
          child: ReviewScreen(), type: PageTransitionType.leftToRight);
    //home - 3
    case '/recommendation':
      final tours = routeSettings.arguments as List<TourModel>;
      return PageTransition(
          child: Recommendation(tours: tours),
          type: PageTransitionType.leftToRight);
    case '/discover_by_category':
      final categoryTitle = routeSettings.arguments as String;
      return PageTransition(
          child: DiscoverByCategories(categoryTitle: categoryTitle),
          type: PageTransitionType.leftToRight);
    //home - 4
    case '/notification':
      return PageTransition(
          child: const NotificationScreen(),
          type: PageTransitionType.leftToRight);
    //home - 5
    case '/search':
      return PageTransition(
          child: const SearchScreen(), type: PageTransitionType.leftToRight);

    //booking screen
    case '/booking':
      return PageTransition(
          child: const BookingScreen(), type: PageTransitionType.leftToRight);
    //booking - 1
    case '/holiday_packages':
      return PageTransition(
          child: const HolidayPackages(), type: PageTransitionType.leftToRight);
    //booking - 2
    case '/open_trip':
      return PageTransition(
          child: const OpenTrip(), type: PageTransitionType.leftToRight);
    case '/private_tour':
      return PageTransition(
          child: const PrivateTour(), type: PageTransitionType.leftToRight);

    //favorite
    case '/favorites':
      return PageTransition(
          child: const FavoriteScreen(), type: PageTransitionType.leftToRight);
    case '/place_detail':
      return PageTransition(
          child: const PlaceDetail(), type: PageTransitionType.leftToRight);
    case '/similar_place':
      return PageTransition(
          child: const SimilarPlace(), type: PageTransitionType.leftToRight);

    //profile
    case '/profile':
      return PageTransition(
          child: const ProfileScreen(), type: PageTransitionType.leftToRight);
    //profile - 1
    case '/edit_profile':
      return PageTransition(
          child: const EditProfile(), type: PageTransitionType.leftToRight);
    case '/pick_location':
      return PageTransition(
          child: const PickLocation(), type: PageTransitionType.leftToRight);
    //profile - 2
    case '/profile_booking':
      return PageTransition(
          child: const ProfileBookingScreen(),
          type: PageTransitionType.leftToRight);
    case '/holiday_ongoing':
      return PageTransition(
          child: const HolidayOngoing(), type: PageTransitionType.leftToRight);
    case '/holiday_history':
      return PageTransition(
          child: const HolidayHistory(), type: PageTransitionType.leftToRight);
    //profile - 3
    case '/setting':
      return PageTransition(
          child: const SettingScreen(), type: PageTransitionType.leftToRight);
    case '/language':
      return PageTransition(
          child: const LanguagesScreen(), type: PageTransitionType.leftToRight);
    //profile - 4
    case '/about_us':
      return PageTransition(
          child: const AboutUs(), type: PageTransitionType.leftToRight);
    //profile - 5
    case '/feedback':
      return PageTransition(
          child: const FeedbackScreen(), type: PageTransitionType.leftToRight);

    case '/rate':
      return PageTransition(
          child: const Rate(), type: PageTransitionType.leftToRight);
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
          type: PageTransitionType.fade);
  }
}
