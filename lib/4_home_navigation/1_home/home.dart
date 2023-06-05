import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/1_common/widgets/column_builder.dart';
import 'package:tour_a_vlog/5_pages/1_detail/detail.dart';
import 'package:tour_a_vlog/5_pages/1_international_destination/international_destination.dart';
import 'package:tour_a_vlog/5_pages/1_latest_collection/latest_collection.dart';
import 'package:tour_a_vlog/5_pages/1_notification/notification.dart';
import 'package:tour_a_vlog/5_pages/1_search/search.dart';
import 'package:tour_a_vlog/5_pages/1_top_indonesia_destination/top_indonesia_destination.dart';

final cityList = [
  {"name": "Medan", "id": 0},
  {"name": "Jakarta", "id": 1},
  {"name": "Bandung", "id": 3},
  {"name": "Semarang", "id": 4},
  {"name": "Surabaya", "id": 5},
  {"name": "Yogyakarta", "id": 6},
  {"name": "Bali", "id": 7},
  {"name": "Pontianak", "id": 8},
  {"name": "Samarinda", "id": 9},
  {"name": "Manado", "id": 10},
  {"name": "Makassar", "id": 11},
  {"name": "Ambon", "id": 12},
  {"name": "NTB", "id": 13},
  {"name": "NTT", "id": 14},
];

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCityName = cityList[1]['name'].toString();

  final latestCollectionList = [
    {
      "image": "assets/home/latestCollection1.png",
      "name": "Stay like a celebrity at 5 bali resorts",
      "places": 5,
    },
    {
      "image": "assets/home/latestCollection2.png",
      "name": "Hill hideaways for summer break",
      "places": 4,
    },
    {
      "image": "assets/home/latestCollection3.png",
      "name": "Luxury  villas with stunning pools",
      "places": 8,
    },
    {
      "image": "assets/home/latestCollection4.png",
      "name": "Most Booked destination",
      "places": 5,
    },
    {
      "image": "assets/home/latestCollection5.png",
      "name": "Top indonesia destination for family trip",
      "places": 5,
    },
  ];

  final indianDestination = [
    {
      "image": "assets/home/indiandestination1.png",
      "name": "Surabaya",
    },
    {
      "image": "assets/home/indiandestination2.png",
      "name": "NTT",
    },
    {
      "image": "assets/home/indiandestination3.png",
      "name": "Papua",
    },
    {
      "image": "assets/home/indiandestination4.png",
      "name": "Bandung",
    },
    {
      "image": "assets/home/indiandestination5.png",
      "name": "Yogyakarta",
    },
  ];

  final discoverByIntrest = [
    {
      "image": "assets/home/discover1.png",
      "name": "Beach",
    },
    {
      "image": "assets/home/discover2.png",
      "name": "Honeymoon",
    },
    {
      "image": "assets/home/discover3.png",
      "name": "Mountain",
    },
    {
      "image": "assets/home/discover4.png",
      "name": "Romantic",
    },
    {
      "image": "assets/home/discover5.png",
      "name": "Attractive",
    },
    {
      "image": "assets/home/discover6.png",
      "name": "Hill",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          topImageContainer(size, context),
          bottomView(size),
        ],
      ),
    );
  }

  bottomView(Size size) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(
            left: 0.0, right: 0.0, top: 0.0, bottom: fixPadding),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        children: [
          latestCollectionListView(size),
          indonesiaDestinationList(size),
          discoverByInterestList(size),
        ],
      ),
    );
  }

  discoverByInterestList(Size size) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: fixPadding * 2, vertical: fixPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                getTranslate(context, 'home.discover_intrest'),
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
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding),
            itemCount: discoverByIntrest.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.1,
                        width: size.height * 0.1,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              discoverByIntrest[index]['image'].toString(),
                            ),
                          ),
                        ),
                      ),
                      height5Space,
                      Text(
                        discoverByIntrest[index]['name'].toString(),
                        style: regular16black,
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
  }

  indonesiaDestinationList(Size size) {
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
                      context, TopIndonesiaDestination.routeName);
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
            itemCount: indianDestination.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, DetailScreen.routeName);
                },
                child: Container(
                  width: size.width * 0.4,
                  margin: const EdgeInsets.symmetric(
                      horizontal: fixPadding, vertical: fixPadding / 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            indianDestination[index]['image'].toString())),
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
                      indianDestination[index]['name'].toString(),
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
  }

  latestCollectionListView(Size size) {
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
                  getTranslate(context, 'home.latest_collection'),
                  style: semibold16white.copyWith(
                      color: const Color(0xff333333),
                      fontWeight: FontWeight.w600),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, LatestCollection.routeName);
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
            itemCount: latestCollectionList.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                      context, InternationalDestination.routeName);
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
                          child: Image.asset(
                            latestCollectionList[index]['image'].toString(),
                            width: size.width * 0.4,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: fixPadding / 2, horizontal: fixPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              latestCollectionList[index]['name'].toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: medium14black33,
                            ),
                            Text(
                              "${latestCollectionList[index]['places']} ${getTranslate(context, 'home.places')}",
                              style: medium14grey94,
                            )
                          ],
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
  }

  topImageContainer(Size size, BuildContext context) {
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
                          getTranslate(context, 'home.travel_text'),
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
                          GestureDetector(
                            onTap: () {
                              selectCityDialog(context, size);
                            },
                            child: Row(
                              children: [
                                Text(
                                  selectedCityName,
                                  style: semibold14white,
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: whiteColor,
                                )
                              ],
                            ),
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

  selectCityDialog(BuildContext context, Size size) {
    return showDialog(
      barrierColor: blackColor.withOpacity(0.3),
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, set) {
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
                itemCount: cityList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      setState(() {
                        set(() {
                          selectedCityName = cityList[index]['name'].toString();
                        });
                      });
                      Navigator.pop(context);
                    },
                    leading: Container(
                      height: size.height * 0.035,
                      width: size.height * 0.035,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        shape: BoxShape.circle,
                        border: selectedCityName == cityList[index]['name']
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
                      cityList[index]['name'].toString(),
                      style: medium16black,
                    ),
                  );
                },
              ),
            ),
          );
        });
      },
    );
  }
}
