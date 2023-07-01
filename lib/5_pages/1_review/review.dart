import 'package:flutter/material.dart';
import 'package:tour_a_vlog/1_common/localization/localization_const.dart';
import 'package:tour_a_vlog/1_common/models/review_model.dart';
import 'package:tour_a_vlog/1_common/theme/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_a_vlog/3_auth/controller/user_controller.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/review_controller.dart';

class ReviewScreen extends ConsumerStatefulWidget {
  static const routeName = '/review';

  final String tourId;
  const ReviewScreen({super.key, required this.tourId});

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  String get tourId => widget.tourId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reviews = ref.watch(getReviewByTourIdProvider(tourId: tourId));
    reviews.whenData((value) => alreadyCommentCheck(value));
  }

  final _commentCtl = TextEditingController();

  /// TODO Input untuk star -> Widgetnya gt
  int star = 5;

  void submit() async {
    debugPrint('SUBMIT');
    if (_commentCtl.text.trim().isEmpty || star < 0 || star > 5) return;
    final errMsg = await ref.read(reviewControllerProvider).save(
          tourId: tourId,
          star: star,
          comment: _commentCtl.text.trim(),
        );
    if (errMsg.isNotEmpty) return; // Show error
    // ignore: unused_result
    await ref.refresh(getReviewByTourIdProvider(tourId: tourId).future);
  }

  void alreadyCommentCheck(List<ReviewModel> data) async {
    final currentUser =
        await ref.watch(userControllerProvider.notifier).getCurrentUser();
    if (currentUser == null) return;
    final idx = data.indexWhere((e) => e.user.uid == currentUser.uid);
    if (idx == -1) return;

    /// wanna update comment
    _commentCtl.text = data[idx].comment;
    star = data[idx].star;
  }

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
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: fixPadding * 2),
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
                        colorScheme:
                            const ColorScheme.light(primary: primaryColor),
                      ),
                      child: TextField(
                        controller: _commentCtl,
                        keyboardType: TextInputType.name,
                        maxLines: 3,
                        minLines: 1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              getTranslate(context, 'review.input_review'),
                          hintStyle: regular14grey,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: submit,
                  icon: const Icon(Icons.send),
                )
              ],
            ),
          ],
        ));
  }

  Widget reviewList(Size size) {
    final reviews = ref.watch(getReviewByTourIdProvider(tourId: tourId));
    // reviews.whenData((value) => alreadyCommentCheck(value));
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
}
