import 'package:my_flutter_test_app1/data/model/stackData.dart';
import 'entity.dart';

class StackListDataEntity extends Entity {
  final String message;
  final int type;
  final List<StackData> stackListData;

  StackListDataEntity(
    {
      this.message,
      this.type,
      this.stackListData,
    });

  @override
  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'type': type,
      'stackListData': stackListData,
    };
  }

  @override
  List<Object> get props => [
    message,
    type,
    stackListData,
  ];
}
