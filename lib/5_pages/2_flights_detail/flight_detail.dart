import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/2_flight_travel_detail/flight_travel_detail.dart';

class FlightDetails extends StatelessWidget {
  static const routeName = '/flight_details';

  const FlightDetails({super.key});

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
          ),
        ),
        titleSpacing: 0,
        title: Text(
          getTranslate(context, 'flight_detail.details'),
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
          placeContainer(size, context),
          heightSpace,
          heightSpace,
          flightDetail(size, context),
          heightSpace,
          heightSpace,
          luggageDetail(context),
          heightBox(50.0),
          bookNowButton(size, context),
        ],
      ),
    );
  }

  bookNowButton(Size size, context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, FlightTravelDetails.routeName);
      },
      child: Container(
        height: size.height * 0.07,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: gradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.25),
              blurRadius: 5,
            )
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslate(context, 'flight_detail.book_now'),
          style: semibold18white,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  luggageDetail(context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: fixPadding * 2,
        horizontal: fixPadding,
      ),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      color: grey94Color,
                      size: 20,
                    ),
                    widthSpace,
                    Expanded(
                      child: Text(
                        getTranslate(context, 'flight_detail.cabin_bag'),
                        style: medium14grey94,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "\$${getTranslate(context, 'flight_detail.kgs')}",
                style: medium14black,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
          height5Space,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      "assets/packagedetail/akar-icons_check-in.png",
                      height: 19,
                      width: 19,
                      fit: BoxFit.cover,
                    ),
                    widthSpace,
                    Expanded(
                      child: Text(
                          getTranslate(context, 'flight_detail.check_in'),
                          style: medium14grey94,
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                ),
              ),
              Text(
                "\$${getTranslate(context, 'flight_detail.checkin_kgs')}",
                style: medium14black,
                overflow: TextOverflow.ellipsis,
              )
            ],
          )
        ],
      ),
    );
  }

  flightDetail(Size size, context) {
    return Container(
      padding: const EdgeInsets.all(fixPadding),
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
        children: [
          Text(getTranslate(context, 'flight_detail.air_India'),
              style: semibold16black),
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              text(getTranslate(context, 'flight_detail.gate'), "B7"),
              Container(
                height: size.height * 0.07,
                width: 1,
                color: grey94Color,
              ),
              text(getTranslate(context, 'flight_detail.flight_number'),
                  "RK733"),
              Container(
                height: size.height * 0.07,
                width: 1,
                color: grey94Color,
              ),
              text(getTranslate(context, 'flight_detail.class'),
                  getTranslate(context, 'flight_detail.business')),
            ],
          ),
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  text: "${getTranslate(context, 'flight_detail.price')}: ",
                  style: medium14black,
                  children: const [
                    TextSpan(
                      text: "\$600",
                      style: medium16primary,
                    ),
                  ],
                ),
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

  text(String title, String content) {
    return Column(
      children: [
        Text(
          title,
          style: medium16grey,
        ),
        height5Space,
        Text(
          content,
          style: medium16black,
        )
      ],
    );
  }

  placeContainer(Size size, context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: fixPadding * 2, horizontal: fixPadding),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                getTranslate(context, 'flight_detail.from'),
                style: semibold14black,
              ),
              const Text(
                "Jakarta",
                style: semibold14black,
              )
            ],
          ),
          widthSpace,
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
                Text(
                  getTranslate(context, 'flight_detail.non_stop'),
                  style: semibold14black,
                )
              ],
            ),
          ),
          widthSpace,
          Column(
            children: [
              Text(
                getTranslate(context, 'flight_detail.to'),
                style: semibold14black,
              ),
              const Text(
                "London",
                style: semibold14black,
              )
            ],
          ),
        ],
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
      ),
    );
  }
}
