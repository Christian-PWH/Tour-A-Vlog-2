import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/languages.dart';

class WriteMessageScreen extends StatefulWidget {
  static const routeName = '/write_message';

  const WriteMessageScreen({super.key});

  @override
  State<WriteMessageScreen> createState() => _WriteMessageScreenState();
}

class _WriteMessageScreenState extends State<WriteMessageScreen> {
  TextEditingController textEditingController = TextEditingController();
  final messagelist = [
    {
      "message": "Hii, please help me! ",
      "itsMe": false,
    },
    {
      "message": "Hii, how can i help you?",
      "itsMe": true,
    },
    {
      "message":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Iaculis sed sodales purus ",
      "itsMe": false,
    },
    {
      "message": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      "itsMe": true,
    },
    {
      "message": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
      "itsMe": false,
    },
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
          getTranslate(context, 'write_message.write_message'),
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
      body: Column(
        children: [
          messageList(),
          messageField(),
        ],
      ),
    );
  }

  messageList() {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2),
        itemCount: messagelist.length,
        reverse: true,
        itemBuilder: ((context, index) {
          int reverseindex = messagelist.length - 1 - index;
          return Column(
            crossAxisAlignment: messagelist[reverseindex]['itsMe'] == true
                ? languageValue == "عربي"
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end
                : languageValue == "عربي"
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(fixPadding),
                margin: messagelist[reverseindex]['itsMe'] == true
                    ? const EdgeInsets.only(
                        left: 70, bottom: fixPadding, top: fixPadding)
                    : const EdgeInsets.only(
                        right: 70, bottom: fixPadding, top: fixPadding),
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
                child: Text(
                  messagelist[reverseindex]['message'].toString(),
                  style: semibold14black,
                  textAlign: messagelist[reverseindex]['itsMe'] == true
                      ? TextAlign.right
                      : TextAlign.left,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  messageField() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            margin: const EdgeInsets.only(
                left: fixPadding * 2, right: fixPadding, bottom: fixPadding),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: primaryColor),
              boxShadow: [
                BoxShadow(
                  color: grey94Color.withOpacity(0.3),
                  blurRadius: 5,
                ),
              ],
            ),
            child: TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: ShaderMask(
                    shaderCallback: (bounds) {
                      return const LinearGradient(
                        colors: gradient,
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(bounds);
                    },
                    child: const Icon(Icons.emoji_emotions_outlined,
                        color: whiteColor)),
                suffixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Transform.rotate(
                        angle: 0.8,
                        child:
                            const Icon(Icons.attach_file, color: blackColor)),
                    const Icon(Icons.mic, color: blackColor),
                  ],
                ),
                suffixIconConstraints: const BoxConstraints(
                  maxWidth: 60,
                ),
                hintText: getTranslate(context, 'write_message.message'),
                hintStyle: medium16grey,
              ),
            ),
          ),
        ),
        Container(
          height: 50,
          width: 50,
          margin: const EdgeInsets.only(
              left: fixPadding, right: fixPadding, bottom: fixPadding),
          padding: const EdgeInsets.only(left: 3),
          decoration: BoxDecoration(
            color: whiteColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: primaryColor,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: grey94Color.withOpacity(0.5),
                blurRadius: 5,
              ),
            ],
          ),
          child: ShaderMask(
            shaderCallback: (bounds) {
              return const LinearGradient(
                colors: gradient,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            child: IconButton(
              onPressed: () {
                setState(() {
                  if (textEditingController.text.isEmpty) {
                    null;
                  } else {
                    messagelist.add({
                      "message": textEditingController.text,
                      "itsMe": true,
                    });
                  }
                });
                messagelist;
                textEditingController.clear();
              },
              icon: const Icon(
                Icons.send_rounded,
                color: whiteColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
