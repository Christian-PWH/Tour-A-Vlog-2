import 'package:firebase_database/firebase_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tour_a_vlog/1_common/models/type_model.dart';

part 'type_controller.g.dart';

@Riverpod(keepAlive: true)
class TypeController extends _$TypeController {
  late final FirebaseDatabase dbInstance;

  @override
  FutureOr<List<TypeModel>> build() async {
    dbInstance = FirebaseDatabase.instance;
    return await _getType();
  }

  FutureOr<List<TypeModel>> _getType() async {
    final snapshot = await dbInstance.ref().child("Type/").get();

    if (snapshot.exists) {
      Map newMap = snapshot.value as Map;
      List<TypeModel> extractedListOfType = [];
      newMap.forEach((key, value) {
        Map extractedMap = newMap[key];
        extractedListOfType.add(TypeModel.fromMap(extractedMap));
      });
      return extractedListOfType;
    } else {
      return [];
    }
  }
}
