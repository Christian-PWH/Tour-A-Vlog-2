import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/5_holiday_history/holiday_history.dart';
import 'package:tour_a_vlog/5_pages/5_holiday_ongoing/holiday_ongoing.dart';

final holidayOngoingPackages = [
  {
    "name": "Experience Bali in your Budgets",
    "days": "4N/5D",
    "image": "assets/packages/package1.png",
  },
];

class ProfileBookingScreen extends StatefulWidget {
  static const routeName = '/profile_booking';

  const ProfileBookingScreen({super.key});

  @override
  State<ProfileBookingScreen> createState() => _ProfileBookingScreenState();
}

class _ProfileBookingScreenState extends State<ProfileBookingScreen> {
  int selectedIndex = 0;

  final tabList = [
    {"title": "Holiday package", "name": "Holiday package"},
  ];

  final holidayHistoryPackages = [
    {
      "name": "Experiance Bali in your Budgets",
      "days": "4N/5D",
      "image": "assets/packages/package1.png",
    },
    {
      "name": "Bali Honeymoon package",
      "days": "4N/5D",
      "image": "assets/similarplace/Rectangle 138.png",
    },
  ];

  String? appbarName;
  int holidaySelected = 0;

  @override
  void initState() {
    appbarName = tabList[0]['title'].toString();
    super.initState();
  }

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
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 22,
            color: whiteColor,
          ),
        ),
        titleSpacing: 0,
        title: Text(
          appbarName.toString(),
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
      body: Column(
        children: [
          tabs(size),
          if (selectedIndex == 0) holidayTabView(size),
        ],
      ),
    );
  }

  holidayTabView(Size size) {
    return Expanded(
      child: Column(
        children: [
          holidayTabContainer(size),
          if (holidaySelected == 0) holidayOngoingList(size),
          if (holidaySelected == 1) holidayHistoryList(size),
        ],
      ),
    );
  }

  holidayOngoingList(Size size) {
    return Expanded(
      child: holidayOngoingPackages.isEmpty
          ? emptyBooking(size)
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                  horizontal: fixPadding * 2, vertical: fixPadding),
              itemCount: holidayOngoingPackages.length,
              itemBuilder: (context, index) {
                return holidayListContent(
                    size,
                    holidayOngoingPackages[index]['image'],
                    holidayOngoingPackages[index]['name'],
                    holidayOngoingPackages[index]['days'], () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HolidayOngoing(
                        index: index,
                      ),
                    ),
                  ).then((value) {
                    setState(() {});
                  });
                });
              },
            ),
    );
  }

  holidayHistoryList(Size size) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2, vertical: fixPadding),
        itemCount: holidayHistoryPackages.length,
        itemBuilder: (context, index) {
          return holidayListContent(
              size,
              holidayHistoryPackages[index]['image'],
              holidayHistoryPackages[index]['name'],
              holidayHistoryPackages[index]['days'], () {
            Navigator.pushNamed(context, HolidayHistory.routeName);
          });
        },
      ),
    );
  }

  holidayListContent(Size size, image, name, days, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(fixPadding),
        margin: const EdgeInsets.symmetric(vertical: fixPadding),
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
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                image,
                height: size.height * 0.17,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            height5Space,
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style:
                            medium16black.copyWith(fontWeight: FontWeight.w500),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "\$11500",
                          style: semibold16grey,
                          children: [
                            TextSpan(
                              text: getTranslate(context, 'booking.per_person'),
                              style: medium14grey94.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        getTranslate(context, 'booking.view_detail'),
                        style: medium14primary,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: fixPadding, vertical: fixPadding / 2),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3),
                        blurRadius: 5,
                      )
                    ],
                    border: Border.all(color: primaryColor),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    days,
                    style: medium14primary,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  emptyBooking(Size size) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/bottomavigation/fluent_ticket-diagonal-16-filled.png",
            color: greyColor,
            height: size.height * 0.05,
            width: size.height * 0.05,
            fit: BoxFit.cover,
          ),
          height5Space,
          Text(
            "No booking yet",
            style: medium18black.copyWith(color: grey94Color),
          ),
        ],
      ),
    );
  }

  holidayTabContainer(Size size) {
    return Padding(
      padding: const EdgeInsets.only(
          top: fixPadding,
          left: fixPadding * 2,
          right: fixPadding * 2,
          bottom: fixPadding),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  holidaySelected = 0;
                });
              },
              child: Container(
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: holidaySelected == 0 ? primaryColor : whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: grey94Color.withOpacity(0.5),
                      blurRadius: 5,
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Text(getTranslate(context, 'booking.ongoing'),
                    style: holidaySelected == 0
                        ? semibold16white
                        : semibold16grey),
              ),
            ),
          ),
          widthSpace,
          widthSpace,
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  holidaySelected = 1;
                });
              },
              child: Container(
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: holidaySelected == 1 ? primaryColor : whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: grey94Color.withOpacity(0.5),
                      blurRadius: 5,
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  getTranslate(context, 'booking.history'),
                  style:
                      holidaySelected == 1 ? semibold16white : semibold16grey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  tabs(Size size) {
    return SizedBox(
      height: size.height * 0.075,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: fixPadding),
        scrollDirection: Axis.horizontal,
        itemCount: tabList.length,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(fixPadding),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  appbarName = tabList[index]['title'].toString();
                });
              },
              child: Column(
                children: [
                  Flexible(
                    child: Text(
                      tabList[index]['name'].toString(),
                      style: medium16grey,
                    ),
                  ),
                  height5Space,
                  selectedIndex == index
                      ? Container(
                          height: 2,
                          width: selectedIndex == (tabList.length - 1)
                              ? size.width * 0.2
                              : size.width * 0.09,
                          color: primaryColor)
                      : Container(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
