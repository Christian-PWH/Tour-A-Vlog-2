import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:tour_a_vlog/5_pages/1_international_destination/international_destination.dart';

class LatestCollection extends StatelessWidget {
  static const routeName = '/latest_collection';

  LatestCollection({super.key});

  final latestCollectionList = [
    {
      "image": "assets/home/latestCollection1.png",
      "name": "Stay like a celebrity at 5 maldives resorts",
      "places": 5,
    },
    {
      "image": "assets/home/latestCollection4.png",
      "name": "Most Booked inter'l destination",
      "places": 5,
    },
    {
      "image": "assets/home/latestCollection2.png",
      "name": "Hill hideaways for summer break",
      "places": 4,
    },
    {
      "image": "assets/home/latestCollection6.png",
      "name": "Topromentic place for couple",
      "places": 4,
    },
    {
      "image": "assets/home/latestCollection3.png",
      "name": "Luxury  villas with stunning pools",
      "places": 8,
    },
    {
      "image": "assets/home/latestCollection5.png",
      "name": "Top indian destination for family trip",
      "places": 5,
    },
  ];

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
          getTranslate(context, 'latest_collection.latest_collection'),
          style: semibold18white.copyWith(fontWeight: FontWeight.w600),
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
      body: GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(fixPadding * 2),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: fixPadding * 2,
            crossAxisSpacing: fixPadding * 2,
            childAspectRatio: size.width / (size.height / 1.55),
          ),
          itemCount: latestCollectionList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                    context, InternationalDestination.routeName);
              },
              child: Container(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.asset(
                        latestCollectionList[index]['image'].toString(),
                        height: size.height * 0.15,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: fixPadding / 2, horizontal: fixPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(latestCollectionList[index]['name'].toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: medium14black33),
                            Text(
                              "${latestCollectionList[index]['places']} ${getTranslate(context, 'latest_collection.places')}",
                              style: medium14grey94,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
