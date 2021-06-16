
import 'package:equatable/equatable.dart';
import 'package:my_flutter_test_app1/data/error/exceptions.dart';
import 'package:my_flutter_test_app1/data/model/cubicData.dart';
import 'package:my_flutter_test_app1/domain/entities/entity.dart';
import 'package:my_flutter_test_app1/domain/entities/cubic_list_data_entity.dart';

class CubicListData extends Equatable {
  final String message;
  final int type;
  final List<CubicData> cubicListData;

  CubicListData(
      {
        this.message,
        this.type,
        this.cubicListData,
      });

  @override
  Object get prop => {message, type, cubicListData};

  @override
  bool get stringify => true;

  @override
  factory CubicListData.fromEntity(Entity entity) {
    if ( entity is CubicListDataEntity ) {
      return CubicListData(
        message: entity.message,
        type: entity.type,
        cubicListData: entity.cubicListData,
      );
    } else {
      throw EntityModelMapperException(message: 'Entity should be of type CubicListDataEntity');
    }
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
