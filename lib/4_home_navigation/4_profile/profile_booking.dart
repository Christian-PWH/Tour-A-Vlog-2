import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/5_flight_ticket_history/flight_ticket_history.dart';
import 'package:tour_a_vlog/5_pages/5_flight_ticket_ongoing/flight_ticket_ongoing.dart';
import 'package:tour_a_vlog/5_pages/5_holiday_history/holiday_history.dart';
import 'package:tour_a_vlog/5_pages/5_holiday_ongoing/holiday_ongoing.dart';
import 'package:tour_a_vlog/5_pages/5_hotel_booking_history/hotel_booking_history.dart';
import 'package:tour_a_vlog/5_pages/5_hotel_booking_ongoning/hotel_booking_ongoing.dart';

final flightsongoing = [
  {
    "id": 0,
    "tackoffpalce": "Jakarta",
    "tackoffdate": "Fri 16 dec",
    "tackofftime": "23.15",
    "landplace": "Bali",
    "landdate": "Sat 17 dec",
    "landtime": "6.45",
  },
  {
    "id": 1,
    "tackoffpalce": "Surabaya",
    "tackoffdate": "Sat 17 dec",
    "tackofftime": "9.45",
    "landplace": "Bali (Denpasar)",
    "landdate": "Sat 17 dec",
    "landtime": "12.45",
  },
];

final hotelOngoing = [
  {
    "image": "assets/thingstodo/hotel1.png",
    "name": "Pullman's King Power",
  },
  {
    "image": "assets/thingstodo/hotel6.png",
    "name": "Royal Kamuela Villas",
  },
];

final holidayOngoingpackages = [
  {
    "name": "Experiance Bali in your Budgets",
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
    {"title": "Flight booking", "name": "Flight"},
    {"title": "Train booking", "name": ""},
    {"title": "Cab booking", "name": ""},
    {"title": "Hotel booking", "name": "Hotel"},
    {"title": "Holiday package", "name": "Holiday package"},
  ];

  final flightsHistory = [
    {
      "tackoffpalce": "Jakarta",
      "tackoffdate": "Fri 16 dec",
      "tackofftime": "23.15",
      "landplace": "Surabaya",
      "landdate": "Sat 17 dec",
      "landtime": "6.45",
    },
    {
      "tackoffpalce": "Mumbai",
      "tackoffdate": "Jakarta",
      "tackofftime": "9.45",
      "landplace": "Bali (Denpasar)",
      "landdate": "Sat 17 dec",
      "landtime": "12.45",
    },
    {
      "tackoffpalce": "Bali",
      "tackoffdate": "Fri 16 dec",
      "tackofftime": "9.45",
      "landplace": "Surabaya",
      "landdate": "Sat 20 dec",
      "landtime": "12.45",
    },
    {
      "tackoffpalce": "Surabaya",
      "tackoffdate": "Sat 25 dec",
      "tackofftime": "9.45",
      "landplace": "Bali (Denpasar)",
      "landdate": "Sat 25dec",
      "landtime": "12.45",
    },
  ];

  final hotelHistory = [
    {
      "image": "assets/thingstodo/hotel2.png",
      "name": "Hard rock hotel bali",
    },
    {
      "image": "assets/thingstodo/hotel3.png",
      "name": "Royal Kamuela Villas",
    },
    {
      "image": "assets/thingstodo/hotel4.png",
      "name": "Pullman's King Power",
    },
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

  int flightSelected = 0;
  int hotelSelected = 0;
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
          if (selectedIndex == 0) flightTabView(size),
          if (selectedIndex == 3) hotelTabView(size),
          if (selectedIndex == 4) holidayTabView(size),
        ],
      ),
    );
  }

  flightTabView(Size size) {
    return Expanded(
      child: Column(
        children: [
          flightTabContainer(size),
          if (flightSelected == 0) flightongoing(size),
          if (flightSelected == 1) flightsHistroy(size),
        ],
      ),
    );
  }

  hotelTabView(Size size) {
    return Expanded(
      child: Column(
        children: [
          hotelTabContainer(size),
          if (hotelSelected == 0) hotelOngoingList(size),
          if (hotelSelected == 1) hotelHistroyList(size),
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
      child: holidayOngoingpackages.isEmpty
          ? emptyBooking(size)
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                  horizontal: fixPadding * 2, vertical: fixPadding),
              itemCount: holidayOngoingpackages.length,
              itemBuilder: (context, index) {
                return holidaylistContent(
                    size,
                    holidayOngoingpackages[index]['image'],
                    holidayOngoingpackages[index]['name'],
                    holidayOngoingpackages[index]['days'], () {
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
          return holidaylistContent(
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

  holidaylistContent(Size size, image, name, days, Function() onTap) {
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

  hotelHistroyList(Size size) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2, vertical: fixPadding),
        itemCount: hotelHistory.length,
        itemBuilder: (context, index) {
          return hotellistContent(
            size,
            () {
              Navigator.pushNamed(context, HotelBookingHistory.routeName);
            },
            hotelHistory[index]['image'],
            hotelHistory[index]['name'],
          );
        },
      ),
    );
  }

  hotelOngoingList(Size size) {
    return Expanded(
      child: hotelOngoing.isEmpty
          ? emptyBooking(size)
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                  horizontal: fixPadding * 2, vertical: fixPadding),
              itemCount: hotelOngoing.length,
              itemBuilder: (context, index) {
                return hotellistContent(
                  size,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HotelBookingOngoing(
                          index: index,
                        ),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  hotelOngoing[index]['image'],
                  hotelOngoing[index]['name'],
                );
              },
            ),
    );
  }

  hotellistContent(Size size, Function() onTap, image, name) {
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
            )
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                image,
                width: size.width * 0.35,
                fit: BoxFit.cover,
              ),
            ),
            widthSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: medium16black,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    '15 jan 2022',
                    style: regular14black,
                  ),
                  Text(
                    "\$56${getTranslate(context, 'booking.per_night')}",
                    style: regular16black,
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 18,
                        color: grey94Color,
                      ),
                      Expanded(
                        child: Text(
                          "Jalan Pantai, Banjarpand Mas,Bali, 80361, Indonesia",
                          style: medium12grey94,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  Text(
                    getTranslate(context, 'booking.view_detail'),
                    style: medium16primary,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  flightongoing(Size size) {
    return Expanded(
      child: flightsongoing.isEmpty
          ? emptyBooking(size)
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: flightsongoing.length,
              itemBuilder: (context, index) {
                return flightlistContent(
                  context,
                  index,
                  size,
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FlightTicketOngoing(
                          index: index,
                        ),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  flightsongoing[index]['tackofftime'].toString(),
                  flightsongoing[index]['tackoffpalce'].toString(),
                  flightsongoing[index]['tackoffdate'].toString(),
                  flightsongoing[index]['landtime'].toString(),
                  flightsongoing[index]['landplace'].toString(),
                  flightsongoing[index]['landdate'].toString(),
                );
              },
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

  flightsHistroy(Size size) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: flightsHistory.length,
        itemBuilder: (context, index) {
          return flightlistContent(
            context,
            index,
            size,
            () {
              Navigator.pushNamed(context, FlightTicketHistory.routeName);
            },
            flightsHistory[index]['tackofftime'].toString(),
            flightsHistory[index]['tackoffpalce'].toString(),
            flightsHistory[index]['tackoffdate'].toString(),
            flightsHistory[index]['landtime'].toString(),
            flightsHistory[index]['landplace'].toString(),
            flightsHistory[index]['landdate'].toString(),
          );
        },
      ),
    );
  }

  flightlistContent(BuildContext context, int index, Size size,
      Function() onTap, time1, time2, palce1, palce2, date1, date2) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(fixPadding),
        margin: const EdgeInsets.symmetric(vertical: fixPadding),
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Air India",
                  style: semibold16black,
                ),
              ],
            ),
            heightSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      time1,
                      style: semibold14black,
                    ),
                    Text(
                      palce1,
                      style: medium12grey94,
                    ),
                    Text(
                      date1,
                      style: medium12grey94,
                    )
                  ],
                ),
                width5Space,
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
                          dottedLine(),
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
                width5Space,
                Column(
                  children: [
                    Text(
                      time2,
                      style: semibold14black,
                    ),
                    Text(
                      palce2,
                      style: medium12grey94,
                    ),
                    Text(
                      date2,
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
                  getTranslate(context, 'booking.view_detail'),
                  style: regular12black,
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
      ),
    );
  }

  flightTabContainer(Size size) {
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
                  flightSelected = 0;
                });
              },
              child: Container(
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: flightSelected == 0 ? primaryColor : whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: grey94Color.withOpacity(0.5),
                      blurRadius: 5,
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Text(getTranslate(context, 'booking.ongoing'),
                    style:
                        flightSelected == 0 ? semibold16white : semibold16grey),
              ),
            ),
          ),
          widthSpace,
          widthSpace,
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  flightSelected = 1;
                });
              },
              child: Container(
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: flightSelected == 1 ? primaryColor : whiteColor,
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
                  style: flightSelected == 1 ? semibold16white : semibold16grey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  hotelTabContainer(Size size) {
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
                  hotelSelected = 0;
                });
              },
              child: Container(
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: hotelSelected == 0 ? primaryColor : whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: grey94Color.withOpacity(0.5),
                      blurRadius: 5,
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Text(getTranslate(context, 'booking.ongoing'),
                    style:
                        hotelSelected == 0 ? semibold16white : semibold16grey),
              ),
            ),
          ),
          widthSpace,
          widthSpace,
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  hotelSelected = 1;
                });
              },
              child: Container(
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: hotelSelected == 1 ? primaryColor : whiteColor,
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
                  style: hotelSelected == 1 ? semibold16white : semibold16grey,
                ),
              ),
            ),
          )
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
                  Text(
                    tabList[index]['name'].toString(),
                    style: medium16grey,
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

  dottedLine() {
    return Expanded(
        child: DottedBorder(
      padding: EdgeInsets.zero,
      color: primaryColor,
      dashPattern: const [2, 3.5],
      child: Container(),
    ));
  }
}
