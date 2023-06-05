// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/languages.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/profile_booking.dart';

class FlightTicketOngoing extends StatefulWidget {
  static const routeName = '/flight_ticket_ongoing';

  final index;

  const FlightTicketOngoing({super.key, this.index});

  @override
  State<FlightTicketOngoing> createState() => _FlightTicketOngoingState();
}

class _FlightTicketOngoingState extends State<FlightTicketOngoing> {
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
          getTranslate(context, 'flight_ticket.flight_ticket'),
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
      body: Padding(
        padding: const EdgeInsets.all(fixPadding * 2),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ticket(size, context),
            heightBox(40.0),
            cancelButton(size, context),
          ],
        ),
      ),
    );
  }

  cancelButton(Size size, context) {
    return GestureDetector(
      onTap: () {
        cancleDailog(context);
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
          getTranslate(context, 'flight_ticket.cancel_booking'),
          style: semibold18white,
        ),
      ),
    );
  }

  cancleDailog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(fixPadding * 2),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                getTranslate(context, 'flight_ticket.cancle_text'),
                style: semibold16black,
              ),
              heightSpace,
              heightSpace,
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding:
                              const EdgeInsets.symmetric(vertical: fixPadding),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: grey94Color.withOpacity(0.5),
                                  blurRadius: 5,
                                )
                              ]),
                          alignment: Alignment.center,
                          child: Text(
                            getTranslate(context, "flight_ticket.no"),
                            style: semibold16black.copyWith(color: grey94Color),
                          )),
                    ),
                  ),
                  widthSpace,
                  widthSpace,
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        flightsongoing.removeAt(widget.index);
                      },
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: fixPadding),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            gradient: const LinearGradient(
                                colors: gradient,
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: primaryColor.withOpacity(0.25),
                                blurRadius: 5,
                              )
                            ]),
                        alignment: Alignment.center,
                        child: Text(
                          getTranslate(context, 'flight_ticket.cancel'),
                          style: semibold16white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  ticket(Size size, context) {
    return Container(
      height: size.height * 0.37,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: grey94Color.withOpacity(0.5), blurRadius: 5),
        ],
      ),
      child: Row(
        children: [
          leftsideTicket(size, context),
          DottedBorder(
            padding: EdgeInsets.zero,
            dashPattern: const [3, 3],
            color: const Color(0xffC7B2B2),
            child: Container(
              height: size.height * 0.35,
            ),
          ),
          rightSideTicket(size, context)
        ],
      ),
    );
  }

  rightSideTicket(Size size, context) {
    return Expanded(
      flex: 1,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.1,
                padding: const EdgeInsets.only(
                    left: fixPadding, right: fixPadding, top: fixPadding / 2),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: languageValue == "عربي"
                      ? const BorderRadius.only(topLeft: Radius.circular(10))
                      : const BorderRadius.only(
                          topRight: Radius.circular(10),
                        ),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getTranslate(context, 'flight_ticket.boarding_pass'),
                      style: semibold14white,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      getTranslate(context, 'flight_ticket.economy'),
                      style: semibold12white,
                    ),
                  ],
                ),
              ),
              height5Space,
              Padding(
                padding: const EdgeInsets.all(fixPadding / 2),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          detailText(
                              getTranslate(
                                  context, 'flight_ticket.name_passanger'),
                              "John doe"),
                          height5Space,
                          Row(
                            children: [
                              Expanded(
                                child: detailText(
                                    getTranslate(context, 'flight_ticket.from'),
                                    "Mumbai"),
                              ),
                              Expanded(
                                child: detailText(
                                    getTranslate(context, 'flight_ticket.to'),
                                    "London"),
                              )
                            ],
                          ),
                          height5Space,
                          Row(
                            children: [
                              Expanded(
                                child: detailText(
                                    getTranslate(context, 'flight_ticket.seat'),
                                    "7A"),
                              ),
                              Expanded(
                                child: detailText(
                                    getTranslate(
                                        context, 'flight_ticket.flight'),
                                    "F3954"),
                              ),
                              Expanded(
                                child: detailText(
                                    getTranslate(context, 'flight_ticket.gate'),
                                    "D12"),
                              )
                            ],
                          ),
                          height5Space,
                          detailText(
                              getTranslate(context, 'flight_ticket.date'),
                              "07 april 2022"),
                        ],
                      ),
                    ),
                    width5Space,
                    Image.asset(
                      "assets/success/fa-solid_barcode (1).png",
                      height: size.height * 0.14,
                      fit: BoxFit.cover,
                    )
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.03,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: languageValue == "عربي"
                    ? const BorderRadius.only(bottomLeft: Radius.circular(10))
                    : const BorderRadius.only(bottomRight: Radius.circular(10)),
              ),
            ),
          ),
          flight2Icon(size),
        ],
      ),
    );
  }

  detailText(title, text) {
    return Column(
      children: [
        Text(
          title,
          style: medium10grey,
          overflow: TextOverflow.ellipsis,
        ),
        Text(text, style: semibold10black, overflow: TextOverflow.ellipsis)
      ],
    );
  }

  text2Column(String title, String text) {
    return Expanded(
      child: Column(
        children: [
          Text(title, style: medium10grey, overflow: TextOverflow.ellipsis),
          Text(text, style: semibold10black, overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }

  leftsideTicket(Size size, context) {
    return Expanded(
      flex: 2,
      child: Stack(
        children: [
          Column(
            children: [
              topLeftText(size, context),
              heightSpace,
              heightSpace,
              heightSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                child: Row(
                  children: [
                    textColumn(
                        getTranslate(context, 'flight_ticket.name_passanger'),
                        "John doe"),
                    textColumn(
                        getTranslate(context, 'flight_ticket.flight'), "F3954"),
                    textColumn(
                        getTranslate(context, 'flight_ticket.gate'), "D12"),
                  ],
                ),
              ),
              heightSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: fixPadding),
                child: Row(
                  children: [
                    textColumn(
                        getTranslate(context, 'flight_ticket.boarding_time'),
                        "7.30"),
                    textColumn(getTranslate(context, 'flight_ticket.date'),
                        "07 april 2022"),
                    textColumn(
                        getTranslate(context, 'flight_ticket.seat'), "7A"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(fixPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/success/fa-solid_barcode.png",
                      height: size.height * 0.045,
                      width: size.width * 0.35,
                      fit: BoxFit.cover,
                    )
                  ],
                ),
              ),
            ],
          ),
          flightIcon(size),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.03,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: languageValue == "عربي"
                    ? const BorderRadius.only(bottomRight: Radius.circular(10))
                    : const BorderRadius.only(bottomLeft: Radius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  flightIcon(Size size) {
    return languageValue == "عربي"
        ? Positioned(
            top: size.height * 0.06,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(fixPadding / 2),
              decoration: const BoxDecoration(
                color: whiteColor,
                shape: BoxShape.circle,
              ),
              height: size.height * 0.08,
              width: size.height * 0.08,
              child: Container(
                decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.flight_takeoff,
                  color: whiteColor,
                  size: 22,
                ),
              ),
            ),
          )
        : Positioned(
            top: size.height * 0.06,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(fixPadding / 2),
              decoration: const BoxDecoration(
                color: whiteColor,
                shape: BoxShape.circle,
              ),
              height: size.height * 0.08,
              width: size.height * 0.08,
              child: Container(
                decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.flight_takeoff,
                  color: whiteColor,
                  size: 22,
                ),
              ),
            ),
          );
  }

  flight2Icon(Size size) {
    return languageValue == "عربي"
        ? Positioned(
            bottom: size.height * 0.01,
            left: 10,
            child: Container(
              padding: const EdgeInsets.all(fixPadding / 2),
              decoration: const BoxDecoration(
                color: whiteColor,
                shape: BoxShape.circle,
              ),
              height: size.height * 0.05,
              width: size.height * 0.05,
              child: Container(
                decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.flight_takeoff,
                  color: whiteColor,
                  size: 16,
                ),
              ),
            ),
          )
        : Positioned(
            bottom: size.height * 0.01,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(fixPadding / 2),
              decoration: const BoxDecoration(
                color: whiteColor,
                shape: BoxShape.circle,
              ),
              height: size.height * 0.05,
              width: size.height * 0.05,
              child: Container(
                decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.flight_takeoff,
                  color: whiteColor,
                  size: 16,
                ),
              ),
            ),
          );
  }

  topLeftText(Size size, context) {
    return Container(
      height: size.height * 0.1,
      padding: const EdgeInsets.only(
          left: fixPadding, right: fixPadding, top: fixPadding / 2),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: languageValue == "عربي"
            ? const BorderRadius.only(topRight: Radius.circular(10))
            : const BorderRadius.only(
                topLeft: Radius.circular(10),
              ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Air India",
            style: semibold18white,
          ),
          widthSpace,
          widthSpace,
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            getTranslate(context, 'flight_ticket.from'),
                            style: semibold10white,
                          ),
                          const FittedBox(
                            child: Text(
                              "Mumbai",
                              style: semibold12white,
                            ),
                          )
                        ],
                      ),
                    ),
                    widthSpace,
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            getTranslate(context, 'flight_ticket.to'),
                            style: semibold10white,
                          ),
                          const FittedBox(
                            child: Text(
                              "Jaypur",
                              style: semibold12white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                height5Space,
                Row(
                  children: [
                    dottedLine(),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: fixPadding / 2),
                      height: size.height * 0.03,
                      width: size.height * 0.03,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.flight_takeoff,
                        color: primaryColor,
                        size: 16,
                      ),
                    ),
                    dottedLine(),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  dottedLine() {
    return Expanded(
        child: DottedBorder(
      padding: EdgeInsets.zero,
      color: whiteColor,
      dashPattern: const [2, 4],
      child: Container(),
    ));
  }

  textColumn(String title, String text) {
    return Expanded(
      child: Column(
        children: [
          Text(title, style: medium12grey94, overflow: TextOverflow.ellipsis),
          Text(text, style: medium12black, overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }
}
