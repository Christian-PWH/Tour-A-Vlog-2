import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/1_common/widgets/column_builder.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final recentSearch = [
    {
      "image": "assets/search/recent1.png",
      "title": "Bali",
    },
    {
      "image": "assets/search/recent2.png",
      "title": "Greece",
    },
    {
      "image": "assets/search/recent3.png",
      "title": "London",
    },
    {
      "image": "assets/search/recent4.png",
      "title": "Tokyo",
    },
  ];

  final trendingSearch = [
    {
      "image": "assets/search/top1.png",
      "title": "Top International destination",
      "navigate": "/topInternationalDestination"
    },
    {
      "image": "assets/search/top2.png",
      "title": "Top indian destination",
      "navigate": "/topIndianDestination"
    },
    {
      "image": "assets/search/top3.png",
      "title": "Honeymoon in bali",
      "navigate": "/detail"
    },
    {
      "image": "assets/search/top4.png",
      "title": "Tokyo",
      "navigate": "/detail"
    },
    {
      "image": "assets/search/top5.png",
      "title": "Adventure place",
      "navigate": "/internationalDestination"
    },
    {
      "image": "assets/search/top6.png",
      "title": "Greece",
      "navigate": "/detail"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          topContainer(size, context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(fixPadding * 2),
              physics: const BouncingScrollPhysics(),
              children: [
                recentSearch.isEmpty ? Container() : recentsearchList(size),
                heightSpace,
                trendingSearchList(size),
              ],
            ),
          )
        ],
      ),
    );
  }

  trendingSearchList(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getTranslate(context, 'search.trending_search'),
          style: semibold16black,
        ),
        heightSpace,
        ColumnBuilder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context, trendingSearch[index]['navigate'].toString());
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        trendingSearch[index]['image'].toString(),
                        height: size.height * 0.06,
                        width: size.height * 0.06,
                        fit: BoxFit.cover,
                      ),
                    ),
                    widthSpace,
                    Expanded(
                      child: Text(
                        trendingSearch[index]['title'].toString(),
                        style: semibold14black,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: trendingSearch.length,
        )
      ],
    );
  }

  recentsearchList(Size size) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getTranslate(context, 'search.recently_search'),
              style: semibold16black,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  recentSearch.clear();
                });
              },
              child: Text(
                getTranslate(context, 'search.clear_all'),
                style: medium14grey94,
              ),
            )
          ],
        ),
        heightSpace,
        ColumnBuilder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/detail');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: fixPadding / 2),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        recentSearch[index]['image'].toString(),
                        height: size.height * 0.035,
                        width: size.height * 0.035,
                        fit: BoxFit.cover,
                      ),
                    ),
                    widthSpace,
                    Expanded(
                      child: Text(
                        recentSearch[index]['title'].toString(),
                        style: semibold14black,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: recentSearch.length,
        )
      ],
    );
  }

  topContainer(Size size, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: fixPadding),
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
                  getTranslate(context, 'search.search'),
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
                    hintText: getTranslate(context, 'search.search_hint'),
                    hintStyle: medium16grey.copyWith(height: 1.3),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
