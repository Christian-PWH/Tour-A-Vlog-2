import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tour_a_vlog/1_common/models/tour_model.dart';

part 'tour_controller.g.dart';

@riverpod
FutureOr<List<TourModel>> getTourByCity(
  GetTourByCityRef ref, {
  required String cityTitle,
}) async {
  final tourController = ref.watch(tourControllerProvider);
  return tourController.getTourByCity(cityTitle);
}

@riverpod
FutureOr<List<TourModel>> recommendation(RecommendationRef ref) async {
  final tourController = ref.watch(tourControllerProvider);
  return tourController.getTourByRecommendation();
}

@riverpod
FutureOr<List<TourModel>> discoverByCategoryController(
  DiscoverByCategoryControllerRef ref, {
  required String categorTitle,
}) async {
  final tourController = ref.watch(tourControllerProvider);
  return tourController.getTourByCategories(categorTitle);
}

@riverpod
FutureOr<List<TourModel>> getTourByType(
  GetTourByTypeRef ref, {
  required String type,
}) async {
  final tourController = ref.watch(tourControllerProvider);
  return tourController.getTourByType(type);
}

@Riverpod(keepAlive: true)
TourController tourController(TourControllerRef ref) {
  return TourController(FirebaseDatabase.instance);
}

class TourController {
  final FirebaseDatabase dbInstance;

  TourController(this.dbInstance);

  FutureOr<List<TourModel>> get() async {
    final snapshot = await dbInstance.ref().child("Items").get();

    if (snapshot.exists) {
      Map newMap = snapshot.value as Map;
      debugPrint("newRawMap = $newMap");
      List<TourModel> extractedListOfTour = [];
      newMap.forEach((key, value) {
        Map extractedMap = newMap[key];
        extractedListOfTour.add(TourModel.fromMap(extractedMap));
      });
      debugPrint("extractedMap = $extractedListOfTour");
      return extractedListOfTour;
    } else {
      return [];
    }
  }

  Future<List<TourModel>> getTourByCategories(String title) async {
    final snapshot = await dbInstance
        .ref()
        .child("Items")
        .orderByChild("category")
        .equalTo(title.trim())
        .get();

    if (snapshot.exists) {
      Map newMap = snapshot.value as Map;
      List<TourModel> extractedListOfTourByCategory = [];
      newMap.forEach((key, value) {
        Map extractedMap = newMap[key];
        extractedMap['id'] = key;
        extractedListOfTourByCategory.add(TourModel.fromMap(extractedMap));
      });
      return extractedListOfTourByCategory;
    } else {
      return [];
    }
  }

  Future<List<TourModel>> getTourByRecommendation() async {
    final snapshot = await dbInstance
        .ref()
        .child("Items")
        .orderByChild("status1")
        .equalTo("recomen")
        .get();

    if (snapshot.exists) {
      Map newMap = snapshot.value as Map;
      List<TourModel> extractedListOfTourByRecommendation = [];
      newMap.forEach((key, value) {
        Map extractedMap = newMap[key];
        extractedMap['id'] = key;
        extractedListOfTourByRecommendation
            .add(TourModel.fromMap(extractedMap));
      });
      return extractedListOfTourByRecommendation;
    } else {
      return [];
    }
  }

  Future<List<TourModel>> getTourByCity(String type) async {
    final snapshot = await dbInstance
        .ref()
        .child("Items")
        .orderByChild("city")
        .equalTo(type.trim())
        .get();

    if (snapshot.exists) {
      Map newMap = snapshot.value as Map;
      List<TourModel> extractedListOfTourByCity = [];
      newMap.forEach((key, value) {
        Map extractedMap = newMap[key];
        extractedMap['id'] = key;
        extractedListOfTourByCity.add(TourModel.fromMap(extractedMap));
      });
      return extractedListOfTourByCity;
    } else {
      return [];
    }
  }

  Future<List<TourModel>> getTourByType(String title) async {
    final snapshot = await dbInstance
        .ref()
        .child("Items")
        .orderByChild("type")
        .equalTo(title.trim())
        .get();

    if (snapshot.exists) {
      Map newMap = snapshot.value as Map;
      List<TourModel> extractedListOfTourByType = [];
      newMap.forEach((key, value) {
        Map extractedMap = newMap[key];
        extractedMap['id'] = key;
        extractedListOfTourByType.add(TourModel.fromMap(extractedMap));
      });
      return extractedListOfTourByType;
    } else {
      return [];
    }
  }
}
