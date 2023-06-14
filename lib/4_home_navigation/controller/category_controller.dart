import 'package:firebase_database/firebase_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tour_a_vlog/1_common/models/category_model.dart';

part 'category_controller.g.dart';

@Riverpod(keepAlive: true)
class CategoryController extends _$CategoryController {
  late final FirebaseDatabase dbInstance;

  @override
  FutureOr<List<CategoryModel>> build() async {
    dbInstance = FirebaseDatabase.instance;
    return await _getCategory();
  }

  FutureOr<List<CategoryModel>> _getCategory() async {
    final snapshot = await dbInstance.ref().child("Categories/").get();

    if (snapshot.exists) {
      Map newMap = snapshot.value as Map;
      List<CategoryModel> extractedListOfCategory = [];
      newMap.forEach((key, value) {
        Map extractedMap = newMap[key];
        extractedListOfCategory.add(CategoryModel.fromMap(extractedMap));
      });
      return extractedListOfCategory;
    } else {
      return [];
    }
  }
}
