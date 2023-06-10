import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/1_package_detail.dart/package_detail.dart';

class Packages extends StatefulWidget {
  static const routeName = '/packages';

  const Packages({super.key});

  @override
  State<Packages> createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
  final packages = [
    {
      "name": "Experiance Bali in your Budgets",
      "days": "4N/5D",
      "image": "assets/packages/package1.png",
      "isfavorite": false
    },
    {
      "name": "Bali Supar saver package",
      "days": "5N/6D",
      "image": "assets/packages/package2.png",
      "isfavorite": false
    },
    {
      "name": "Romentic honymoon tour",
      "days": "5N/6D",
      "image": "assets/packages/package3.png",
      "isfavorite": false
    },
    {
      "name": "Pool Villa Special tour",
      "days": "7N/8D",
      "image": "assets/packages/package4.png",
      "isfavorite": false
    },
    {
      "name": "Bali supar vacation tour",
      "days": "3N/4D",
      "image": "assets/packages/package5.png",
      "isfavorite": false
    }
  ];

  bool? isFavorite;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 22,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: Text(
          getTranslate(context, 'packages.package'),
          style: semibold18white,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: packages.length,
        padding: const EdgeInsets.all(fixPadding * 2),
        physics: const BouncingScrollPhysics(),
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
                          packages[index]['image'].toString(),
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
                              isFavorite =
                                  packages[index]['isfavorite'] as bool;
                              packages[index]['isfavorite'] = !isFavorite!;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: blackColor,
                                content: packages[index]['isfavorite'] == true
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
                            packages[index]['isfavorite'] == true
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
                              packages[index]['name'].toString(),
                              style: medium16black.copyWith(
                                  fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                            heightBox(2.0),
                            const Text(
                              "Flight, activity, airport transfers",
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
                                        context, 'packages.per_person'),
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
                            horizontal: fixPadding, vertical: fixPadding / 2),
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
                          packages[index]['days'].toString(),
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
      ),
    );
  }
}
