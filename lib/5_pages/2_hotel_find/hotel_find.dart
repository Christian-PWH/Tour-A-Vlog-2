import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/2_hotel_detail/hotel_detail.dart';

class HotelFind extends StatefulWidget {
  static const routeName = '/hotel_find';

  const HotelFind({super.key});

  @override
  State<HotelFind> createState() => _HotelFindState();
}

class _HotelFindState extends State<HotelFind> {
  RangeValues values = const RangeValues(10.0, 40.0);

  final propertyTypes = [
    {"name": "Resort", "id": 0},
    {"name": "Guest house", "id": 1},
    {"name": "Hotel", "id": 2},
    {"name": "Villa", "id": 3},
  ];

  int selectedPropertyType = 0;

  final star = [
    {"star": 5, "id": 0},
    {"star": 4, "id": 1},
    {"star": 3, "id": 2},
    {"star": 2, "id": 3},
    {"star": 1, "id": 4},
  ];

  int selectedstar = 0;

  bool? isHotelFavorite;

  final hotels = [
    {
      "image": "assets/thingstodo/hotel1.png",
      "name": "Pullman's King Power",
      "rate": 5,
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/hotel2.png",
      "name": "Hard Rock Hotel Bali",
      "rate": 4,
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/hotel3.png",
      "name": "Grand Inna Kuta",
      "rate": 5,
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/hotel4.png",
      "name": "Royal Kamuela Villas",
      "rate": 3,
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/hotel5.png",
      "name": "The Anvaya Resort ",
      "rate": 5,
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/hotel6.png",
      "name": "Pullman's King Power",
      "rate": 4,
      "isfavorite": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          topContainer(size, context),
          hotelList(size),
        ],
      ),
    );
  }

  hotelList(Size size) {
    return Expanded(
      child: ListView.builder(
        itemCount: hotels.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2,
          vertical: fixPadding,
        ),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          int starrate = hotels[index]['rate'] as int;
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, HotelDetail.routeName);
            },
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
                      hotels[index]['image'].toString(),
                      width: size.width * 0.33,
                      fit: BoxFit.cover,
                    ),
                  ),
                  widthSpace,
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                hotels[index]['name'].toString(),
                                style: medium16black,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  for (int i = 0; i < 5; i++)
                                    Icon(
                                      Icons.star,
                                      size: 17,
                                      color: (i < starrate)
                                          ? const Color(0xffEEA02C)
                                          : grey94Color,
                                    ),
                                ],
                              ),
                              Text(
                                "684 ${getTranslate(context, 'hotel_find.review')}",
                                style: medium14grey94.copyWith(
                                  color: const Color(0xff8A7F7F),
                                ),
                              ),
                              Text(
                                "\$56${getTranslate(context, 'hotel_find.per_night')}",
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
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        width5Space,
                        InkWell(
                          onTap: () {
                            setState(() {
                              isHotelFavorite =
                                  hotels[index]['isfavorite'] as bool;
                              hotels[index]['isfavorite'] = !isHotelFavorite!;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: blackColor,
                                content: hotels[index]['isfavorite'] == true
                                    ? Text(getTranslate(context,
                                        'favorite_add_remove.added_favorites'))
                                    : Text(getTranslate(context,
                                        'favorite_add_remove.removed_favorites')),
                                duration: const Duration(milliseconds: 1500),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          child: Icon(
                            hotels[index]['isfavorite'] == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 22,
                            color: grey94Color,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  topContainer(Size size, BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: fixPadding),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: gradient,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: grey94Color.withOpacity(0.5),
            blurRadius: 5,
          ),
        ],
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
                  getTranslate(context, 'hotel_find.find_hotel'),
                  style: semibold18white,
                )
              ],
            ),
            height5Space,
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(primary: primaryColor),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: grey94Color,
                      size: 20,
                    ),
                    hintText: getTranslate(context, 'hotel_find.search'),
                    hintStyle: medium16grey.copyWith(height: 1.3),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        hotelfilterDialog(context, size);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: fixPadding, vertical: fixPadding / 1.5),
                        width: size.height * 0.04,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          gradient: const LinearGradient(
                            colors: gradient,
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: const Icon(
                          Icons.filter_list,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  hotelfilterDialog(BuildContext context, Size size) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: blackColor.withOpacity(0.3),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(
                horizontal: fixPadding * 2, vertical: fixPadding),
            decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.close,
                        color: grey94Color,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Text(
                    getTranslate(context, 'hotel_find.filter'),
                    style: semibold18black,
                    textAlign: TextAlign.center,
                  ),
                ),
                pricepernight(state),
                heightSpace,
                heightSpace,
                divider(),
                heightSpace,
                heightSpace,
                propertyTypeList(state),
                heightSpace,
                heightSpace,
                divider(),
                heightSpace,
                heightSpace,
                starList(state),
                heightSpace,
                heightSpace,
                heightSpace,
                applyButton(size),
                clearallButton(),
              ],
            ),
          );
        });
      },
    );
  }

  clearallButton() {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        child: Text(
          getTranslate(context, 'hotel_find.clear_all'),
          style: medium14primary,
        ),
      ),
    );
  }

  applyButton(Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: size.height * 0.07,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: gradient,
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.25),
                blurRadius: 5,
              )
            ]),
        alignment: Alignment.center,
        child: Text(
          getTranslate(context, 'hotel_find.apply'),
          style: semibold18white,
        ),
      ),
    );
  }

  propertyTypeList(StateSetter state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslate(context, 'hotel_find.property_type'),
          style: medium16black,
        ),
        heightSpace,
        Wrap(
          spacing: fixPadding,
          runSpacing: fixPadding,
          children: propertyTypes
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    setState(() {
                      state(() {
                        selectedPropertyType = e['id'] as int;
                      });
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 1.5, vertical: fixPadding),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(
                        color: selectedPropertyType == (e['id'] as int)
                            ? primaryColor
                            : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: grey94Color.withOpacity(0.5),
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: Text(
                      e['name'].toString(),
                      style: selectedPropertyType == (e['id'] as int)
                          ? medium14primary
                          : medium14grey94,
                    ),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }

  divider() {
    return Container(
      width: double.infinity,
      height: 2,
      color: const Color(0xfff0f0f0),
    );
  }

  pricepernight(StateSetter state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(getTranslate(context, 'hotel_find.price_pernight'),
            style: medium16black),
        RangeSlider(
          activeColor: primaryColor,
          inactiveColor: const Color(0xffE6E6E6),
          values: values,
          min: 0,
          max: 100,
          divisions: 100,
          labels: RangeLabels(
            "\$${values.start.toInt()}",
            "\$${values.end.toInt()}",
          ),
          onChanged: (RangeValues newValues) {
            setState(
              () {
                state(() {
                  values = newValues;
                });
              },
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "\$${values.start.toStringAsFixed(1)}",
              style: semibold14grey,
            ),
            Text(
              "\$${values.end.toStringAsFixed(1)}",
              style: semibold14grey,
            ),
          ],
        )
      ],
    );
  }

  starList(state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslate(context, 'hotel_find.star'),
          style: medium16black,
        ),
        heightSpace,
        Wrap(
          spacing: fixPadding,
          runSpacing: fixPadding,
          children: star
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    setState(() {
                      state(() {
                        selectedstar = e['id'] as int;
                      });
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: fixPadding * 1.5, vertical: fixPadding),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(
                        color: selectedstar == (e['id'] as int)
                            ? primaryColor
                            : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: grey94Color.withOpacity(0.5),
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          e['star'].toString(),
                          style: selectedstar == (e['id'] as int)
                              ? medium14primary
                              : medium14grey94,
                        ),
                        width5Space,
                        Icon(
                          Icons.star,
                          size: 16,
                          color: selectedstar == (e['id'] as int)
                              ? primaryColor
                              : grey94Color,
                        )
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}
