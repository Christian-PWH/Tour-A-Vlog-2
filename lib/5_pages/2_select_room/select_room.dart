import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/1_credit_card/credit_card.dart';

class SelectRoom extends StatefulWidget {
  static const routeName = '/select_room';

  const SelectRoom({super.key});

  @override
  State<SelectRoom> createState() => _SelectRoomState();
}

class _SelectRoomState extends State<SelectRoom> {
  final roomList = [
    {
      "name": "Double room with 1 bed",
      "price": 118,
    },
    {
      "name": "Twin room",
      "price": 110,
    },
    {
      "name": "Luxurious room",
      "price": 100,
    },
    {
      "name": "Royal room",
      "price": 125,
    },
    {
      "name": "Garden view room",
      "price": 115,
    },
    {
      "name": "garden view room",
      "price": 175,
    },
  ];

  int selectedRoom = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 22,
          ),
        ),
        title: Text(
          getTranslate(context, 'selecte_room.select_room'),
          style: semibold18white,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(fixPadding),
        physics: const BouncingScrollPhysics(),
        itemCount: roomList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedRoom = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.all(fixPadding),
              padding: const EdgeInsets.all(fixPadding),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color:
                      selectedRoom == index ? primaryColor : Colors.transparent,
                ),
                boxShadow: [
                  BoxShadow(
                    color: grey94Color.withOpacity(0.5),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      "assets/hoteldetail/room.png",
                      width: size.width * 0.3,
                      height: size.height * 0.18,
                      fit: BoxFit.cover,
                    ),
                  ),
                  widthSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          roomList[index]['name'].toString(),
                          style: medium16black,
                        ),
                        Row(
                          children: [
                            Text(
                              "\$${roomList[index]['price']}",
                              style: semibold16primary,
                            ),
                            Text(
                              getTranslate(context, 'selecte_room.per_night'),
                              style: regular12primary.copyWith(
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.aspect_ratio,
                                    size: 14,
                                    color: grey94Color,
                                  ),
                                  widthSpace,
                                  Text(
                                    "12 m2",
                                    style: medium12grey94,
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.bed,
                                    size: 14,
                                    color: grey94Color,
                                  ),
                                  widthSpace,
                                  Expanded(
                                    child: Text(
                                      "1 double  bed",
                                      style: medium12grey94,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        facilitiesText("Free wifi"),
                        facilitiesText('Television'),
                        facilitiesText("Air conditioner"),
                        facilitiesText("Bath"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
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
              padding: const EdgeInsets.symmetric(horizontal: fixPadding),
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
                  "\$118 ${getTranslate(context, 'selecte_room.per_person')}",
                  style: semibold14black,
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
                Navigator.pushNamed(context, CreditCard.routeName);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: fixPadding),
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
                child: FittedBox(
                  child: Text(
                    getTranslate(context, 'selecte_room.make_payment'),
                    style: semibold16white,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  facilitiesText(String text) {
    return Row(
      children: [
        Container(
          height: 4,
          width: 4,
          decoration: const BoxDecoration(
            color: blackColor,
            shape: BoxShape.circle,
          ),
        ),
        widthSpace,
        Text(
          text,
          style: regular12black,
        )
      ],
    );
  }
}
