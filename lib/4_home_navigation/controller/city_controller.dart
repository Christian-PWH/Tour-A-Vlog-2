import 'package:firebase_database/firebase_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tour_a_vlog/1_common/models/city_model.dart';

part 'city_controller.g.dart';

@Riverpod(keepAlive: true)
class CityController extends _$CityController {
  late final FirebaseDatabase dbInstance;

  @override
  FutureOr<List<CityModel>> build() async {
    dbInstance = FirebaseDatabase.instance;
    return await _getCity();
  }

  FutureOr<List<CityModel>> _getCity() async {
    final snapshot = await dbInstance.ref().child("City/").get();

    if (snapshot.exists) {
      Map newMap = snapshot.value as Map;
      List<CityModel> extractedListOfCity = [];
      newMap.forEach((key, value) {
        Map extractedMap = newMap[key];
        extractedListOfCity.add(CityModel.fromMap(extractedMap));
      });
      return extractedListOfCity;
    } else {
      return [];
    }
  }
}
