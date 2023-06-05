import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/2_flights_detail/flight_detail.dart';

class SelectFlights extends StatefulWidget {
  static const routeName = '/select_flights';

  const SelectFlights({super.key});

  @override
  State<SelectFlights> createState() => _SelectFlightsState();
}

class _SelectFlightsState extends State<SelectFlights>
    with SingleTickerProviderStateMixin {
  final fastestFlights = [
    {
      "name": "Air India",
    },
    {
      "name": "IndiGo",
    },
    {
      "name": "SpiceJet",
    },
    {
      "name": "Go First",
    },
    {
      "name": "Alliance Air",
    },
    {
      "name": "Air India",
    },
  ];

  final cheapestFlights = [
    {
      "name": "Go First",
    },
    {
      "name": "Alliance Air",
    },
    {
      "name": "Air India",
    },
    {
      "name": "IndiGo",
    },
    {
      "name": "SpiceJet",
    },
    {
      "name": "Air India",
    },
  ];

  final mayPreferFlights = [
    {
      "name": "SpiceJet",
    },
    {
      "name": "Air India",
    },
    {
      "name": "Go First",
    },
    {
      "name": "Alliance Air",
    },
    {
      "name": "Air India",
    },
    {
      "name": "IndiGo",
    },
  ];

  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          topContainer(context, size),
          tabbarView(size),
        ],
      ),
    );
  }

  tabbarView(Size size) {
    return Expanded(
      child: TabBarView(
        controller: tabController,
        children: [
          firsttabbarView(size),
          secondtabbarView(size),
          thirdtabbarView(size),
        ],
      ),
    );
  }

  thirdtabbarView(Size size) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2, vertical: fixPadding),
      itemCount: mayPreferFlights.length,
      itemBuilder: (context, index) {
        return flightdetailContainer(
          size,
          mayPreferFlights[index]['name'].toString(),
        );
      },
    );
  }

  secondtabbarView(Size size) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2, vertical: fixPadding),
      itemCount: cheapestFlights.length,
      itemBuilder: (context, index) {
        return flightdetailContainer(
          size,
          cheapestFlights[index]['name'].toString(),
        );
      },
    );
  }

  firsttabbarView(Size size) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2, vertical: fixPadding),
      itemCount: fastestFlights.length,
      itemBuilder: (context, index) {
        return flightdetailContainer(
          size,
          fastestFlights[index]['name'].toString(),
        );
      },
    );
  }

  flightdetailContainer(Size size, String name) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, FlightDetails.routeName);
      },
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: semibold16black,
                ),
                const Text(
                  "\$600",
                  style: medium16primary,
                )
              ],
            ),
            heightSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  children: [
                    Text(
                      "11.45",
                      style: semibold14black,
                    ),
                    Text(
                      'Mumbai',
                      style: medium12grey94,
                    ),
                  ],
                ),
                width5Space,
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          dottedBorderprimary(),
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
                          dottedBorderprimary(),
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
                const Column(
                  children: [
                    Text(
                      "23.45",
                      style: semibold14black,
                    ),
                    Text(
                      'London',
                      style: medium12grey94,
                    ),
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
                  getTranslate(context, 'select_flight.view_detail'),
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

  topContainer(BuildContext context, Size size) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: fixPadding * 2),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 22,
                    color: whiteColor,
                  ),
                ),
                Text(
                  getTranslate(context, 'select_flight.select_flights'),
                  style: semibold18white,
                )
              ],
            ),
            height5Space,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        getTranslate(context, 'select_flight.from'),
                        style: semibold14white,
                      ),
                      const Text(
                        "Mumbai",
                        style: semibold14white,
                      )
                    ],
                  ),
                  widthSpace,
                  Expanded(
                    child: Row(
                      children: [
                        dottedBorder(),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: fixPadding / 2),
                          height: size.height * 0.04,
                          width: size.height * 0.04,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.flight_takeoff,
                            color: primaryColor,
                            size: 18,
                          ),
                        ),
                        dottedBorder(),
                      ],
                    ),
                  ),
                  widthSpace,
                  Column(
                    children: [
                      Text(
                        getTranslate(context, 'select_flight.to'),
                        style: semibold14white,
                      ),
                      const Text(
                        "London",
                        style: semibold14white,
                      )
                    ],
                  ),
                ],
              ),
            ),
            heightSpace,
            TabBar(
              labelColor: whiteColor,
              unselectedLabelColor: const Color(0xffc4c4c4),
              controller: tabController,
              indicatorColor: Colors.transparent,
              labelStyle: semibold16black,
              tabs: [
                Text(
                  getTranslate(context, 'select_flight.fastest'),
                  textAlign: TextAlign.center,
                ),
                Text(
                  getTranslate(context, 'select_flight.cheapest'),
                  textAlign: TextAlign.center,
                ),
                Text(
                  getTranslate(context, 'select_flight.you_prefer'),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            height5Space,
          ],
        ),
      ),
    );
  }

  dottedBorder() {
    return Expanded(
        child: DottedBorder(
            padding: EdgeInsets.zero,
            color: whiteColor,
            dashPattern: const [2, 4],
            child: Container()));
  }

  dottedBorderprimary() {
    return Expanded(
        child: DottedBorder(
            padding: EdgeInsets.zero,
            color: primaryColor,
            dashPattern: const [2, 3.5],
            child: Container()));
  }
}
