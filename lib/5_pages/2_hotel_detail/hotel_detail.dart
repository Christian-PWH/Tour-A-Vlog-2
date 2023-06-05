import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/1_review/review.dart';
import 'package:tour_a_vlog/5_pages/2_check_in_check_out/checkin_checkout.dart';
import 'package:tour_a_vlog/5_pages/2_location/location.dart';
import 'package:tour_a_vlog/5_pages/2_select_room/select_room.dart';

class HotelDetail extends StatefulWidget {
  static const routeName = '/hotel_detail';

  const HotelDetail({super.key});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
  Completer<GoogleMapController> mapcontroller = Completer();

  static CameraPosition locationposition =
      const CameraPosition(target: LatLng(51.5072, 0.1276), zoom: 10.46);

  bool isFavorite = false;

  final facilities = [
    {
      "icon": Icons.bed,
      "title": "164 rooms",
      "color": const Color(0xffEE19CC),
    },
    {
      "icon": Icons.wifi,
      "title": "Wifi",
      "color": const Color(0xffF0153C),
    },
    {
      "icon": Icons.beach_access_rounded,
      "title": "beach view",
      "color": const Color(0xff476AE6),
    },
    {
      "icon": Icons.directions_car,
      "title": "Parking",
      "color": const Color(0xffFF5430),
    },
    {
      "icon": Icons.bathtub_outlined,
      "title": "Bath",
      "color": const Color(0xff924626),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            centerTitle: false,
            backgroundColor: primaryColor,
            expandedHeight: size.height * 0.3,
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
            actions: [
              IconButton(
                onPressed: () {
                  setState(
                    () {
                      isFavorite = !isFavorite;
                    },
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: blackColor,
                      content: isFavorite == true
                          ? Text(getTranslate(
                              context, 'favorite_add_remove.added_favorites'))
                          : Text(getTranslate(context,
                              'favorite_add_remove.removed_favorites')),
                      duration: const Duration(milliseconds: 1500),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  size: 22,
                  color: whiteColor,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: whiteColor,
                  size: 22,
                ),
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/hoteldetail/image.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                heightSpace,
                heightSpace,
                detailInfo(),
                heightSpace,
                detailText(),
                heightSpace,
                heightSpace,
                checkandGuestContainer(),
                heightSpace,
                heightSpace,
                facilitiesList(size),
                heightSpace,
                location(size),
                heightSpace,
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: fixPadding * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getTranslate(context, 'hotel_detail.review'),
                        style: semibold16black,
                      ),
                      heightSpace,
                      reviewdetail(size, "assets/review/Ellipse 10.png",
                          "Jeni patel", 4),
                      heightSpace,
                      reviewdetail(size, "assets/review/Ellipse 10 (1).png",
                          "Jenny Wilson", 3),
                      heightSpace,
                      heightSpace,
                      seeAllReview(size),
                    ],
                  ),
                ),
                heightSpace,
                heightSpace,
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: bottomNavigationbar(size),
    );
  }

  bottomNavigationbar(Size size) {
    return Container(
      height: size.height * 0.1,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2, vertical: fixPadding * 1.2),
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: greyColor.withOpacity(0.5),
            blurRadius: 5,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: fixPadding / 2, vertical: fixPadding / 2),
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
              alignment: Alignment.center,
              child: FittedBox(
                child: Text(
                  "\$118 ${getTranslate(context, 'hotel_detail.per_person')}",
                  style: semibold16black,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          widthSpace,
          widthSpace,
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, SelectRoom.routeName);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: fixPadding / 2),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: gradient,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: grey94Color.withOpacity(0.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  getTranslate(context, 'hotel_detail.select_room'),
                  style: semibold16white,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  seeAllReview(Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ReviewScreen.routeName);
      },
      child: Container(
        height: size.height * 0.065,
        width: double.infinity,
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
        alignment: Alignment.center,
        child: Text(
          getTranslate(context, 'hotel_detail.see_all_review'),
          style: semibold16primary,
        ),
      ),
    );
  }

  reviewdetail(Size size, String image, String name, int starrate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: size.height * 0.06,
                      width: size.height * 0.06,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(image),
                        ),
                      ),
                    ),
                    widthSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: semibold16black,
                        ),
                        height5Space,
                        Row(
                          children: [
                            for (int i = 0; i < 5; i++)
                              Icon(
                                Icons.star_sharp,
                                size: 16,
                                color: i < starrate ? starColor : grey94Color,
                              )
                          ],
                        )
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        ),
        height5Space,
        const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Leo ut in euismod gravida enim aenean. Fermentum, potenti facilisis quis facilisi amet, natoque molestie. Amet leo vitae sed nec, tincidunt adipiscing pretium justo. ",
            style: medium12grey94)
      ],
    );
  }

  location(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, 'hotel_detail.location'),
            style: semibold16black,
          ),
          const Row(
            children: [
              Icon(
                Icons.location_on,
                size: 22,
                color: grey94Color,
              ),
              widthSpace,
              Expanded(
                child: Text(
                  "4517 Washington Ave. Manchester, Kentucky 39495",
                  style: medium14grey94,
                ),
              ),
            ],
          ),
          height5Space,
          Stack(
            children: [
              Container(
                height: size.height * 0.27,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GoogleMap(
                    zoomControlsEnabled: false,
                    initialCameraPosition: locationposition,
                    onMapCreated: (GoogleMapController controller) {
                      mapcontroller.complete(controller);
                    },
                    markers: {
                      const Marker(
                        markerId: MarkerId("London"),
                        position: LatLng(51.5072, 0.1276),
                      )
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, LocationScreen.routeName);
                },
                child: Container(
                  height: size.height * 0.27,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  facilitiesList(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
          child: Text(
            getTranslate(context, 'hotel_detail.facilities'),
          ),
        ),
        heightSpace,
        SizedBox(
          height: size.height * 0.13,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding / 2),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: facilities.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: fixPadding * 1.5, vertical: fixPadding / 2),
                child: Column(
                  children: [
                    Container(
                      height: size.height * 0.07,
                      width: size.height * 0.07,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: grey94Color.withOpacity(0.5),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        facilities[index]['icon'] as IconData,
                        color: facilities[index]['color'] as Color,
                      ),
                    ),
                    height5Space,
                    Text(
                      facilities[index]['title'].toString(),
                      style: medium12grey94,
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  checkandGuestContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, CheckinCheckout.routeName);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: fixPadding, horizontal: fixPadding),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: grey94Color.withOpacity(0.5),
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    FittedBox(
                      child: Text(
                        getTranslate(context, 'hotel_detail.check_in_out'),
                        style: semibold14black,
                      ),
                    ),
                    const Text(
                      "18 nov /20 nov",
                      style: medium12grey94,
                    )
                  ],
                ),
              ),
            ),
          ),
          widthSpace,
          widthSpace,
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, CheckinCheckout.routeName);
              },
              child: Container(
                padding: const EdgeInsets.all(fixPadding),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: grey94Color.withOpacity(0.5),
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      getTranslate(context, 'hotel_detail.guest_room'),
                      style: semibold14black,
                    ),
                    const Text(
                      "2 guest/ 1 room",
                      style: medium12grey94,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  detailText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, 'hotel_detail.description'),
            style: semibold16black,
          ),
          height5Space,
          const ReadMoreText(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque faucibus nullam accumsan cras nunc viverra pharetra. Natoque blandit pretium, molestie enim, vel. Eget donec arcu vitae aliquet. Hac quis tortor erat augue. Et orci, sit enim lectus. Neque sem quis porta id maecenas purus nibh egestas. Dictumst dolor consequat cursus integer sagittis donec sed Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
            style: medium14grey94,
            lessStyle: medium14primary,
            moreStyle: medium14primary,
          )
        ],
      ),
    );
  }

  detailInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hard Rock Hotel Bali",
            style: semibold18black,
          ),
          Row(
            children: [
              for (int i = 0; i < 5; i++)
                Icon(
                  Icons.star_sharp,
                  size: 18,
                  color: (i < 4) ? starColor : grey94Color,
                )
            ],
          ),
          Text(
            "\$55${getTranslate(context, 'hotel_detail.per_night')}",
            style: semibold16primary,
          )
        ],
      ),
    );
  }
}
