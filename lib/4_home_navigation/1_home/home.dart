import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/models/city_model.dart';
import 'package:tour_a_vlog/1_common/models/user_model.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/1_common/widgets/column_builder.dart';
import 'package:tour_a_vlog/1_common/widgets/error_screen.dart';
import 'package:tour_a_vlog/3_auth/controller/user_controller.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/category_controller.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/city_controller.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/tour_controller.dart';
import 'package:tour_a_vlog/5_pages/1_detail/detail.dart';
import 'package:tour_a_vlog/5_pages/1_discover_by_categories/discover_by_categories.dart';
import 'package:tour_a_vlog/5_pages/1_package_detail.dart/package_detail.dart';
import 'package:tour_a_vlog/5_pages/1_recommendation/recommendation.dart';
import 'package:tour_a_vlog/5_pages/1_notification/notification.dart';
import 'package:tour_a_vlog/5_pages/1_search/search.dart';
import 'package:tour_a_vlog/5_pages/1_top_indonesia_destination/top_indonesia_destination.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentUser = ref.watch(userControllerProvider);
    debugPrint('Main Home - build scaffold');
    return currentUser.when(
      data: (userModel) {
        debugPrint("main home = $userModel");
        return Scaffold(
          backgroundColor: whiteColor,
          body: Column(
            children: [
              topImageContainer(size, context, userModel),
              bottomView(size),
            ],
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

  Widget bottomView(Size size) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(
            left: 0.0, right: 0.0, top: 0.0, bottom: fixPadding),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          discoverByCategoriesList(size),
          recommendationListView(size),
          indonesiaDestinationList(size),
        ],
      ),
    );
  }

  Widget discoverByCategoriesList(Size size) {
    final categories = ref.watch(categoryControllerProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: fixPadding * 2, vertical: fixPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                getTranslate(context, 'home.discover_categories'),
                style: semibold16white.copyWith(
                    color: const Color(0xff333333),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        SizedBox(
            height: size.height * 0.15,
            width: double.maxFinite,
            child: categories.when(
              data: (data) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                  itemCount: data.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (data.isEmpty) {
                      return const Center(child: Text('NO DATA'));
                    }
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: fixPadding),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, DiscoverByCategories.routeName,
                              arguments: data[index].title);
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.1,
                              width: size.height * 0.1,
                              child: ClipOval(
                                clipBehavior: Clip.antiAlias,
                                child: Image.network(
                                  data[index].image,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, event) {
                                    if (event == null) return child;
                                    return Center(
                                      child: SizedBox(
                                        width: 20.0,
                                        height: 20.0,
                                        child: CircularProgressIndicator(
                                          value: event.cumulativeBytesLoaded /
                                              (event.expectedTotalBytes ?? 1),
                                        ),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, object, stacktrace) {
                                    return const Center(
                                      child: SizedBox(
                                        width: 20.0,
                                        height: 20.0,
                                        child: Icon(Icons.image_not_supported),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            height5Space,
                            Text(
                              data[index].title,
                              style: regular16black,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              error: (error, stackTrace) {
                return const Center(child: Text('Error'));
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
            ))
      ],
    );
  }

  Widget recommendationListView(Size size) {
    final recommendations = ref.watch(recommendationProvider);
    return recommendations.when(
      data: (data) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: fixPadding * 2, vertical: fixPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      getTranslate(context, 'home.recommendation'),
                      style: semibold16white.copyWith(
                          color: const Color(0xff333333),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        Recommendation.routeName,
                        arguments: data,
                      );
                    },
                    child: Text(
                      getTranslate(context, 'home.see_all'),
                      style: medium14primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.width * 0.55,
              width: double.maxFinite,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                itemCount: data.length < 5 ? data.length : 5,
                // only view top 5 item
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (data.isEmpty) {
                    return const Center(child: Text('NO DATA'));
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PackageDetail.routeName,
                        arguments: data[index],
                      );
                    },
                    child: Container(
                      width: size.width * 0.4,
                      margin: const EdgeInsets.symmetric(
                          horizontal: fixPadding, vertical: fixPadding / 2),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: grey94Color.withOpacity(0.5),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10)),
                              child: Image.network(
                                data[index].image[0],
                                width: size.width * 0.4,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, event) {
                                  if (event == null) return child;
                                  return Center(
                                    child: SizedBox(
                                      width: 20.0,
                                      height: 20.0,
                                      child: CircularProgressIndicator(
                                        value: event.cumulativeBytesLoaded /
                                            (event.expectedTotalBytes ?? 1),
                                      ),
                                    ),
                                  );
                                },
                                errorBuilder: (context, object, stacktrace) {
                                  return const Center(
                                    child: SizedBox(
                                      width: 20.0,
                                      height: 20.0,
                                      child: Icon(Icons.image_not_supported),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: fixPadding / 2,
                                horizontal: fixPadding),
                            child: Text(
                              data[index].title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: medium14black33,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
      error: (error, stackTrace) {
        return const Center(child: Text('Error'));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget indonesiaDestinationList(Size size) {
    final cities = ref.watch(indonesiaDestinationControllerProvider);
    return cities.when(
      data: (data) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: fixPadding * 2, vertical: fixPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      getTranslate(context, 'home.indonesia_destination'),
                      style: semibold16white.copyWith(
                          color: const Color(0xff333333),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        TopIndonesiaDestination.routeName,
                        arguments: data,
                      );
                    },
                    child: Text(
                      getTranslate(context, 'home.see_all'),
                      style: medium14primary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.23,
              width: double.maxFinite,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                itemCount: data.length < 5 ? data.length : 5,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (data.isEmpty) {
                    return const Center(child: Text('NO DATA'));
                  }
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        DetailScreen.routeName,
                        arguments: data[index],
                      );
                    },
                    child: Container(
                      width: size.width * 0.4,
                      margin: const EdgeInsets.symmetric(
                          horizontal: fixPadding, vertical: fixPadding / 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            data[index].image,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: grey94Color.withOpacity(0.5),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: fixPadding / 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              blackColor.withOpacity(0.07),
                              blackColor.withOpacity(0.1),
                              blackColor.withOpacity(0.2),
                              blackColor.withOpacity(0.3),
                              blackColor.withOpacity(0.6),
                              blackColor.withOpacity(0.9),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          data[index].title,
                          style: semibold18white,
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
      error: (error, stackTrace) {
        return const Center(child: Text('Error'));
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget topImageContainer(
    Size size,
    BuildContext context,
    UserModel? userModel,
  ) {
    final cities = ref.watch(cityControllerProvider);

    return Container(
      height: size.height * 0.21,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      decoration: BoxDecoration(
        color: primaryColor,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: const AssetImage("assets/auth/signin.png"),
          colorFilter:
              ColorFilter.mode(primaryColor.withOpacity(0.4), BlendMode.dstIn),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          "Hi, ${userModel?.fullName ?? 'User'} ${getTranslate(context, "home.travel_text")}",
                          style: semibold18white,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.room_rounded,
                            size: 18,
                            color: whiteColor,
                          ),
                          width5Space,
                          cities.when(
                            data: (data) {
                              return GestureDetector(
                                onTap: () {
                                  selectCityDialog(context, size, data);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      ref.watch(selectedCityNameProvider),
                                      style: semibold14white,
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color: whiteColor,
                                    )
                                  ],
                                ),
                              );
                            },
                            error: (error, stackTrace) {
                              return const Center(child: Text('Error '));
                            },
                            loading: () {
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                  width: size.height * 0.04,
                  child: Stack(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, NotificationScreen.routeName);
                        },
                        icon: const Icon(
                          Icons.notifications_sharp,
                          color: whiteColor,
                          size: 24,
                        ),
                      ),
                      Positioned(
                        right: 5,
                        top: 5,
                        child: Container(
                          height: 6,
                          width: 6,
                          decoration: const BoxDecoration(
                            color: Color(0xffEC2727),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            heightSpace,
            Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: blackColor.withOpacity(0.25),
                    blurRadius: 6,
                  )
                ],
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(primary: primaryColor),
                ),
                child: TextField(
                  onTap: () {
                    Navigator.pushNamed(context, SearchScreen.routeName);
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 22,
                    ),
                    hintText: getTranslate(context, 'home.search_destination'),
                    hintStyle: semibold14grey.copyWith(height: 1.6),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  selectCityDialog(context, Size size, List<CityModel> data) {
    return showDialog(
      barrierColor: blackColor.withOpacity(0.3),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, set) {
            return AlertDialog(
              scrollable: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              titlePadding: const EdgeInsets.only(top: fixPadding * 2),
              title: Center(
                child: Text(
                  getTranslate(context, 'home.select_city'),
                  style: medium18black,
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                child: ColumnBuilder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    debugPrint(data[index].toString());
                    if (data.isEmpty) {
                      return const Center(child: Text('NO DATA'));
                    }
                    return ListTile(
                      onTap: () {
                        ref
                            .watch(selectedCityNameProvider.notifier)
                            .update((state) => data[index].title);

                        Navigator.pop(context);
                      },
                      leading: Container(
                        height: size.height * 0.035,
                        width: size.height * 0.035,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          shape: BoxShape.circle,
                          border: ref.watch(selectedCityNameProvider) ==
                                  data[index].title
                              ? Border.all(
                                  color: primaryColor,
                                  width: 8,
                                )
                              : null,
                          boxShadow: [
                            BoxShadow(
                              color: grey94Color.withOpacity(0.5),
                              blurRadius: 5,
                            )
                          ],
                        ),
                      ),
                      minLeadingWidth: 10,
                      title: Text(
                        data[index].title,
                        style: medium16black,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
