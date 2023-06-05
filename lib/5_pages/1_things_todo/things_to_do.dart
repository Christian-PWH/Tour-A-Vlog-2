import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/1_common/widgets/column_builder.dart';
import 'package:tour_a_vlog/4_home_navigation/1_home/home.dart';
import 'package:tour_a_vlog/5_pages/2_flights/flights.dart';
import 'package:tour_a_vlog/5_pages/3_place_detail/place_detail.dart';

final thingsToDoList = [
  {
    "name": "Attraction",
    "title": "Things to see and do",
  },
  {
    "name": "Hotel",
    "title": "Hotel in bali",
  },
  {
    "name": "Restaurants",
    "title": "Restaurants in bali",
  },
  {
    "name": "How to reach there",
    "title": "How to reach there",
  },
  {
    "name": "Beach",
    "title": "Beach in bali",
  },
  {
    "name": "Adventure",
    "title": "Adventure in bali",
  },
];

// ignore: must_be_immutable
class ThingsToDo extends StatefulWidget {
  static const routeName = '/things_todo';

  int? selectedPage;

  ThingsToDo({super.key, this.selectedPage});

  @override
  State<ThingsToDo> createState() => _ThingsToDoState();
}

class _ThingsToDoState extends State<ThingsToDo> {
  final attractions = [
    {
      "image": "assets/thingstodo/attraction1.png",
      "title": "Diving in Tulamben",
      "subtitle": "Historic Dive Site",
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/attraction2.png",
      "title": "Diving in Tulamben",
      "subtitle": "Historic Dive Site",
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/attraction3.png",
      "title": "Diving in Tulamben",
      "subtitle": "Historic Dive Site",
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/attraction4.png",
      "title": "Diving in Tulamben",
      "subtitle": "Historic Dive Site",
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/attraction5.png",
      "title": "Diving in Tulamben",
      "subtitle": "Historic Dive Site",
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/attraction6.png",
      "title": "Diving in Tulamben",
      "subtitle": "Historic Dive Site",
      "isfavorite": false,
    },
  ];

  final beach = [
    {
      "image": "assets/thingstodo/beach1.png",
      "title": "Kuta Beach",
      "subtitle": "Vibrant locale for sunsets & surfing",
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/beach2.png",
      "title": "Dreamland Beach",
      "subtitle": "Intimate sand beach & surf break",
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/beach3.png",
      "title": "Seminyak Beach",
      "subtitle": "Buzzing resort beach with clubs & bars",
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/beach4.png",
      "title": "Seminyak Beach",
      "subtitle": "Buzzing resort beach with clubs & bars",
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/beach5.png",
      "title": "Legian Beach",
      "subtitle": " Popular surfing spot",
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/beach6.png",
      "title": "Jimbaran Beach",
      "subtitle": "Scenic beach",
      "isfavorite": false,
    },
  ];

  final adventures = [
    {
      "image": "assets/thingstodo/adventure1.png",
      "title": "Flyboarding At Benoa",
      "subtitle": "Newest water sport",
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/adventure2.png",
      "title": "Ayung River Rafting",
      "subtitle": "White water rafting",
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/adventure3.png",
      "title": "Paragliding At Denpasar",
      "subtitle": "World famous adventure",
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/adventure4.png",
      "title": "Ancient Temples",
      "subtitle": "Newest water sport",
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/adventure5.png",
      "title": "Climbing Mount Batur",
      "subtitle": "Exhilarating Water Sport",
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/adventure6.png",
      "title": "Bali Flying Fish",
      "subtitle": "Newest water sport",
      "isfavorite": false,
    },
  ];

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

  final restaurants = [
    {
      "image": "assets/thingstodo/restaurant1.png",
      "name": "Mason",
      "rate": 3,
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/restaurant2.png",
      "name": "Barbacoa food",
      "rate": 4,
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/restaurant3.png",
      "name": "Laughing Buddha Bar",
      "rate": 3,
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/restaurant4.png",
      "name": "La Favela",
      "rate": 4,
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/restaurant5.png",
      "name": "Ku De Ta",
      "rate": 3,
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/restaurant6.png",
      "name": "Potato Head",
      "rate": 4,
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/restaurant7.png",
      "name": "Hilton food special",
      "rate": 5,
      "isfavorite": false,
    },
    {
      "image": "assets/thingstodo/restaurant8.png",
      "name": "Rock Bar Bali",
      "rate": 3,
      "isfavorite": false,
    },
  ];

  int? selectedindex;

  String? appbarname;

  bool? isHotelFavorite;

  bool? isAttractionFavorite;

  bool? isBeachFavorite;

  bool? isRestaurantFavorite;

  bool? isAdventureFavorite;

  String selectedCityName = cityList[1]['name'].toString();

  @override
  void initState() {
    selectedindex = widget.selectedPage ?? 0;
    appbarname = thingsToDoList[selectedindex!]['title'].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          appbarname.toString(),
          style: semibold18white,
        ),
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: whiteColor,
          ),
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
          heightSpace,
          toplist(size),
          if (selectedindex == 0) attractionlist(size),
          if (selectedindex == 1) hotelList(size),
          if (selectedindex == 2) restaurantsList(size),
          if (selectedindex == 3) howtorich(context, size),
          if (selectedindex == 4) beachList(size),
          if (selectedindex == 5) adventureList(size),
        ],
      ),
    );
  }

  adventureList(Size size) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: adventures.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, PlaceDetail.routeName);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: fixPadding * 2, vertical: fixPadding),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: grey94Color.withOpacity(0.5),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(5)),
                        child: Image.asset(
                          adventures[index]['image'].toString(),
                          height: size.height * 0.17,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isAdventureFavorite =
                                  adventures[index]['isfavorite'] as bool;
                              adventures[index]['isfavorite'] =
                                  !isAdventureFavorite!;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: blackColor,
                                content: adventures[index]['isfavorite'] == true
                                    ? Text(getTranslate(context,
                                        'favorite_add_remove.added_favorites'))
                                    : Text(getTranslate(context,
                                        'favorite_add_remove.removed_favorites')),
                                duration: const Duration(milliseconds: 1500),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: Icon(
                            adventures[index]['isfavorite'] == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 20,
                            color: whiteColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      adventures[index]['title'].toString(),
                      style: semibold16primary,
                    ),
                    subtitle: Text(
                      adventures[index]['subtitle'].toString(),
                      style: regular12grey,
                    ),
                    childrenPadding: const EdgeInsets.only(
                        left: fixPadding * 2,
                        right: fixPadding * 2,
                        bottom: fixPadding),
                    children: const [
                      Text(
                        "Amet mivnim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet. Velit officia consequat duis enim velit mollit. ",
                        style: regular14grey,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  beachList(Size size) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: beach.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, PlaceDetail.routeName);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: fixPadding * 2, vertical: fixPadding),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: grey94Color.withOpacity(0.5),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(5)),
                        child: Image.asset(
                          beach[index]['image'].toString(),
                          height: size.height * 0.17,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isBeachFavorite =
                                  beach[index]['isfavorite'] as bool;
                              beach[index]['isfavorite'] = !isBeachFavorite!;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: blackColor,
                                content: beach[index]['isfavorite'] == true
                                    ? Text(getTranslate(context,
                                        'favorite_add_remove.added_favorites'))
                                    : Text(getTranslate(context,
                                        'favorite_add_remove.removed_favorites')),
                                duration: const Duration(milliseconds: 1500),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: Icon(
                            beach[index]['isfavorite'] == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 20,
                            color: whiteColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      beach[index]['title'].toString(),
                      style: semibold16primary,
                    ),
                    subtitle: Text(
                      beach[index]['subtitle'].toString(),
                      style: regular12grey,
                    ),
                    childrenPadding: const EdgeInsets.only(
                        left: fixPadding * 2,
                        right: fixPadding * 2,
                        bottom: fixPadding),
                    children: const [
                      Text(
                        "Amet mivnim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet. Velit officia consequat duis enim velit mollit. ",
                        style: regular14grey,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  howtorich(BuildContext context, Size size) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(fixPadding * 2),
        physics: const BouncingScrollPhysics(),
        children: [
          fromContainer(context, size),
          heightSpace,
          height5Space,
          Text(
            getTranslate(context, 'things_to_do.book_trip'),
            style: semibold18blackw600,
          ),
          heightSpace,
          height5Space,
          flightInfo(size)
        ],
      ),
    );
  }

  flightInfo(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslate(context, 'things_to_do.flight'),
          style: medium16black,
        ),
        height5Space,
        Container(
          padding: const EdgeInsets.all(fixPadding),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: grey94Color.withOpacity(0.5),
                blurRadius: 5,
              )
            ],
          ),
          child: Column(
            children: [
              const Text(
                "Bali",
                style: medium14black,
              ),
              heightSpace,
              rootinfo(size),
              heightSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      const Text(
                        "\$200",
                        style: medium16primary,
                      ),
                      Text(
                        getTranslate(context, 'things_to_do.approximatly'),
                        style: medium12grey94,
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Flights.routeName);
                    },
                    child: Text(
                      getTranslate(context, 'things_to_do.view_detail'),
                      style: regular12primary,
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  rootinfo(Size size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Mumbai",
          style: medium14grey94.copyWith(height: 1.7),
        ),
        widthSpace,
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: FittedBox(
                      child: Text(
                        "----------------",
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.04,
                    width: size.height * 0.04,
                    margin:
                        const EdgeInsets.symmetric(horizontal: fixPadding / 2),
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
                  const Expanded(
                    child: FittedBox(
                      child: Text(
                        "----------------",
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                  ),
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
                    "8 hr",
                    style: medium12grey94,
                  )
                ],
              )
            ],
          ),
        ),
        widthSpace,
        Text(
          "Bali",
          style: medium14grey94.copyWith(height: 1.7),
        )
      ],
    );
  }

  fromContainer(BuildContext context, Size size) {
    return GestureDetector(
      onTap: () {
        selectCityDailog(context, size);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: fixPadding,
          horizontal: fixPadding * 2,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getTranslate(context, 'things_to_do.from'),
                  style: semibold14black,
                ),
                Text(
                  selectedCityName,
                  style: medium14grey94,
                )
              ],
            ),
            const Icon(
              Icons.border_color_sharp,
              size: 20,
              color: primaryColor,
            )
          ],
        ),
      ),
    );
  }

  restaurantsList(Size size) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(fixPadding * 2),
        itemCount: restaurants.length,
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: fixPadding * 2,
            crossAxisSpacing: fixPadding * 2,
            childAspectRatio: size.width / (size.height / 1.65),
            crossAxisCount: 2),
        itemBuilder: (context, index) {
          int starrate = restaurants[index]['rate'] as int;
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/restaurantdetail');
            },
            child: Container(
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
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        child: Image.asset(
                          restaurants[index]['image'].toString(),
                          height: size.height * 0.17,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isRestaurantFavorite =
                                  restaurants[index]['isfavorite'] as bool;
                              restaurants[index]['isfavorite'] =
                                  !isRestaurantFavorite!;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: blackColor,
                                content: restaurants[index]['isfavorite'] ==
                                        true
                                    ? Text(getTranslate(context,
                                        'favorite_add_remove.added_favorites'))
                                    : Text(getTranslate(context,
                                        'favorite_add_remove.removed_favorites')),
                                duration: const Duration(milliseconds: 1500),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: Icon(
                            restaurants[index]['isfavorite'] == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 21,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: fixPadding / 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            restaurants[index]['name'].toString(),
                            style: semibold14black,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
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
              Navigator.pushNamed(context, '/hoteldetail');
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
                      width: size.width * 0.34,
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
                                "684 ${getTranslate(context, 'things_to_do.review')}",
                                style: medium14grey94.copyWith(
                                  color: const Color(0xff8A7F7F),
                                ),
                              ),
                              Text(
                                "\$56${getTranslate(context, 'things_to_do.per_night')}",
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

  attractionlist(Size size) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: attractions.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, PlaceDetail.routeName);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: fixPadding * 2, vertical: fixPadding),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: grey94Color.withOpacity(0.5),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(5)),
                        child: Image.asset(
                          attractions[index]['image'].toString(),
                          height: size.height * 0.17,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isAttractionFavorite =
                                  attractions[index]['isfavorite'] as bool;
                              attractions[index]['isfavorite'] =
                                  !isAttractionFavorite!;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: blackColor,
                                content: attractions[index]['isfavorite'] ==
                                        true
                                    ? Text(getTranslate(context,
                                        'favorite_add_remove.added_favorites'))
                                    : Text(getTranslate(context,
                                        'favorite_add_remove.removed_favorites')),
                                duration: const Duration(milliseconds: 1500),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: Icon(
                            attractions[index]['isfavorite'] == true
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 20,
                            color: whiteColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  ExpansionTile(
                    title: Text(
                      attractions[index]['title'].toString(),
                      style: semibold16primary,
                    ),
                    subtitle: Text(
                      attractions[index]['subtitle'].toString(),
                      style: regular12grey,
                    ),
                    childrenPadding: const EdgeInsets.only(
                        left: fixPadding * 2,
                        right: fixPadding * 2,
                        bottom: fixPadding),
                    children: const [
                      Text(
                        "Amet mivnim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet. Velit officia consequat duis enim velit mollit. ",
                        style: regular14grey,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  selectCityDailog(BuildContext context, Size size) {
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
                getTranslate(context, 'things_to_do.select_city'),
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
                          selectedCityName = cityList[index]['name'].toString();
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
                        border: selectedCityName == cityList[index]['name']
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

  toplist(Size size) {
    return SizedBox(
      height: size.height * 0.08,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: fixPadding * 1.5),
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: thingsToDoList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                vertical: fixPadding, horizontal: fixPadding / 1.5),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedindex = index;
                  appbarname = thingsToDoList[index]['title'].toString();
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: fixPadding * 2, vertical: fixPadding / 2),
                decoration: BoxDecoration(
                  color: selectedindex == index ? primaryColor : whiteColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: grey94Color.withOpacity(0.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  thingsToDoList[index]['name'].toString(),
                  style:
                      selectedindex == index ? semibold14white : semibold14grey,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
