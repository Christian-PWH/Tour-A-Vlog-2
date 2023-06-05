import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/profile_booking.dart';
import 'package:tour_a_vlog/5_pages/2_hotel_detail/hotel_detail.dart';

class HotelBookingOngoing extends StatefulWidget {
  static const routeName = '/hotel_booking_ongoing';
  final int? index;

  const HotelBookingOngoing({super.key, this.index});

  @override
  State<HotelBookingOngoing> createState() => _HotelBookingOngoingState();
}

class _HotelBookingOngoingState extends State<HotelBookingOngoing> {
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
          getTranslate(context, 'hotel_booking.hotel_booking'),
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
          textlist(),
          dottedline(),
          hotelContainer(size),
          detailRow(size),
          heightSpace,
          heightSpace,
          dottedline(),
          heightBox(40.0),
          cancelButton(size, context),
        ],
      ),
    );
  }

  detailRow(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Row(
        children: [
          detailText(getTranslate(context, 'hotel_booking.check_in_date'),
              getTranslate(context, 'hotel_booking.date_in')),
          widthBox(20),
          divider(size),
          widthBox(20),
          detailText(getTranslate(context, 'hotel_booking.check_out_date'),
              getTranslate(context, 'hotel_booking.date_out')),
        ],
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
        margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
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
          getTranslate(context, 'hotel_booking.cancel_booking'),
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
                getTranslate(context, 'hotel_booking.cancel_text'),
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
                            getTranslate(context, 'hotel_booking.no'),
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
                        setState(() {
                          hotelOngoing.removeAt(widget.index!);
                        });
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
                            getTranslate(context, 'hotel_booking.cancel'),
                            style: semibold16white,
                          )),
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

  divider(Size size) {
    return Container(
      height: size.height * 0.06,
      width: 1,
      color: grey94Color,
    );
  }

  detailText(title, text) {
    return Column(
      children: [
        Text(
          title,
          style: medium16black,
        ),
        Text(
          text,
          style: medium14grey94,
        )
      ],
    );
  }

  hotelContainer(Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, HotelDetail.routeName);
      },
      child: Container(
        padding: const EdgeInsets.all(fixPadding),
        margin: const EdgeInsets.all(fixPadding * 2),
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
                "assets/thingstodo/hotel1.png",
                width: size.width * 0.33,
                fit: BoxFit.cover,
              ),
            ),
            widthSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Royal Kamuela Villas",
                      style: medium16black, overflow: TextOverflow.ellipsis),
                  Row(
                    children: [
                      for (int i = 0; i < 5; i++)
                        const Icon(Icons.star, size: 17, color: starColor),
                    ],
                  ),
                  Text(
                    "684 ${getTranslate(context, 'hotel_booking.review')}",
                    style: medium14grey94.copyWith(
                      color: const Color(0xff8A7F7F),
                    ),
                  ),
                  Text(
                    "\$56(${getTranslate(context, 'hotel_booking.per_night')})",
                    style: medium16primary,
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
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  dottedline() {
    return DottedBorder(
        padding: EdgeInsets.zero,
        color: grey94Color,
        dashPattern: const [2, 4],
        child: Container(
          width: double.infinity,
        ));
  }

  textlist() {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2),
      child: Column(
        children: [
          topText(getTranslate(context, 'hotel_booking.number_room'),
              getTranslate(context, 'hotel_booking.bedroom')),
          topText(getTranslate(context, 'hotel_booking.guest'),
              "2 ${getTranslate(context, 'hotel_booking.kids')}, 1 ${getTranslate(context, 'hotel_booking.adult')}"),
        ],
      ),
    );
  }

  topText(title, text) {
    return Row(
      children: [
        Text(
          title,
          style: regular14black,
        ),
        const Text(
          " : ",
          style: regular14black,
        ),
        Text(
          text,
          style: regular12grey,
        )
      ],
    );
  }
}
