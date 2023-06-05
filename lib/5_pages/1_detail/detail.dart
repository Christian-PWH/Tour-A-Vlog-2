import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/1_package_detail.dart/package_detail.dart';
import 'package:tour_a_vlog/5_pages/1_packages/packages.dart';
import 'package:tour_a_vlog/5_pages/1_review/review.dart';
import 'package:tour_a_vlog/5_pages/1_things_todo/things_to_do.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail';

  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  bool isFavorite = false;

  TabController? tabController;

  int selectedTab = 0;

  final images = [
    "assets/detail/Rectangle 120.png",
    "assets/detail/Rectangle 121.png",
    "assets/detail/Rectangle 122.png",
    "assets/detail/Rectangle 123.png",
    "assets/detail/Rectangle 123.png",
  ];

  final packagelist = [
    {
      "image": "assets/detail/package1.png",
      "title": "Experiance Bali in your Budgets",
      "days": "4N/5D",
      "isfavorite": false,
    },
    {
      "image": "assets/detail/package2.png",
      "title": "Bali Supar saver package",
      "days": "5N/6D",
      "isfavorite": false,
    },
    {
      "image": "assets/detail/package3.png",
      "title": "Romentic honymoon tour",
      "days": "5N/6D",
      "isfavorite": false,
    },
  ];

  bool? packageFavorite;

  final thingsDoList = [
    {
      "image": "assets/detail/thingstodo1.png",
      "name": "Attraction",
      "icon": Icons.public,
      "selectedpage": 0
    },
    {
      "image": "assets/detail/thingstodo2.png",
      "name": "Restaurants",
      "icon": Icons.restaurant,
      "selectedpage": 2
    },
    {
      "image": "assets/detail/thingstodo3.png",
      "name": "Hotel",
      "icon": Icons.hotel,
      "selectedpage": 1
    },
    {
      "image": "assets/detail/thingstodo4.png",
      "name": "How to reach there",
      "icon": Icons.map_sharp,
      "selectedpage": 3
    },
  ];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

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
            expandedHeight: size.height * 0.27,
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
                  setState(() {
                    isFavorite = !isFavorite;
                  });
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
                "assets/detail/Rectangle 138.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                detailTextStar(),
                tabs(size),
                if (selectedTab == 0) firstTabView(size),
                if (selectedTab == 1) secondTabView(),
                if (selectedTab == 2) thirdTabView(size)
              ],
            ),
          )
        ],
      ),
    );
  }

  thirdTabView(Size size) {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${getTranslate(context, 'detail.bali_packages')}(40)",
                style: semibold16black,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Packages.routeName);
                },
                child: Text(
                  getTranslate(context, 'detail.see_all'),
                  style: medium14black.copyWith(fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: fixPadding),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: packagelist.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PackageDetail.routeName);
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
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              packagelist[index]['image'].toString(),
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
                                  packageFavorite =
                                      packagelist[index]['isfavorite'] as bool;
                                  packagelist[index]['isfavorite'] =
                                      !packageFavorite!;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: blackColor,
                                    content:
                                        packagelist[index]['isfavorite'] == true
                                            ? Text(
                                                getTranslate(context,
                                                    'favorite_add_remove.added_favorites'),
                                              )
                                            : Text(
                                                getTranslate(context,
                                                    'favorite_add_remove.added_favorites'),
                                              ),
                                    duration:
                                        const Duration(milliseconds: 1500),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              icon: Icon(
                                packagelist[index]['isfavorite'] == true
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 20,
                                color: whiteColor,
                              ),
                            ),
                          )
                        ],
                      ),
                      height5Space,
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  packagelist[index]['title'].toString(),
                                  style: medium16black.copyWith(
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                heightBox(2.0),
                                Text(
                                  getTranslate(context, 'detail.detail_text'),
                                  style: medium14grey94,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                heightBox(2.0),
                                RichText(
                                  text: TextSpan(
                                    text: "\$11500",
                                    style: semibold16primary,
                                    children: [
                                      TextSpan(
                                        text: getTranslate(
                                            context, 'detail.per_person'),
                                        style: medium14black.copyWith(
                                          color: const Color(0xff585656),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: fixPadding,
                                vertical: fixPadding / 2),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.3),
                                  blurRadius: 5,
                                )
                              ],
                              border: Border.all(color: primaryColor),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              packagelist[index]['days'].toString(),
                              style: medium14primary,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  secondTabView() {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslate(context, 'detail.things_to_do'),
                style: semibold16black,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    ThingsToDo.routeName,
                  );
                },
                child: Text(
                  getTranslate(context, 'detail.see_all'),
                  style: medium14primary,
                ),
              )
            ],
          ),
          height5Space,
          const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque faucibus nullam accumsan cras nunc viverra pharetra. Natoque blandit pretium, molestie enim, vel. Eget donec arcu vitae aliquet. Hac quis tortor erat augue.",
            style: medium14grey94,
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: thingsDoList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.6,
                mainAxisSpacing: fixPadding * 2,
                crossAxisSpacing: fixPadding * 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThingsToDo(
                        selectedPage:
                            thingsDoList[index]['selectedpage'] as int,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: whiteColor,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        thingsDoList[index]['image'].toString(),
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          primaryColor.withOpacity(0.2),
                          blackColor.withOpacity(0.4),
                          blackColor.withOpacity(0.5),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(thingsDoList[index]['icon'] as IconData,
                            color: whiteColor),
                        Text(
                          thingsDoList[index]['name'].toString(),
                          style: semibold16white,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  firstTabView(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          detailInfoFT(),
          heightSpace,
          descriptionFT(),
          heightSpace,
          imagesFT(size),
          heightSpace,
          reviewFT(size),
          heightSpace,
          seeAllReview(size),
        ],
      ),
    );
  }

  reviewFT(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, 'detail.review'),
            style: semibold16black,
          ),
          heightSpace,
          reviewdetail(size, "assets/detail/Ellipse 10.png", "Jeni patel", 4),
          const Divider(
            color: Color(0xffF0F0F0),
            thickness: 2,
            height: 20,
          ),
          reviewdetail(
              size, "assets/detail/Ellipse 10 (1).png", "Kathryn Murphy", 3),
        ],
      ),
    );
  }

  imagesFT(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
          child: Text(
            getTranslate(context, 'detail.images'),
            style: semibold16black,
          ),
        ),
        heightSpace,
        SizedBox(
          height: size.height * 0.13,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: fixPadding),
            itemCount: images.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                width: size.width * 0.35,
                margin: const EdgeInsets.symmetric(horizontal: fixPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      images[index],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  descriptionFT() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, 'detail.description'),
            style: semibold16black,
          ),
          height5Space,
          const ReadMoreText(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque faucibus nullam accumsan cras nunc viverra pharetra. Natoque blandit pretium, molestie enim, vel. Eget donec arcu vitae aliquet. Hac quis tortor erat augue. Et orci, sit enim lectus. Neque sem quis porta id maecenas purus nibh egestas. Dictumst dolor consequat cursus integer sagittis donec sed readmore",
            style: medium14grey94,
            lessStyle: medium14primary,
            moreStyle: medium14primary,
          ),
        ],
      ),
    );
  }

  detailInfoFT() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getTranslate(context, 'detail.best_visit'),
            style: semibold16black,
          ),
          height5Space,
          Text(
            getTranslate(context, 'detail.months'),
            style: medium14grey94,
          ),
        ],
      ),
    );
  }

  seeAllReview(Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2, vertical: fixPadding),
      child: GestureDetector(
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
            getTranslate(context, 'detail.seeall_review'),
            style: semibold16primary,
          ),
        ),
      ),
    );
  }

  reviewdetail(Size size, String image, String name, int rate) {
    return Column(
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
                Row(
                  children: [
                    for (int i = 0; i < 5; i++)
                      Icon(
                        Icons.star,
                        size: 18,
                        color: i < rate ? starColor : grey94Color,
                      ),
                  ],
                )
              ],
            )
          ],
        ),
        height5Space,
        const Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Leo ut in euismod gravida enim aenean. Fermentum, potenti facilisis quis facilisi amet, natoque molestie. Amet leo vitae sed nec, tincidunt adipiscing pretium justo. ",
          style: medium12grey94,
        )
      ],
    );
  }

  tabs(Size size) {
    return Stack(
      children: [
        Container(
          height: size.height * 0.07,
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xfff0f0f0),
                width: 2,
              ),
            ),
          ),
        ),
        SizedBox(
          height: size.height * 0.07,
          width: size.height,
          child: TabBar(
            onTap: (index) {
              setState(() {
                selectedTab = index;
              });
            },
            controller: tabController,
            labelStyle: semibold16white.copyWith(fontWeight: FontWeight.bold),
            labelColor: primaryColor,
            unselectedLabelColor: grey94Color,
            unselectedLabelStyle:
                semibold16white.copyWith(fontWeight: FontWeight.bold),
            indicatorColor: primaryColor,
            tabs: [
              Tab(
                text: getTranslate(context, 'detail.about'),
              ),
              FittedBox(
                child: Tab(
                  text: getTranslate(context, 'detail.things_todo'),
                ),
              ),
              FittedBox(
                child: Tab(
                  text: getTranslate(context, 'detail.bali_packages'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  detailTextStar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: fixPadding, horizontal: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(getTranslate(context, 'detail.bali'),
                  style: semibold18primary),
              Text(getTranslate(context, 'detail.indonesia'),
                  style: regular14grey),
            ],
          ),
          height5Space,
          Row(
            children: [
              for (int i = 0; i < 5; i++)
                Icon(
                  Icons.star,
                  size: 18,
                  color:
                      i < 4 ? const Color(0xffEEA02C) : const Color(0xffb4b4b4),
                ),
            ],
          )
        ],
      ),
    );
  }
}
