import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';

class LegalInformation extends StatelessWidget {
  static const routeName = '/legal_information';

  const LegalInformation({super.key});

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
          getTranslate(context, 'legal_info.legal_information'),
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
        children: const [
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Senectus pellentesque justo, quis varius dictumst pellentesque pellentesque. Mattis nibh arcu dolor, elit auctor. Viverra et diam feugiat egestas in euismod orci, ",
            style: regular14black,
          ),
          heightSpace,
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ullamcorper pellentesque integer semper diam. Purus, enim ac nulla mattis sed curabitur tempus aenean nulla. Eleifend suspendisse habitant at vitae quis odio eget ridiculus ipsum. Sem justo et scelerisque ullamcorper sem condimentum dignissim cursus viverra. Tristique ultrices id eget enim, id augue. Dui egestas non dui non, aliquam sit scelerisque augue. Etiam proin pulvinar montes, pellentesque. Placerat facilisis diam, metus in. Dolor, dui nisl blandit arcu pretium, orci et tristique et.",
            style: regular14black,
          ),
          heightSpace,
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ullamcorper pellentesque integer semper diam. Purus, enim ac nulla mattis sed curabitur tempus aenean nulla. Eleifend suspendisse habitant at vitae quis odio eget ridiculus ipsum. Sem justo et scelerisque ullamcorper sem condimentum dignissim cursus viverra. Tristique ultrices id eget enim, id augue. Dui egestas non dui non, aliquam sit scelerisque augue. Etiam proin pulvinar montes, pellentesque. Placerat facilisis diam, metus in. Dolor, dui nisl blandit arcu pretium, orci et tristique et.",
            style: regular14black,
          ),
        ],
      ),
    );
  }
}
