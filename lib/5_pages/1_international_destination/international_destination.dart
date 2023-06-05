import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/5_pages/1_detail/detail.dart';
import 'package:tour_a_vlog/5_pages/1_search/search.dart';

class InternationalDestination extends StatefulWidget {
  static const routeName = '/international_destination';

  const InternationalDestination({super.key});

  @override
  State<InternationalDestination> createState() =>
      _InternationalDestinationState();
}

class _InternationalDestinationState extends State<InternationalDestination> {
  bool isExpanded = false;

  final internationalDestination = [
    {
      "image": "assets/internationaldestination/Rectangle 137.png",
      "name": "Bali",
      "desc": "Tropical Beach Paradise",
      "isfavorite": false,
    },
    {
      "image": "assets/internationaldestination/Rectangle 137 (1).png",
      "name": "Maldives",
      "desc": "A Stunning Tropical Getaway",
      "isfavorite": false,
    },
    {
      "image": "assets/internationaldestination/Rectangle 137 (2).png",
      "name": "Tokyo",
      "desc": "A Bustling Metropolis in Japan",
      "isfavorite": false,
    },
    {
      "image": "assets/internationaldestination/Rectangle 137 (3).png",
      "name": "Istanbul",
      "desc": "Gateway to Europe",
      "isfavorite": false,
    },
    {
      "image": "assets/internationaldestination/Rectangle 137 (4).png",
      "name": "Barcelona",
      "desc": "The City of Art & Architecture",
      "isfavorite": false,
    },
    {
      "image": "assets/internationaldestination/Rectangle 137 (5).png",
      "name": "Krabi",
      "desc": "Tropical Paradise in Thailand",
      "isfavorite": false,
    },
  ];

  bool? isFavorite;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        children: [
          topContainer(size, context),
          internationalDestinationList(size)
        ],
      ),
    );
  }

  internationalDestinationList(Size size) {
    return Expanded(
      child: ListView.builder(
          itemCount: internationalDestination.length,
          padding: const EdgeInsets.all(fixPadding),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, DetailScreen.routeName);
              },
              child: Container(
                margin: const EdgeInsets.all(fixPadding),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: grey94Color.withOpacity(0.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(5)),
                          child: Image.asset(
                            internationalDestination[index]['image'].toString(),
                            height: size.height * 0.2,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            onPressed: () {
                              isFavorite = internationalDestination[index]
                                  ['isfavorite'] as bool;
                              setState(() {
                                internationalDestination[index]['isfavorite'] =
                                    !isFavorite!;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: blackColor,
                                  content: internationalDestination[index]
                                              ['isfavorite'] ==
                                          true
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
                              internationalDestination[index]['isfavorite'] ==
                                      true
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: whiteColor,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                    ExpansionTile(
                      title: Text(
                        internationalDestination[index]['name'].toString(),
                        style: semibold16primary,
                      ),
                      subtitle: Text(
                        internationalDestination[index]['desc'].toString(),
                        style: regular12grey,
                      ),
                      childrenPadding: const EdgeInsets.only(
                          left: fixPadding * 2,
                          right: fixPadding * 2,
                          bottom: fixPadding * 2),
                      children: const [
                        Text(
                          "Amet mivnim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet. Velit officia consequat duis enim velit mollit. ",
                          style: regular14grey,
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  topContainer(Size size, BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: fixPadding),
      width: double.infinity,
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
                  getTranslate(context,
                      'international_destination.international_destination'),
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
              child: TextField(
                onTap: () {
                  Navigator.pushNamed(context, SearchScreen.routeName);
                },
                readOnly: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: grey94Color,
                    size: 20,
                  ),
                  hintText:
                      getTranslate(context, 'international_destination.search'),
                  hintStyle: medium16grey.copyWith(height: 1.3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
