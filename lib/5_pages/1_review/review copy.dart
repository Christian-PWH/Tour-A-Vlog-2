import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';

class ReviewScreen extends StatelessWidget {
  static const routeName = '/review';

  final ratelist = [
    {"image": "assets/review/Ellipse 10.png", "name": "Jeni patel", "rate": 4},
    {
      "image": "assets/review/Ellipse 10 (1).png",
      "name": "Jenny Wilson",
      "rate": 3
    },
    {
      "image": "assets/review/Ellipse 10 (2).png",
      "name": "Jacob Jones",
      "rate": 2
    },
    {
      "image": "assets/review/Ellipse 10 (3).png",
      "name": "Cody Fisher",
      "rate": 5
    },
    {
      "image": "assets/review/Ellipse 10 (4).png",
      "name": "Wade Warren",
      "rate": 4
    },
    {
      "image": "assets/review/Ellipse 10 (5).png",
      "name": "Devon Lane",
      "rate": 3
    },
    {
      "image": "assets/review/Ellipse 10 (6).png",
      "name": "Jacob Jones",
      "rate": 3
    },
    {
      "image": "assets/review/Ellipse 10 (7).png",
      "name": "Marvin McKinney",
      "rate": 5
    },
  ];

  ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 22,
          ),
        ),
        title: Text(
          getTranslate(context, 'review.review'),
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
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2, vertical: fixPadding),
        physics: const BouncingScrollPhysics(),
        itemCount: ratelist.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: fixPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
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
                                  image: AssetImage(
                                      ratelist[index]['image'].toString()),
                                ),
                              ),
                            ),
                            widthSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ratelist[index]['name'].toString(),
                                  style: semibold16black,
                                ),
                                height5Space,
                                Row(
                                  children: [
                                    for (int i = 0; i < 5; i++)
                                      Icon(
                                        Icons.star_sharp,
                                        size: 16,
                                        color: (i <
                                                (ratelist[index]['rate']
                                                    as int))
                                            ? starColor
                                            : grey94Color,
                                      )
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                height5Space,
                const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Leo ut in euismod gravida enim aenean. Fermentum, potenti facilisis quis facilisi amet, natoque molestie. Amet leo vitae sed nec, tincidunt adipiscing pretium justo. ",
                    style: medium12grey94)
              ],
            ),
          );
        },
      ),
    );
  }
}
