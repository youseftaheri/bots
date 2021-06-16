import 'package:my_flutter_test_app1/data/model/stackData.dart';

abstract class StackListRepository {
  Future<List<StackData>> getStackListResult({
    String page,
  });
}
