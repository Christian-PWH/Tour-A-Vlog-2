import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tour_a_vlog/1_common/models/review_model.dart';
import 'package:tour_a_vlog/1_common/models/tour_model.dart';
import 'package:tour_a_vlog/1_common/models/user_model.dart';
import 'package:tour_a_vlog/3_auth/controller/user_controller.dart';
import 'package:tour_a_vlog/4_home_navigation/controller/tour_controller.dart';

part 'review_controller.g.dart';

@riverpod
FutureOr<List<ReviewModel>> getReviewByTourId(
  GetReviewByTourIdRef ref, {
  required String tourId,
}) {
  final reviewController = ref.watch(reviewControllerProvider);
  // final apalah = reviewController.getStream(tourId);
  return reviewController.get(tourId);
}

// @riverpod
// Stream<List<ReviewModel>> getReviewByTourId(GetReviewByTourIdRef ref) {

//   return [];
// }

@Riverpod(keepAlive: true)
ReviewController reviewController(ReviewControllerRef ref) {
  return ReviewController(
      FirebaseDatabase.instance,
      ref.watch(userControllerProvider.notifier),
      ref.watch(tourControllerProvider));
}

class ReviewController {
  final FirebaseDatabase dbInstance;
  final UserController _userController;
  final TourController _tourController;

  ReviewController(this.dbInstance, this._userController, this._tourController);

  FutureOr<List<ReviewModel>> get(String tourId) async {
    final snapshot =
        await dbInstance.ref().child('Items/$tourId/reviews').get();

    if (!snapshot.exists) return [];

    Map newMap = snapshot.value as Map;
    // List<ReviewModel> extractedListOfReview = [];
    // newMap.forEach((key, value) async {
    //   Map<String, dynamic> extractedMap = newMap[key];
    //   extractedMap['id'] = key;
    //   extractedMap['user'] =
    //       (await getUserReviewById(extractedMap['userid']))?.toMap();
    //   extractedListOfReview.add(ReviewModel.fromMap(extractedMap));
    // });

    final reviewsFuture = newMap.entries.map((e) async {
      Map<dynamic, dynamic> extractedMap = e.value;
      extractedMap['id'] = e.key;
      extractedMap['user'] =
          (await getUserReviewById(extractedMap['userId']))?.toMap();
      return ReviewModel.fromMap(extractedMap);
    }).toList();

    return Future.wait(reviewsFuture);
  }

  /// TODO For the sake of curiosity
  Future<void> getStream(String tourId) async {
    // final ref = dbInstance.ref('Items/$tourId/reviews');
    // final a = ref.onValue.listen((event) {
    //   final newMap = event.snapshot.value;
    //   debugPrint(newMap.toString());
    // });

    // final a = ref.onChildChanged.listen((event) {
    //   Map newMap = event.snapshot.value as Map;
    //   debugPrint(newMap.toString());
    // });
  }

  /// Ada kemungkinan User tsb sudah di delete.
  /// Tapi Review nya masih tersimpan => anonymous
  FutureOr<UserModel?> getUserReviewById(String userId) async {
    final snapshot = await dbInstance.ref().child('Users/$userId').get();
    if (!snapshot.exists) return null;
    Map newMap = snapshot.value as Map;
    newMap['uid'] = snapshot.key.toString();
    return UserModel.fromMap(newMap);
  }

  FutureOr<String> save({
    required String tourId,
    required int star,
    required String comment,
  }) async {
    final currentUser = await _userController.getCurrentUser();
    if (currentUser == null) return '';
    try {
      final TourModel? tour = await _tourController.getTourById(tourId);
      if (tour == null) return 'This tour is no longer exists';
      final ref = dbInstance.ref('Items/$tourId/reviews/${currentUser.uid}');
      await ref.set({
        'userId': currentUser.uid,
        'star': star,
        'comment': comment,
      });

      return '';
    } on FirebaseException catch (e) {
      return e.toString();
    }
  }
}
