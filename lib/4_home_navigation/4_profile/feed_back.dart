import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';

class FeedbackScreen extends StatefulWidget {
  static const routeName = '/feedback';

  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  TextEditingController feedbackController = TextEditingController();

  final emojilist = [
    {
      "image1": "assets/profile/emojione_disappointed-face.png",
      "image2": "assets/profile/emojione_disappointed-face (1).png",
      "id": 0
    },
    {
      "image1": "assets/profile/emojione_frowning-face.png",
      "image2": "assets/profile/emojione_frowning-face (1).png",
      "id": 1
    },
    {
      "image1": "assets/profile/emojione_neutral-face.png",
      "image2": "assets/profile/emojione_neutral-face (1).png",
      "id": 2
    },
    {
      "image1": "assets/profile/emojione_slightly-smiling-face.png",
      "image2": "assets/profile/emojione_slightly-smiling-face (1).png",
      "id": 3
    },
    {
      "image1":
          "assets/profile/emojione_smiling-face-with-smiling-eyes (1).png",
      "image2": "assets/profile/emojione_smiling-face-with-smiling-eyes.png",
      "id": 4
    },
  ];

  int? selectedrate;

  @override
  void initState() {
    selectedrate = emojilist[4]['id'] as int;
    super.initState();
  }

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
            color: whiteColor,
          ),
        ),
        titleSpacing: 0,
        title: Text(
          getTranslate(context, 'feed_back.feedback'),
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
      body: ListView(
        padding: const EdgeInsets.all(fixPadding * 2),
        physics: const BouncingScrollPhysics(),
        children: [
          feedbackContainer(size),
          heightBox(30.0),
          submiteButton(size),
          cancelButton(context),
        ],
      ),
    );
  }

  cancelButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        getTranslate(context, 'feed_back.cancel'),
        style: medium16primary,
      ),
    );
  }

  submiteButton(Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: size.height * 0.07,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: gradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.25),
              blurRadius: 5,
            )
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          getTranslate(context, 'feed_back.submit'),
          style: semibold18white,
        ),
      ),
    );
  }

  feedbackContainer(Size size) {
    return SizedBox(
      height: size.height * 0.71,
      width: double.infinity,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/profile/Feedback-pana 1.png",
              height: size.height * 0.23,
              width: size.height * 0.23,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.51,
              width: double.infinity,
              padding: const EdgeInsets.all(fixPadding * 2),
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
                children: [
                  Text(
                    getTranslate(context, 'feed_back.give_feedback'),
                    style: semibold18black,
                  ),
                  height5Space,
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sem maecenas proin nec, turpis iaculis viverra massa",
                    style: regular14grey,
                    textAlign: TextAlign.center,
                  ),
                  heightSpace,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: emojilist
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: fixPadding / 2),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedrate = e['id'] as int;
                                  });
                                },
                                child: Image.asset(
                                  selectedrate == (e['id'] as int)
                                      ? e['image2'].toString()
                                      : e['image1'].toString(),
                                  height: size.height * 0.06,
                                  width: size.height * 0.06,
                                ),
                              ),
                            ),
                          )
                          .toList()),
                  heightSpace,
                  height5Space,
                  feedbackField(size),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  feedbackField(Size size) {
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
        controller: feedbackController,
        enabled: true,
        minLines: null,
        maxLines: null,
        cursorColor: primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: getTranslate(context, 'feed_back.write_something'),
          hintStyle: regular14grey,
        ),
      ),
    );
  }
}
