import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/1_packages/packages.dart';

class HolidayPackages extends StatelessWidget {
  static const routeName = '/holiday_packages';
  HolidayPackages({super.key});

  final discoverByInterest = [
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

  final hotAndNew = [
    {
      "image": "assets/home/latestCollection1.png",
      "name": "Raja Ampat",
    },
    {
      "image": "assets/home/h&n1.png",
      "name": "Bali",
    },
    {
      "image": "assets/home/latestCollection2.png",
      "name": "Surabaya",
    },
    {
      "image": "assets/home/h&n2.png",
      "name": "Jakarta",
    },
  ];

  final internationalDestination = [
    {
      "image": "assets/home/destination1.png",
      "name": "Dubai",
    },
    {
      "image": "assets/home/destination2.png",
      "name": "Tokyo",
    },
    {
      "image": "assets/home/destination3.png",
      "name": "Hong Kong",
    },
    {
      "image": "assets/home/destination5.png",
      "name": "Bankok",
    },
  ];

  final indonesiaDestination = [
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
          discoverbyinterestList(size, context),
          hotAndnewList(size, context),
          internationalDestinationList(size, context),
          indianDestinationList(size, context),
          heightSpace,
          heightSpace,
        ],
      ),
    );
  }

  indianDestinationList(Size size, context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: fixPadding * 2, vertical: fixPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(getTranslate(context, 'holiday_package.top_destination'),
                  style: semibold16black),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.23,
          width: double.maxFinite,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding),
            itemCount: indonesiaDestination.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Packages.routeName);
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
                            indonesiaDestination[index]['image'].toString())),
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
                      indonesiaDestination[index]['name'].toString(),
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

  discoverbyinterestList(Size size, context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: fixPadding * 2, vertical: fixPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(getTranslate(context, 'holiday_package.discover_intrest'),
                  style: semibold16black),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.14,
          width: double.maxFinite,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding),
            itemCount: discoverByInterest.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Packages.routeName);
                  },
                  child: Column(
                    children: [
                      Container(
                        height: size.height * 0.09,
                        width: size.height * 0.09,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              discoverByInterest[index]['image'].toString(),
                            ),
                          ),
                        ),
                      ),
                      height5Space,
                      Text(
                        discoverByInterest[index]['name'].toString(),
                        style: regular14black,
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

  hotAndnewList(Size size, context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslate(context, 'holiday_package.hot_new'),
                style: semibold16black,
              ),
            ],
          ),
        ),
        heightSpace,
        SizedBox(
          height: size.height * 0.29,
          width: double.maxFinite,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding),
            itemCount: hotAndNew.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Packages.routeName);
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
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10)),
                        child: Image.asset(
                          hotAndNew[index]['image'].toString(),
                          height: size.height * 0.15,
                          width: size.width * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: fixPadding / 2, horizontal: fixPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                hotAndNew[index]['name'].toString(),
                                overflow: TextOverflow.ellipsis,
                                style: medium16black,
                              ),
                              Text(
                                getTranslate(
                                    context, 'holiday_package.staring_from'),
                                style: medium12grey94,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "\$1500${getTranslate(context, 'holiday_package.per_person')}",
                                style: medium14primary,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
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

  internationalDestinationList(Size size, context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: fixPadding * 2, vertical: fixPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslate(
                    context, 'holiday_package.international_deationation'),
                style: semibold16black,
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.23,
          width: double.maxFinite,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding),
            itemCount: internationalDestination.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Packages.routeName);
                },
                child: Container(
                  width: size.width * 0.4,
                  margin: const EdgeInsets.symmetric(
                      horizontal: fixPadding, vertical: fixPadding / 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(internationalDestination[index]
                                ['image']
                            .toString())),
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
                      internationalDestination[index]['name'].toString(),
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
}
