// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/currency_formatter.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/models/tour_model.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/1_common/widgets/column_builder.dart';
import 'package:tour_a_vlog/1_common/widgets/show_snackbar.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/favorite_controller.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/review_controller.dart';
import 'package:tour_a_vlog/5_pages/1_review/review.dart';
import 'package:tour_a_vlog/5_pages/1_travel_detail/travel_detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PackageDetail extends ConsumerStatefulWidget {
  static const routeName = '/packages_detail';

  final TourModel tour;

  const PackageDetail({super.key, required this.tour});

  @override
  ConsumerState<PackageDetail> createState() => _PackageDetailState();
}

class _PackageDetailState extends ConsumerState<PackageDetail> {
  TourModel get tour => widget.tour;

  CarouselController imageController = CarouselController();

  final daylist = [
    {
      "day": 1,
      "isexpanded": false,
    },
    {
      "day": 2,
      "isexpanded": false,
    },
  ];

  final images = [
    "assets/packagedetail/day1.png",
    "assets/packagedetail/day2.png",
    "assets/packagedetail/day3.png",
  ];

  bool? isExpanded;

  @override
  Widget build(BuildContext context) {
    final isFavorite = ref.watch(isFavoriteProvider(tourId: tour.id));

    debugPrint(tour.toString());

    final size = MediaQuery.of(context).size;
    List<String> packageImage = tour.image;
    bool multipleImage = false;
    if (packageImage.length > 1) {
      multipleImage = true;
    }
    return Scaffold(
      backgroundColor: whiteColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: false,
            backgroundColor: primaryColor,
            expandedHeight: size.height * 0.3,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 22,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  if (isFavorite) {
                    final errMsg = await ref
                        .watch(favoriteControllerProvider.notifier)
                        .remove(tour.id);
                    if (errMsg.isEmpty) return;
                    showSnackBar(context, Icons.cancel_outlined, Colors.red,
                        errMsg.toString(), Colors.red);
                  } else {
                    final errMsg = await ref
                        .watch(favoriteControllerProvider.notifier)
                        .save(tour.id);
                    if (errMsg.isEmpty) return;
                    showSnackBar(context, Icons.cancel_outlined, Colors.red,
                        errMsg.toString(), Colors.red);
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: blackColor,
                      content: isFavorite == false
                          ? Text(getTranslate(
                              context, 'favorite_add_remove.added_favorites'))
                          : Text(getTranslate(context,
                              'favorite_add_remove.removed_favorites')),
                      duration: const Duration(milliseconds: 1500),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 22,
                  color: isFavorite ? Colors.red : null,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  size: 22,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: multipleImage
                  ? CarouselSlider(
                      carouselController: imageController,
                      options: CarouselOptions(
                        autoPlay: multipleImage ? true : false,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 500),
                        autoPlayInterval: const Duration(seconds: 2),
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        scrollDirection: Axis.horizontal,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        viewportFraction: 0.6,
                        initialPage: 0,
                      ),
                      items: imageItemSlider(),
                    )
                  : Image.network(
                      packageImage[0],
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
          SliverList(
            delegate: SliverChildListDelegate(
              [
                detailInfo(tour),
                about(tour),
                heightSpace,
                activityInfo(tour, size),
                heightSpace,
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: bottomNavigationBar(tour, size),
    );
  }

  List<Widget> imageItemSlider() {
    if (tour.image.isNotEmpty) {
      return tour.image
          .map(
            (item) => Image.network(
              item,
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
          )
          .toList();
    }
    return images
        .map(
          (item) => Image.asset(
            item,
            fit: BoxFit.cover,
          ),
        )
        .toList();
  }

  Widget detailInfo(TourModel tour) {
    final reviews = ref.watch(getReviewByTourIdProvider(tourId: tour.id));

    return reviews.when(
      data: (data) {
        final int totalReviews = data.length;
        int averageStarRound = 0;
        // Round of zero and divided by zero is infinity
        if (totalReviews != 0) {
          averageStarRound =
              (data.fold(0.0, (prev, e) => prev + e.star) / totalReviews)
                  .round();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: fixPadding,
            horizontal: fixPadding * 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tour.title,
                      style: semibold18primary,
                    ),
                    height5Space,
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ReviewScreen.routeName,
                          arguments: ReviewScreenArguments(
                            tourId: tour.id,
                            canEdit: false,
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              for (int i = 0; i < 5; i++)
                                Icon(
                                  Icons.star,
                                  size: 18,
                                  color: (i < averageStarRound)
                                      ? starColor
                                      : grey94Color,
                                )
                            ],
                          ),
                          height5Space,
                          Text(
                            "$totalReviews ${getTranslate(context, 'package_detail.review')}",
                            style: medium14grey94,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: tour.status2 == "deal" ? true : false,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: fixPadding / 3, horizontal: fixPadding),
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.2),
                        blurRadius: 5,
                      )
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "${tour.percent}%",
                    style: medium14primary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stackTrace) {
        return const Center(child: Text('Error'));
      },
    );
  }

  Widget about(TourModel tour) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, 'package_detail.about_tour'),
            style: semibold16black,
          ),
          height5Space,
          Text(
            tour.about ?? '',
            style: medium14grey94,
          ),
        ],
      ),
    );
  }

  Widget activityInfo(TourModel tour, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // hotelContainer(size),
        heightSpace,
        daysInfo(tour, size),
      ],
    );
  }

  Widget daysInfo(TourModel tour, Size size) {
    List<String> customizationForDays = tour.customizationForDays;
    return ColumnBuilder(
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  isExpanded = daylist[index]['isexpanded'] as bool;
                  daylist[index]['isexpanded'] = !isExpanded!;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: fixPadding),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: fixPadding * 2, vertical: fixPadding),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: grey94Color.withOpacity(0.5),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${getTranslate(context, 'package_detail.day')} ${index + 1}",
                        style: semibold16black,
                      ),
                      Icon(
                        daylist[index]['isexpanded'] == true
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                      )
                    ],
                  ),
                ),
              ),
            ),
            daylist[index]['isexpanded'] == true
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: fixPadding * 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 20,
                                  color: grey94Color,
                                ),
                                widthSpace,
                                Text(
                                  tour.city,
                                  style: regular14black,
                                )
                              ],
                            ),
                            heightSpace,
                            textRow(
                              customizationForDays[index],
                            ),
                          ],
                        ),
                      ),
                      heightSpace,
                    ],
                  )
                : Container(),
          ],
        );
      },
      itemCount: customizationForDays.length,
    );
  }

  Widget textRow(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 4,
          width: 4,
          margin: const EdgeInsets.only(left: 5, top: 10),
          decoration:
              const BoxDecoration(color: blackColor, shape: BoxShape.circle),
        ),
        widthSpace,
        Expanded(
          child: Text(
            text,
            style: regular12black,
          ),
        )
      ],
    );
  }

  Widget informationText(String firstText, String secondText) {
    return RichText(
      text: TextSpan(
        text: firstText,
        style: medium12grey94.copyWith(
            color: blackColor, fontWeight: FontWeight.w400),
        children: [
          TextSpan(
            text: " : ",
            style: medium12grey94.copyWith(
                color: blackColor, fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: secondText,
            style: medium12grey94.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget bottomNavigationBar(TourModel tour, Size size) {
    return Container(
      height: size.height * 0.1,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2, vertical: fixPadding * 1.2),
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.5),
            blurRadius: 5,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: fixPadding / 2),
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
              alignment: Alignment.center,
              child: FittedBox(
                child: tour.status2 == "deal"
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            CurrencyFormat.convertToIdr(
                                double.parse(tour.price), 2),
                            // "Rp. ${tour.price}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: grey94Color,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            "${CurrencyFormat.convertToIdr(double.parse(tour.newprice ?? "0"), 2)}/${getTranslate(context, 'package_detail.per_person')}",
                            style: semibold16black,
                          ),
                        ],
                      )
                    : Text(
                        "Rp. ${tour.price}",
                        style: semibold16black,
                      ),
              ),
            ),
          ),
          widthSpace,
          widthSpace,
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TravelDetail.routeName,
                  arguments: tour,
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: fixPadding / 2),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: gradient,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: grey94Color.withOpacity(0.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  getTranslate(context, 'package_detail.book_now'),
                  style: semibold16white,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
