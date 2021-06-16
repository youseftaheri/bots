import 'package:my_flutter_test_app1/data/model/cubicData.dart';
import 'entity.dart';

class CubicListDataEntity extends Entity {
  final String message;
  final int type;
  final List<CubicData> cubicListData;

  CubicListDataEntity(
    {
      this.message,
      this.type,
      this.cubicListData,
    });

  @override
  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'type': type,
      'cubicListData': cubicListData,
    };
  }

  @override
  List<Object> get props => [
    message,
    type,
    cubicListData,
  ];
}
