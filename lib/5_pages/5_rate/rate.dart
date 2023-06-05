import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';

class Rate extends StatefulWidget {
  static const routeName = '/rate';

  const Rate({super.key});

  @override
  State<Rate> createState() => _RateState();
}

class _RateState extends State<Rate> {
  int selectedIndex = 3;
  TextEditingController reviewController = TextEditingController();

  Widget _buildStar(int starcount) {
    return InkWell(
      child: Icon(Icons.star_rounded,
          size: 35,
          color: selectedIndex >= starcount ? primaryColor : grey94Color),
      onTap: () {
        setState(() {
          selectedIndex = starcount;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        getTranslate(context, 'rate.your_review'),
        style: semibold16black,
        textAlign: TextAlign.center,
      ),
      titlePadding: const EdgeInsets.all(fixPadding * 2),
      contentPadding: const EdgeInsets.only(
        left: fixPadding * 2,
        right: fixPadding * 2,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            getTranslate(context, 'rate.review_text'),
            style: medium14grey94,
          ),
          heightSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStar(0),
              _buildStar(1),
              _buildStar(2),
              _buildStar(3),
              _buildStar(4),
            ],
          ),
          heightSpace,
          reviewField(size),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                getTranslate(context, 'rate.send'),
                style: semibold18primary,
              ))
        ],
      ),
    );
  }

  reviewField(Size size) {
    return Container(
      height: size.height * 0.17,
      padding: const EdgeInsets.symmetric(horizontal: fixPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: grey94Color.withOpacity(0.5),
            blurRadius: 5,
          ),
        ],
      ),
      child: TextField(
        controller: reviewController,
        enabled: true,
        minLines: null,
        maxLines: null,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: getTranslate(context, 'rate.say_somthing'),
          hintStyle: medium16black,
        ),
      ),
    );
  }

  rateBox(Size size) {
    return SizedBox(
      height: size.height * 0.46,
      width: double.infinity,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.37,
              width: double.infinity,
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  height5Space,
                  Text(
                    getTranslate(context, 'rate.review_text'),
                    textAlign: TextAlign.center,
                    style: medium14grey94,
                  ),
                  heightSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildStar(0),
                      _buildStar(1),
                      _buildStar(2),
                      _buildStar(3),
                      _buildStar(4),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: size.height * 0.16,
                width: size.height * 0.16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: grey94Color.withOpacity(0.5),
                      blurRadius: 5,
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.thumb_up_rounded,
                  color: primaryColor,
                  size: 60,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
