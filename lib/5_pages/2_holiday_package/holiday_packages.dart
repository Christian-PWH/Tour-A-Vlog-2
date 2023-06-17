import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/4_home_navigation/2_booking/open_trip.dart';
import 'package:tour_a_vlog/4_home_navigation/2_booking/private_tour.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/category_controller.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/city_controller.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/tour_controller.dart';
import 'package:tour_a_vlog/5_pages/1_detail/detail.dart';
import 'package:tour_a_vlog/5_pages/1_discover_by_categories/discover_by_categories.dart';
import 'package:tour_a_vlog/5_pages/1_package_detail.dart/package_detail.dart';
import 'package:tour_a_vlog/5_pages/1_top_indonesia_destination/top_indonesia_destination.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HolidayPackages extends ConsumerStatefulWidget {
  static const routeName = '/holiday_packages';

  const HolidayPackages({super.key});

  @override
  ConsumerState<HolidayPackages> createState() => _HolidayPackagesState();
}

class _HolidayPackagesState extends ConsumerState<HolidayPackages> {
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
          icon: const Icon(Icons.arrow_back_ios, size: 22, color: whiteColor),
        ),
        titleSpacing: 0,
        title: Text(
          getTranslate(context, 'holiday_package.holiday_package'),
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
        children: [
          discoverByCategoriesList(context, size),
          heightSpace,
          indonesiaDestinationList(context, size),
          heightSpace,
          openTripListView(context, size),
          heightSpace,
          privateTourListView(context, size),
          heightSpace,
        ],
      ),
    );
  }

  discoverByCategoriesList(context, Size size) {
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
                getTranslate(context, 'holiday_package.discover_categories'),
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
                  itemCount: data.length < 5 ? data.length : 5,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: fixPadding),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            DiscoverByCategories.routeName,
                            arguments: data[index].title,
                          );
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

  indonesiaDestinationList(context, Size size) {
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
                      getTranslate(
                          context, 'holiday_package.indonesia_destination'),
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
                              blackColor.withOpacity(0),
                              blackColor.withOpacity(0.02),
                              blackColor.withOpacity(0.07),
                              blackColor.withOpacity(0.1),
                              blackColor.withOpacity(0.2),
                              blackColor.withOpacity(0.5),
                              blackColor.withOpacity(0.6),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          data[index].title,
                          style: semibold18white,
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

  openTripListView(context, Size size) {
    final openTripTours = ref.watch(getTourByTypeProvider(type: 'Open Trip'));
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
                  getTranslate(context, 'open_trip.open_trip'),
                  style: semibold16white.copyWith(
                      color: const Color(0xff333333),
                      fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    OpenTrip.routeName,
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
          child: openTripTours.when(
            data: (data) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                itemCount: data.length < 5 ? data.length : 5,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
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
              );
            },
            error: (error, stackTrace) {
              return const Center(child: Text('Error'));
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
          ),
        )
      ],
    );
  }

  privateTourListView(context, Size size) {
    final privateTours = ref.watch(getTourByTypeProvider(type: 'Private Tour'));
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
                  getTranslate(context, 'private_tour.private_tour'),
                  style: semibold16white.copyWith(
                      color: const Color(0xff333333),
                      fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    PrivateTour.routeName,
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
            child: privateTours.when(
              data: (data) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                  itemCount: data.length < 5 ? data.length : 5,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
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
}
