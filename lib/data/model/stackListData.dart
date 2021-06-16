
import 'package:equatable/equatable.dart';
import 'package:my_flutter_test_app1/data/error/exceptions.dart';
import 'package:my_flutter_test_app1/data/model/stackData.dart';
import 'package:my_flutter_test_app1/domain/entities/entity.dart';
import 'package:my_flutter_test_app1/domain/entities/stack_list_data_entity.dart';

class StackListData extends Equatable {
  final String message;
  final int type;
  final List<StackData> stackListData;

  StackListData(
      {
        this.message,
        this.type,
        this.stackListData,
      });

  @override
  Object get prop => {message, type, stackListData};

  @override
  bool get stringify => true;

  @override
  factory StackListData.fromEntity(Entity entity) {
    if ( entity is StackListDataEntity ) {
      return StackListData(
        message: entity.message,
        type: entity.type,
        stackListData: entity.stackListData,
      );
    } else {
      throw EntityModelMapperException(message: 'Entity should be of type StackListDataEntity');
    }
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
