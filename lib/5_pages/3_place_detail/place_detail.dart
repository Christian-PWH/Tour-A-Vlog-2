import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/1_review/review.dart';
import 'package:tour_a_vlog/5_pages/3_similar_place/similar_place.dart';

class PlaceDetail extends StatefulWidget {
  static const routeName = '/place_detail';
  const PlaceDetail({super.key});

  @override
  State<PlaceDetail> createState() => _PlaceDetailState();
}

class _PlaceDetailState extends State<PlaceDetail> {
  bool isFavorite = false;

  bool? issimilarFavorite;

  final similarPlaces = [
    {
      "image": "assets/placedetail/similarplace1.png",
      "title": "Visit Climbing Mount Batur",
      "isfavorite": false,
    },
    {
      "image": "assets/placedetail/similarplace2.png",
      "title": "Visit diving in Tulamben",
      "isfavorite": false,
    },
    {
      "image": "assets/placedetail/similarplace3.png",
      "title": "Visit Rafting on Ayung River",
      "isfavorite": false,
    },
    {
      "image": "assets/placedetail/similarplace4.png",
      "title": "Visit Climbing Mount Batur",
      "isfavorite": false,
    },
    {
      "image": "assets/placedetail/similarplace5.png",
      "title": "Visit diving in Tulamben",
      "isfavorite": false,
    }
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
                "assets/placedetail/Rectangle 138 (1).png",
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
                time(),
                heightSpace,
                similarplaceList(size),
                heightSpace,
                reviewList(size),
                heightSpace,
                heightSpace,
              ],
            ),
          )
        ],
      ),
    );
  }

  reviewList(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, 'place_detail.review'),
            style: semibold16black,
          ),
          heightSpace,
          reviewdetail(size),
          const Divider(thickness: 2, color: Color(0xfff0f0f0), height: 20),
          reviewdetail(size),
          heightSpace,
          heightSpace,
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ReviewScreen.routeName);
            },
            child: Container(
              height: size.height * 0.07,
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
              alignment: Alignment.center,
              child: Text(
                getTranslate(context, 'place_detail.view_more'),
                style: semibold16primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  reviewdetail(Size size) {
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image:
                              AssetImage("assets/restaurantdetail/review1.png"),
                        ),
                      ),
                    ),
                    widthSpace,
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jeni patel",
                          style: semibold16black,
                        ),
                        Text(
                          "Gujrat",
                          style: medium12grey94,
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

  similarplaceList(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
          child: Text(
            getTranslate(context, 'place_detail.similar_places'),
            style: semibold16black,
          ),
        ),
        heightSpace,
        SizedBox(
          height: size.height * 0.32,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: fixPadding),
            itemCount: similarPlaces.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: fixPadding, vertical: fixPadding / 2),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SimilarPlace.routeName);
                  },
                  child: Container(
                    width: size.width * 0.42,
                    height: size.height * 0.32,
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
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(10)),
                              child: Image.asset(
                                similarPlaces[index]['image'].toString(),
                                height: size.height * 0.18,
                                width: size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    issimilarFavorite = similarPlaces[index]
                                        ['isfavorite'] as bool;
                                    similarPlaces[index]['isfavorite'] =
                                        !issimilarFavorite!;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: blackColor,
                                      content: similarPlaces[index]
                                                  ['isfavorite'] ==
                                              true
                                          ? Text(getTranslate(context,
                                              'favorite_add_remove.added_favorites'))
                                          : Text(getTranslate(context,
                                              'favorite_add_remove.removed_favorites')),
                                      duration:
                                          const Duration(milliseconds: 1500),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                },
                                icon: Icon(
                                  similarPlaces[index]['isfavorite'] == true
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: whiteColor,
                                  size: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(fixPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  similarPlaces[index]['title'].toString(),
                                  style: medium14primary,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const Text(
                                  "Amazing sunset point",
                                  style: medium12grey94,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  time() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, 'place_detail.time_visit'),
            style: semibold16black,
          ),
          height5Space,
          const Text(
            "10:00 AM to 7:00 PM",
            style: medium14grey94,
          )
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
            getTranslate(context, 'place_detail.details'),
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
            "Tegallalang Rice Terraces",
            style: semibold18primary,
          ),
          height5Space,
          RichText(
            text: TextSpan(
              text: "Bali",
              style: semibold16black.copyWith(color: grey94Color),
              children: const [
                TextSpan(text: "(Indonesia)", style: regular14grey),
              ],
            ),
          ),
          height5Space,
          Row(
            children: [
              for (int i = 0; i < 5; i++)
                Icon(
                  Icons.star,
                  size: 18,
                  color: (i < 4) ? starColor : grey94Color,
                )
            ],
          ),
        ],
      ),
    );
  }
}
