import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/1_common/widgets/column_builder.dart';
import 'package:tour_a_vlog/4_home_navigation/1_home/home.dart';
import 'package:tour_a_vlog/5_pages/2_flights/flights.dart';
import 'package:tour_a_vlog/5_pages/2_holiday_package/holiday_packages.dart';
import 'package:tour_a_vlog/5_pages/2_hotel/hotel.dart';

class BookingScreen extends StatefulWidget {
  static const routeName = '/booking';

  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String selectedCity = cityList[1]['name'].toString();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          topImageContainer(size, context),
          categoriesContainer(size),
        ],
      ),
    );
  }

  categoriesContainer(Size size) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(fixPadding * 2),
        physics: const BouncingScrollPhysics(),
        children: [
          chooseText(),
          heightSpace,
          heightSpace,
          heightSpace,
          categoryList(size),
        ],
      ),
    );
  }

  categoryList(Size size) {
    return SizedBox(
      height: size.height * 0.5,
      width: double.infinity,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.45,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffF4F7FC),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.25),
                    blurRadius: 5,
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, HolidayPackages.routeName);
                  },
                  child: Container(
                    width: size.width * 0.7,
                    height: size.height * 0.13,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/notification/icon-park-outline_beach-umbrella.png",
                          height: size.height * 0.035,
                          width: size.height * 0.035,
                          fit: BoxFit.cover,
                          color: const Color(0xffDB5595),
                        ),
                        heightSpace,
                        Text(
                          getTranslate(context, 'book.packages'),
                          style: medium18black.copyWith(
                            color: const Color(0xffDB5595),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              heightSpace,
              heightSpace,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: categoryContainer(
                            size,
                            "assets/notification/Group.png",
                            getTranslate(context, 'Open Trip'),
                            const Color(0xffF27D65), () {
                          Navigator.pushNamed(context, Flights.routeName);
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              heightSpace,
              heightSpace,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: categoryContainer(
                            size,
                            "assets/notification/ri_hotel-line.png",
                            getTranslate(context, 'Private Tour'),
                            const Color(0xffC76E1D), () {
                          Navigator.pushNamed(context, HotelScreen.routeName);
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              heightSpace,
              heightSpace,
            ],
          )
        ],
      ),
    );
  }

  chooseText() {
    return Text(
      getTranslate(context, 'book.choose_text'),
      style: semibold18primary,
      textAlign: TextAlign.center,
    );
  }

  categoryContainer(
      Size size, String icon, String title, Color color, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: fixPadding),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              color: color,
              height: size.height * 0.04,
              width: size.height * 0.04,
              fit: BoxFit.cover,
            ),
            heightSpace,
            Text(
              title,
              style: medium18black.copyWith(
                color: color,
              ),
            )
          ],
        ),
      ),
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
            heightSpace,
            InkWell(
              onTap: () {
                selectCityDialog(context, size);
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: whiteColor,
                    size: 18,
                  ),
                  width5Space,
                  Text(
                    selectedCity,
                    style: semibold14white,
                  ),
                  const Icon(Icons.keyboard_arrow_down, color: whiteColor)
                ],
              ),
            ),
            const Spacer(),
            Text(
              getTranslate(context, 'book.book_now'),
              style: semibold18white,
            ),
            heightSpace,
            height5Space,
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
                getTranslate(context, 'book.select_city'),
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
                          selectedCity = cityList[index]['name'].toString();
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
                        border: selectedCity == cityList[index]['name']
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
