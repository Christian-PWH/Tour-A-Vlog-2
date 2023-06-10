import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:tour_a_vlog/5_pages/1_package_detail.dart/package_detail.dart';

class OpenTrip extends StatelessWidget {
  static const routeName = '/open_trip';

  final Map<String, dynamic> openTripMap;

  const OpenTrip({super.key, required this.openTripMap});

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
          getTranslate(context, 'open_trip.open_trip'),
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
            childAspectRatio: size.width / (size.height / 2),
          ),
          itemCount: openTripMap.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> tourItem =
                openTripMap[openTripMap.keys.elementAt(index)];
            List<String> tourImage = tourItem["image"];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  PackageDetail.routeName,
                  arguments: tourItem,
                );
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
                      child: Image.network(
                        tourImage[0],
                        height: size.height * 0.15,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: fixPadding / 2, horizontal: fixPadding),
                      child: Text(tourItem["title"].toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: medium14black33),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
