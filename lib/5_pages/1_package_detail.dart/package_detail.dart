import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/1_common/widgets/column_builder.dart';
import 'package:tour_a_vlog/5_pages/1_review/review.dart';
import 'package:tour_a_vlog/5_pages/1_travel_detail/travel_detail.dart';

class PackageDetail extends StatefulWidget {
  static const routeName = '/packages_detail';

  const PackageDetail({super.key});

  @override
  State<PackageDetail> createState() => _PackageDetailState();
}

class _PackageDetailState extends State<PackageDetail> {
  bool isFavorite = false;

  final daylist = [
    {
      "day": 1,
      "isexpanded": false,
    },
    {
      "day": 2,
      "isexpanded": false,
    },
    {
      "day": 3,
      "isexpanded": false,
    },
    {
      "day": 4,
      "isexpanded": false,
    },
  ];

  final images = [
    "assets/packagedetail/day1.png",
    "assets/packagedetail/day2.png",
    "assets/packagedetail/day3.png",
    "assets/packagedetail/day4.png",
    "assets/packagedetail/day5.png",
  ];
  bool? isExpanded;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: blackColor,
                      content: isFavorite == true
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
              background: Image.asset(
                "assets/packagedetail/Rectangle 138.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                detailInfo(),
                about(),
                heightSpace,
                tourinformation(),
                heightSpace,
                included(size),
                heightSpace,
                transfer(size),
                heightSpace,
                hotelInfo(size),
                heightSpace,
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: bottomNavigationbar(size),
    );
  }

  bottomNavigationbar(Size size) {
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
                child: Text(
                  "\$118 ${getTranslate(context, 'package_detail.per_person')}",
                  style: semibold16black,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          widthSpace,
          widthSpace,
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, TravelDetail.routeName);
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

  hotelInfo(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hotelContainer(size),
        heightSpace,
        daysInfo(size),
      ],
    );
  }

  daysInfo(Size size) {
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
                        "${getTranslate(context, 'package_detail.day')} ${daylist[index]['day']}",
                        style: semibold16black,
                      ),
                      Row(
                        children: [
                          Text(
                            getTranslate(context, 'package_detail.detail'),
                            style: regular14black,
                          ),
                          width5Space,
                          Icon(
                            daylist[index]['isexpanded'] == true
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                          )
                        ],
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
                            const Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 20,
                                  color: grey94Color,
                                ),
                                widthSpace,
                                Text(
                                  "Ubud",
                                  style: regular14black,
                                )
                              ],
                            ),
                            heightSpace,
                            textrow(
                                "Wake up in the morning, have a delicious breakfast at the hotel and get ready and start off the day by visiting the Kintamani Village famous for its Mount Batur viewing point, the latter one is an active volcano. "),
                            heightSpace,
                            textrow(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elitgh Pellentesque faucibus nullam accumsan "),
                            heightSpace,
                            textrow(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elitgh  Pellentesque faucibus nullam accumsan "),
                          ],
                        ),
                      ),
                      heightSpace,
                      SizedBox(
                        height: size.height * 0.13,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: fixPadding),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: fixPadding),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  images[index],
                                  height: size.height * 0.13,
                                  width: size.width * 0.3,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      heightSpace,
                    ],
                  )
                : Container(),
          ],
        );
      },
      itemCount: daylist.length,
    );
  }

  textrow(String text) {
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

  hotelContainer(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, 'package_detail.hotel'),
            style: semibold16black,
          ),
          heightSpace,
          Container(
            padding: const EdgeInsets.all(fixPadding),
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
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    "assets/packagedetail/Rectangle 275.png",
                    width: size.width * 0.36,
                    fit: BoxFit.cover,
                  ),
                ),
                widthSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Pullman King Power",
                        style: medium16black,
                      ),
                      Row(
                        children: [
                          for (int i = 0; i < 5; i++)
                            Icon(
                              Icons.star,
                              size: 18,
                              color: (i < 4) ? starColor : grey94Color,
                            )
                        ],
                      ),
                      const Text(
                        "17 dec - 20 dec",
                        style: medium14primary,
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 18,
                            color: grey94Color,
                          ),
                          width5Space,
                          Expanded(
                            child: Text(
                              "Jalan Pantai, Banjar Pande Mas,Bali, 80361, Indonesia",
                              style: medium12grey94,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  transfer(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, 'package_detail.transfer'),
            style: semibold16black,
          ),
          heightSpace,
          transferwidget(
            size,
            "23.15",
            "6.45",
            "Mumbai",
            "Kuala Lumpur",
            "Fri 16 dec",
            "Sat 17 dec",
          ),
          heightSpace,
          heightSpace,
          transferwidget(
            size,
            "9.45",
            "12.45",
            "Mumbai",
            "Bali (Denpasar)",
            "Sat 17 dec",
            "Sat 17 dec",
          ),
          heightSpace,
          heightSpace,
          cabdetail(size)
        ],
      ),
    );
  }

  transferwidget(Size size, String time1, String time2, String from, String to,
      String tackoffDate, String landdate) {
    return Container(
      padding: const EdgeInsets.all(fixPadding),
      width: double.infinity,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Air India",
            style: semibold16black,
          ),
          heightSpace,
          Row(
            children: [
              Column(
                children: [
                  Text(
                    time1,
                    style: semibold14black,
                  ),
                  Text(
                    from,
                    style: medium12grey94,
                  ),
                  Text(
                    tackoffDate,
                    style: medium12grey94,
                  )
                ],
              ),
              heightSpace,
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        dottedLine(),
                        Container(
                          height: size.height * 0.04,
                          width: size.height * 0.04,
                          margin: const EdgeInsets.symmetric(
                              horizontal: fixPadding / 2),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Icon(
                            Icons.flight_takeoff,
                            size: 20,
                            color: whiteColor,
                          ),
                        ),
                        dottedLine()
                      ],
                    ),
                    height5Space,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 14,
                          color: grey94Color,
                        ),
                        width5Space,
                        Text(
                          '12 hr',
                          style: medium12grey94,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    time2,
                    style: semibold14black,
                  ),
                  Text(
                    to,
                    style: medium12grey94,
                  ),
                  Text(
                    landdate,
                    style: medium12grey94,
                  )
                ],
              )
            ],
          ),
          heightSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslate(context, 'package_detail.view_details'),
                style: medium14primary,
              ),
              Image.asset(
                "assets/packagedetail/air-india-vector-logo-removebg-preview 1.png",
                height: size.height * 0.05,
                fit: BoxFit.cover,
              )
            ],
          )
        ],
      ),
    );
  }

  dottedLine() {
    return Expanded(
      child: DottedBorder(
        padding: EdgeInsets.zero,
        color: primaryColor,
        child: Container(),
      ),
    );
  }

  cabdetail(Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/cabsdetails');
      },
      child: Container(
        padding: const EdgeInsets.all(fixPadding),
        width: double.infinity,
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
        child: Row(
          children: [
            Image.asset(
              "assets/packagedetail/1501139736_1-1-removebg-preview 1.png",
              width: size.width * 0.38,
              fit: BoxFit.cover,
            ),
            widthSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Mercedes C Class",
                    style: medium16black,
                  ),
                  height5Space,
                  Row(
                    children: [
                      const Icon(
                        Icons.airline_seat_recline_normal,
                        color: grey94Color,
                      ),
                      width5Space,
                      Text(
                        "5 ${getTranslate(context, 'package_detail.seater')}",
                        style: medium16grey,
                      )
                    ],
                  ),
                  height5Space,
                  Row(
                    children: [
                      for (int i = 0; i < 5; i++)
                        Icon(
                          Icons.star,
                          size: 18,
                          color: (i < 4) ? starColor : grey94Color,
                        )
                    ],
                  ),
                  height5Space,
                  const Text(
                    "Bali airpot - hotel",
                    style: medium14grey94,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  included(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, 'package_detail.included'),
            style: semibold16black,
          ),
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              includeditem(size, "assets/packagedetail/raphael_plane.png",
                  getTranslate(context, 'package_detail.flight')),
              divider(size),
              includeditem(size, "assets/packagedetail/dashicons_car.png",
                  getTranslate(context, 'package_detail.transport')),
              divider(size),
              includeditem(
                  size,
                  "assets/packagedetail/healthicons_hot-meal.png",
                  getTranslate(context, 'package_detail.meals')),
              divider(size),
              includeditem(size, "assets/packagedetail/bxs_hotel.png",
                  getTranslate(context, 'package_detail.hotel')),
              divider(size),
              includeditem(size, "assets/packagedetail/Glyph_ undefined.png",
                  getTranslate(context, 'package_detail.activity')),
            ],
          )
        ],
      ),
    );
  }

  includeditem(Size size, String icon, String text) {
    return Column(
      children: [
        Image.asset(
          icon,
          height: size.height * 0.05,
          fit: BoxFit.cover,
        ),
        Text(
          text,
          style: medium14black,
        ),
      ],
    );
  }

  divider(Size size) {
    return Container(
      height: size.height * 0.08,
      color: const Color(0xffd9d9d9),
      width: 2,
    );
  }

  tourinformation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, 'package_detail.tour_information'),
            style: semibold16black,
          ),
          heightSpace,
          informationText(getTranslate(context, 'package_detail.duration'),
              "5 ${getTranslate(context, 'package_detail.days')}, 4 ${getTranslate(context, 'package_detail.nights')}"),
          height5Space,
          informationText(getTranslate(context, 'package_detail.start_point'),
              "Ngurah Rai International Airport"),
          height5Space,
          informationText(getTranslate(context, 'package_detail.end_point'),
              "Ngurah Rai International Airport"),
        ],
      ),
    );
  }

  informationText(String firstText, String secondText) {
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

  about() {
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
          const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque faucibus nullam accumsan cras nunc viverra pharetra. Natoque blandit pretium, molestie enim, vel. Eget donec arcu vitae aliquet. Hac quis tortor erat augue. Et orci, sit enim lectus. Neque sem quis porta id maecenas ",
            style: medium14grey94,
          )
        ],
      ),
    );
  }

  detailInfo() {
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
                const Text(
                  "Bali Honymoon Package",
                  style: semibold18primary,
                ),
                height5Space,
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, ReviewScreen.routeName);
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
                              color: (i < 4) ? starColor : grey94Color,
                            )
                        ],
                      ),
                      height5Space,
                      Text(
                        "684 ${getTranslate(context, 'package_detail.review')}",
                        style: medium14grey94,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                vertical: fixPadding / 3, horizontal: fixPadding),
            decoration: BoxDecoration(
              color: whiteColor,
              border: Border.all(color: primaryColor),
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.2),
                  blurRadius: 5,
                )
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              "4N/5D",
              style: medium14primary,
            ),
          ),
        ],
      ),
    );
  }
}
