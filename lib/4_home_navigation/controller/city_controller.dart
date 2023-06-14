import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tour_a_vlog/1_common/models/city_model.dart';

part 'city_controller.g.dart';

final selectedCityNameProvider = StateProvider((ref) => '');

@Riverpod(keepAlive: true)
class CityController extends _$CityController {
  late final FirebaseDatabase dbInstance;

  @override
  FutureOr<List<CityModel>> build() {
    dbInstance = FirebaseDatabase.instance;
    return _getCity();
  }

  FutureOr<List<CityModel>> _getCity() async {
    final snapshot = await dbInstance.ref().child("City").get();

    if (snapshot.exists) {
      final newMap = snapshot.value as Map;
      List<CityModel> extractedListOfCity = [];
      newMap.forEach((key, value) {
        final extractedMap = newMap[key];
        extractedMap['id'] = key;
        extractedListOfCity.add(CityModel.fromMap(extractedMap));
      });
      return extractedListOfCity;
    } else {
      return [];
    }
  }
}

@riverpod
FutureOr<List<CityModel>> indonesiaDestinationController(
    IndonesiaDestinationControllerRef ref) async {
  final dbInstance = FirebaseDatabase.instance;
  final snapshot = await dbInstance.ref().child("City").get();

  if (!snapshot.exists) return [];

  final newMap = snapshot.value as Map;
  List<CityModel> extractedListOfCity = [];
  newMap.forEach((key, value) {
    final extractedMap = newMap[key];
    extractedMap['id'] = key;

    extractedListOfCity.add(CityModel.fromMap(extractedMap));
  });
  return extractedListOfCity;
}
