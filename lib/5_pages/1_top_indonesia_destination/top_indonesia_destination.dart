import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/models/city_model.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/1_detail/detail.dart';

class TopIndonesiaDestination extends StatelessWidget {
  static const routeName = '/top_indonesia_destination';

  final List<CityModel> cities;

  const TopIndonesiaDestination({super.key, required this.cities});

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
        itemCount: cities.length,
        itemBuilder: (context, index) {
          if (cities.isEmpty) {
            return const Center(child: Text('NO DATA'));
          }
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                DetailScreen.routeName,
                arguments: cities[index],
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(cities[index].image)),
              ),
              child: Container(
                padding: const EdgeInsets.only(bottom: fixPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                  gradient: LinearGradient(
                    colors: [
                      blackColor.withOpacity(0.07),
                      blackColor.withOpacity(0.1),
                      blackColor.withOpacity(0.2),
                      blackColor.withOpacity(0.3),
                      blackColor.withOpacity(0.6),
                      blackColor.withOpacity(0.9),
                    ],
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                  ),
                ),
                alignment: Alignment.bottomCenter,
                child: Text(
                  cities[index].title,
                  style: semibold18white,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
