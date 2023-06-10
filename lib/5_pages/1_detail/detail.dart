import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/1_package_detail.dart/package_detail.dart';
import 'package:tour_a_vlog/5_pages/1_packages/packages.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail';

  final Map<String, dynamic> detailMap, cityMap;

  const DetailScreen(
      {super.key, required this.detailMap, required this.cityMap});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  bool isFavorite = false;

  TabController? tabController;

  int selectedTab = 0;

  bool? packageFavorite;

  Map<String, dynamic> rawMap = {};

  Map<String, dynamic> cityMap = {};

  @override
  void initState() {
    setState(() {
      rawMap = widget.detailMap;
      cityMap = widget.cityMap;
    });
    tabController = TabController(length: 1, vsync: this);
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
                "assets/auth/signin.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [tabs(size), if (selectedTab == 0) firstTabView(size)],
            ),
          )
        ],
      ),
    );
  }

  firstTabView(Size size) {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  "${cityMap["title"]} ${getTranslate(context, 'packages.package')} (${rawMap.length})",
                  style: semibold16black,
                ),
              ),
              InkWell(
                onTap: () {
                  Map<String, dynamic> newMapBasedOnCity = {};
                  rawMap.forEach(
                        (key, value) {
                      Map<String, dynamic> newRawMap = rawMap[key];
                      if (newRawMap["city"]
                          .toString()
                          .contains(cityMap["title"])) {
                        newMapBasedOnCity
                            .addEntries({key: value}.entries);
                      }
                    },
                  );
                  Navigator.pushNamed(context, Packages.routeName, arguments: newMapBasedOnCity,);
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
            itemCount: rawMap.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> detailItem =
                  rawMap[rawMap.keys.elementAt(index)];
              List<String> detailItemImage = detailItem["image"];
              if (rawMap.isEmpty) {
                return const Center(
                  child: Text("Data is Empty!"),
                );
              }
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, PackageDetail.routeName,
                      arguments: detailItem);
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
                            child: Image.network(
                              detailItemImage[0],
                              height: size.height * 0.17,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, event) {
                                if (event == null) return child;
                                return Center(
                                  child: SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: CircularProgressIndicator(
                                      value: event.cumulativeBytesLoaded /
                                          (event.expectedTotalBytes ?? 1),
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, object, stacktrace) {
                                return const Center(
                                  child: SizedBox(
                                    width: 20.0,
                                    height: 20.0,
                                    child: Icon(Icons.image_not_supported),
                                  ),
                                );
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                isFavorite == true
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
                                  detailItem['title'].toString(),
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
                                    text: "\Rp ${detailItem['price']}",
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
                              detailItem['details'].toString(),
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
        TabBar(
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
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: Tab(
                    text:
                        "${cityMap["title"]} ${getTranslate(context, 'packages.package')}",
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
