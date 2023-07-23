// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/models/review_model.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:tour_a_vlog/1_common/widgets/show_snackbar.dart';
import 'package:tour_a_vlog/3_auth/controller/user_controller.dart';
import 'package:tour_a_vlog/4_home_navigation/4_profile/controller/review_vm.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/review_controller.dart';

class ReviewScreenArguments {
  final String tourId;
  final bool canEdit;

  ReviewScreenArguments({
    required this.tourId,
    required this.canEdit,
  });
}

class ReviewScreen extends ConsumerStatefulWidget {
  static const routeName = '/review';

  final String tourId;
  final bool canEdit;

  const ReviewScreen({super.key, required this.tourId, required this.canEdit});

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  // String get tourId => widget.tourId;
  String get tourId => "0909";
  bool get canEdit => widget.canEdit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final reviews = ref.watch(getReviewByTourIdProvider(tourId: tourId));
      reviews.whenData((value) => alreadyCommentCheck(value));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _commentCtl.dispose();
  }

  final _commentCtl = TextEditingController();

  void submit(context) async {
    debugPrint('SUBMIT');
    int star = ref.read(reviewStarProvider);
    if (_commentCtl.text.trim().isEmpty || star <= 0 || star > 5) {
      showSnackBar(context, Icons.cancel_outlined, Colors.red, 'Fill the empty',
          Colors.red);
      return;
    }
    final errMsg = await ref.read(reviewControllerProvider).save(
          tourId: tourId,
          star: star,
          comment: _commentCtl.text.trim(),
        );
    if (errMsg.isEmpty) {
      // await ref.refresh(getReviewByTourIdProvider(tourId: tourId).future);
      ref.invalidate(getReviewByTourIdProvider(tourId: tourId));
      return;
    }
    showSnackBar(context, Icons.cancel_outlined, Colors.red, errMsg.toString(),
        Colors.red);
  }

  void alreadyCommentCheck(List<ReviewModel> data) async {
    final currentUser =
        await ref.watch(userControllerProvider.notifier).getCurrentUser();
    if (currentUser == null) return;
    final idx = data.indexWhere((e) => e.user.uid == currentUser.uid);
    if (idx == -1) return;

    /// wanna update comment
    _commentCtl.text = data[idx].comment;
    // star = data[idx].star;
    ref.read(reviewStarProvider.notifier).update((state) => data[idx].star);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int star = ref.watch(reviewStarProvider);
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
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: reviewList(size),
          ),
          canEdit ? ratingStar(size, star) : Container(),
          canEdit ? inputReview() : Container(),
        ],
      ),
    );
  }

  Widget reviewList(Size size) {
    final reviews = ref.watch(getReviewByTourIdProvider(tourId: tourId));
    return reviews.when(
      data: (data) {
        // for (int i = 0; i < data.length; i++) debugPrint(data[i].toString());
        return ListView.builder(
          padding: const EdgeInsets.symmetric(
              horizontal: fixPadding * 2, vertical: fixPadding),
          physics: const BouncingScrollPhysics(),
          itemCount: data.length,
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
                                      image: NetworkImage(
                                          data[index].user.profilePicture ?? '')
                                      // image: AssetImage(
                                      //     ratelist[index]['image'].toString()),
                                      ),
                                ),
                              ),
                              widthSpace,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    // ratelist[index]['name'].toString(),
                                    data[index].user.fullName ?? 'anonymous',
                                    style: semibold16black,
                                  ),
                                  height5Space,
                                  Row(
                                    children: [
                                      for (int i = 0; i < 5; i++)
                                        Icon(
                                          Icons.star_sharp,
                                          size: 16,
                                          color: (i < data[index].star)
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
                  Text(
                    data[index].comment,
                    style: medium12grey94,
                  )
                ],
              ),
            );
          },
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stackTrace) {
        return const Center(child: Text('Error'));
      },
    );
  }

  Widget ratingStar(Size size, int star) {
    return SizedBox(
      width: size.width,
      height: 100.0,
      child: Card(
        elevation: 5.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslate(context, 'review.input_rating'),
                style: semibold14black,
              ),
              Center(
                child: RatingBar.builder(
                  initialRating: star.toDouble(),
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  unratedColor: Colors.amber.withAlpha(50),
                  itemCount: 5,
                  itemSize: 50.0,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    ref.read(reviewStarProvider.notifier).state =
                        rating.toInt();
                  },
                  updateOnDrag: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget inputReview() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 100.0,
            padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
            margin: const EdgeInsets.symmetric(vertical: fixPadding * 2),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: greyColor.withOpacity(0.5),
                  blurRadius: 5,
                )
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(primary: primaryColor),
              ),
              child: TextField(
                controller: _commentCtl,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: getTranslate(context, 'review.input_review'),
                  hintStyle: regular14grey,
                ),
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () => submit(context),
          icon: const Icon(Icons.send),
        )
      ],
    );
  }
}
