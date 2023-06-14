import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tour_a_vlog/1_common/models/tour_model.dart';

part 'tour_controller.g.dart';

@Riverpod(keepAlive: true)
class TourController extends _$TourController {
  late final FirebaseDatabase dbInstance;

  @override
  FutureOr<List<TourModel>> build() async {
    dbInstance = FirebaseDatabase.instance;
    return await _getTour();
  }

  FutureOr<List<TourModel>> _getTour() async {
    final snapshot = await dbInstance.ref().child("Items/").get();

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
        extractedListOfTourByRecommendation
            .add(TourModel.fromMap(extractedMap));
      });
      return extractedListOfTourByRecommendation;
    } else {
      return [];
    }
  }

  Future<List<TourModel>> getTourByCity(String title) async {
    final snapshot = await dbInstance
        .ref()
        .child("Items")
        .orderByChild("city")
        .equalTo(title.trim())
        .get();

    if (snapshot.exists) {
      Map newMap = snapshot.value as Map;
      List<TourModel> extractedListOfTourByCity = [];
      newMap.forEach((key, value) {
        Map extractedMap = newMap[key];
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
        extractedListOfTourByType.add(TourModel.fromMap(extractedMap));
      });
      return extractedListOfTourByType;
    } else {
      return [];
    }
  }
}
