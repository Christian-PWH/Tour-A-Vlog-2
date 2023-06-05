import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/2_hotel_find/hotel_find.dart';

class HotelScreen extends StatefulWidget {
  static const routeName = '/hotel';

  const HotelScreen({super.key});

  @override
  State<HotelScreen> createState() => _HotelScreenState();
}

class _HotelScreenState extends State<HotelScreen> {
  var checkInDate = DateTime.now();
  var checkoutDate = DateTime.now();

  int noOfRoom = 0;

  int adultNo = 0;

  int kidsNo = 0;

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
            color: whiteColor,
            size: 22,
          ),
        ),
        titleSpacing: 0,
        title: Text(
          getTranslate(context, 'hotel.hotel'),
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
        padding: const EdgeInsets.all(fixPadding * 2),
        physics: const BouncingScrollPhysics(),
        children: [
          locationContainer(size),
          heightSpace,
          heightSpace,
          checkInDateContainer(context, size),
          heightSpace,
          heightSpace,
          checkOutDateContainer(context, size),
          heightSpace,
          heightSpace,
          numberOfRooms(size),
          heightSpace,
          heightSpace,
          adults(size),
          heightSpace,
          heightSpace,
          kids(size),
          heightSpace,
          heightSpace,
          heightSpace,
          searchHotelButton(size),
        ],
      ),
    );
  }

  searchHotelButton(Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, HotelFind.routeName);
      },
      child: Container(
        width: double.infinity,
        height: size.height * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: gradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.25),
              blurRadius: 5,
            )
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslate(context, 'hotel.search_hotel'),
          style: semibold18white,
        ),
      ),
    );
  }

  locationContainer(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2, vertical: fixPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: grey94Color.withOpacity(0.5),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          iconContainer(
            size,
            Icons.directions_car_filled_outlined,
          ),
          widthSpace,
          width5Space,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(getTranslate(context, 'hotel.enter_city'),
                    style: medium14grey94),
                Text(getTranslate(context, 'hotel.city_name'),
                    style: medium14black)
              ],
            ),
          )
        ],
      ),
    );
  }

  kids(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2, vertical: fixPadding),
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
          iconContainer(size, Icons.accessibility_new_rounded),
          widthSpace,
          width5Space,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslate(context, 'hotel.kids'),
                style: medium14grey94,
              ),
              height5Space,
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (kidsNo > 0) {
                          kidsNo--;
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(fixPadding / 3),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: grey94Color.withOpacity(0.5),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.remove,
                        color: blackColor,
                        size: 13,
                      ),
                    ),
                  ),
                  widthSpace,
                  Text(
                    kidsNo.toString(),
                    style: semibold14black,
                  ),
                  widthSpace,
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        kidsNo++;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(fixPadding / 3),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: grey94Color.withOpacity(0.5),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.add,
                        color: blackColor,
                        size: 13,
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  adults(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2, vertical: fixPadding),
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
          iconContainer(size, Icons.person),
          widthSpace,
          width5Space,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslate(context, 'hotel.adult'),
                style: medium14grey94,
              ),
              height5Space,
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (adultNo > 0) {
                          adultNo--;
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(fixPadding / 3),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: grey94Color.withOpacity(0.5),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.remove,
                        color: blackColor,
                        size: 13,
                      ),
                    ),
                  ),
                  widthSpace,
                  Text(
                    adultNo.toString(),
                    style: semibold14black,
                  ),
                  widthSpace,
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        adultNo++;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(fixPadding / 3),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: grey94Color.withOpacity(0.5),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.add,
                        color: blackColor,
                        size: 13,
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  numberOfRooms(Size size) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2, vertical: fixPadding),
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
          iconContainer(size, Icons.meeting_room_outlined),
          widthSpace,
          width5Space,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslate(context, 'hotel.no_room'),
                style: medium14grey94,
              ),
              height5Space,
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        if (noOfRoom > 0) {
                          noOfRoom--;
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(fixPadding / 3),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: grey94Color.withOpacity(0.5),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.remove,
                        color: blackColor,
                        size: 13,
                      ),
                    ),
                  ),
                  widthSpace,
                  Text(
                    noOfRoom.toString(),
                    style: semibold14black,
                  ),
                  widthSpace,
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        noOfRoom++;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(fixPadding / 3),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: grey94Color.withOpacity(0.5),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.add,
                        color: blackColor,
                        size: 13,
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  checkInDateContainer(BuildContext context, Size size) {
    return GestureDetector(
      onTap: () async {
        var pickkedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(primary: primaryColor),
                ),
                child: child!,
              );
            });
        if (pickkedDate != null) {
          setState(() {
            checkInDate = pickkedDate;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: fixPadding, horizontal: fixPadding * 2),
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
            iconContainer(size, Icons.date_range_outlined),
            width5Space,
            widthSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslate(context, 'hotel.check_date'),
                    style: medium14grey94,
                  ),
                  height5Space,
                  Text(
                    DateFormat("dd MMM, yyyy ",
                            Localizations.localeOf(context).toString())
                        .format(checkInDate),
                    style: medium14black,
                  )
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: grey94Color,
            )
          ],
        ),
      ),
    );
  }

  checkOutDateContainer(BuildContext context, Size size) {
    return GestureDetector(
      onTap: () async {
        var pickkedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(primary: primaryColor),
                ),
                child: child!,
              );
            });
        if (pickkedDate != null) {
          setState(() {
            checkoutDate = pickkedDate;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: fixPadding, horizontal: fixPadding * 2),
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
            iconContainer(
              size,
              Icons.date_range_outlined,
            ),
            width5Space,
            widthSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getTranslate(context, 'hotel.check_date'),
                    style: medium14grey94,
                  ),
                  height5Space,
                  Text(
                    DateFormat("dd MMM, yyyy ",
                            Localizations.localeOf(context).toString())
                        .format(checkoutDate),
                    style: medium14black,
                  )
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 20,
              color: grey94Color,
            )
          ],
        ),
      ),
    );
  }

  iconContainer(Size size, IconData icon) {
    return Container(
      height: size.height * 0.045,
      width: size.height * 0.045,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        color: whiteColor,
        size: 20,
      ),
    );
  }
}
