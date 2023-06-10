import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/1_detail/detail.dart';

class TopIndonesiaDestination extends StatelessWidget {
  static const routeName = '/top_indonesia_destination';

  final Map<String, dynamic> indonesiaCity;

  TopIndonesiaDestination({super.key, required this.indonesiaCity});

  final Map<String, dynamic> recommendationMap = {
    "-NV4pZeNKa_1da9VK8xz": {
      "category": "Beach",
      "city": "Bengkulu",
      "code": "BKL1",
      "customizationForDays": ["default 01", "default 02"],
      "details": "3d2n",
      "image": [
        "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/ToursImages%2F1683725111132-bengkulu.jpg?alt=media&token=2a497c86-23cb-496f-bbc7-17b30d2f39a1"
      ],
      "newprice": "213",
      "percent": 100,
      "price": "1000000",
      "status1": "recomen",
      "status2": "deal",
      "title": "Bengkulu trip",
      "type": "Open Trip"
    },
    "-NVUjdjo-mZNz3qMRe_B": {
      "category": "Mountain",
      "city": "Sumatra Barat",
      "code": "a4",
      "customizationForDays": ["default"],
      "details": "asdasd",
      "image": [
        "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/ToursImages%2F1684159772872-mountain.jpg?alt=media&token=067813de-ba97-494d-a6e7-99431aa947a4",
        "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/ToursImages%2F1684159772870-beach.webp?alt=media&token=577317e1-0d06-4dbc-ad18-c99026dd1e69",
        "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/ToursImages%2F1684159772871-budaya.jpg?alt=media&token=51927a15-40ed-4906-bb07-fa15ed4e1aba"
      ],
      "newprice": "213",
      "percent": 100,
      "price": "12313",
      "status1": "recomen",
      "status2": "deal",
      "title": "sadsad",
      "type": "Open Trip"
    },
    "-NW2U4zx094I5N4D3Vdc": {
      "category": "Mountain",
      "city": "Jawa Timur",
      "code": "2d",
      "customizationForDays": ["default"],
      "details": "sad",
      "image": [
        "https://firebasestorage.googleapis.com/v0/b/skripsi-6bd6c.appspot.com/o/ToursImages%2F1684759403334-budaya.jpg?alt=media&token=d81ea24a-6f26-4656-a2e9-14afe21127c1"
      ],
      "newprice": "53243",
      "percent": -22949,
      "price": "231",
      "status1": "",
      "status2": "deal",
      "title": "sadad",
      "type": "Private Tour"
    }
  };

  @override
  Widget build(BuildContext context) {
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
          getTranslate(context, 'home.indonesia_destination'),
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
      body: GridView.builder(
        padding: const EdgeInsets.all(fixPadding * 2),
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: fixPadding * 2,
          crossAxisSpacing: fixPadding * 2,
          childAspectRatio: 1.3,
        ),
        itemCount: indonesiaCity.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> indonesiaCityItem =
              indonesiaCity[indonesiaCity.keys.elementAt(index)];
          return GestureDetector(
            onTap: () {
              Map<String, dynamic> newMapBasedOnCity = {};
              recommendationMap.forEach(
                (key, value) {
                  Map<String, dynamic> rawMap = recommendationMap[key];
                  if (rawMap["city"]
                      .toString()
                      .contains(indonesiaCityItem["title"])) {
                    newMapBasedOnCity.addEntries({key: value}.entries);
                  }
                },
              );
              Navigator.pushNamed(
                context,
                DetailScreen.routeName,
                arguments: {
                  "arg_1": newMapBasedOnCity,
                  "arg_2": indonesiaCityItem,
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(indonesiaCityItem["image"].toString())),
              ),
              child: Container(
                padding: const EdgeInsets.only(bottom: fixPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      blackColor.withOpacity(0),
                      blackColor.withOpacity(0.02),
                      blackColor.withOpacity(0.07),
                      blackColor.withOpacity(0.1),
                      blackColor.withOpacity(0.2),
                      blackColor.withOpacity(0.5),
                      blackColor.withOpacity(0.6),
                    ],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                  ),
                ),
                alignment: Alignment.bottomCenter,
                child: Text(
                  indonesiaCityItem['title'].toString(),
                  style: semibold18white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
