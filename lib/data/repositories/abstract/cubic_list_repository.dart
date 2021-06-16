import 'package:my_flutter_test_app1/data/model/cubicData.dart';

abstract class CubicListRepository {
  Future<List<CubicData>> getCubicListResult({
    String page,
  });
}
