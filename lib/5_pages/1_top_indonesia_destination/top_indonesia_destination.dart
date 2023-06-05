import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/1_detail/detail.dart';

class TopIndonesiaDestination extends StatelessWidget {
  static const routeName = '/top_indonesia_destination';
  TopIndonesiaDestination({super.key});

  final topDestination = [
    {"image": "assets/topindiandestination/tid1.png", "name": "Jakarta"},
    {"image": "assets/topindiandestination/tid2.png", "name": "Medan"},
    {"image": "assets/topindiandestination/tid3.png", "name": "Bali"},
    {"image": "assets/topindiandestination/tid4.png", "name": "Palembang"},
    {"image": "assets/topindiandestination/tid5.png", "name": "Lampung"},
    {"image": "assets/topindiandestination/tid6.png", "name": "Pontianak"},
    {"image": "assets/topindiandestination/tid7.png", "name": "Manado"},
    {"image": "assets/topindiandestination/tid8.png", "name": "Makassar"},
    {"image": "assets/topindiandestination/tid9.png", "name": "Ambon"},
    {"image": "assets/topindiandestination/tid10.png", "name": "NTB"},
  ];

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
          getTranslate(context, 'Top Indonesia destination'),
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
        itemCount: topDestination.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, DetailScreen.routeName);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        AssetImage(topDestination[index]['image'].toString())),
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
                  topDestination[index]['name'].toString(),
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
