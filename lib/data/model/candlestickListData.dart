
import 'package:equatable/equatable.dart';
import 'package:my_flutter_test_app1/data/error/exceptions.dart';
import 'package:my_flutter_test_app1/data/model/candlestickData.dart';
import 'package:my_flutter_test_app1/domain/entities/entity.dart';
import 'package:my_flutter_test_app1/domain/entities/candlestick_list_data_entity.dart';

class CandlestickListData extends Equatable {
  final String response;
  final String message;
  final int type;
  final List<CandlestickData> candlestickListData;

  CandlestickListData(
      {
        this.response,
        this.message,
        this.type,
        this.candlestickListData,
      });

  @override
  Object get prop => {response, message, type, candlestickListData};

  @override
  bool get stringify => true;

  @override
  factory CandlestickListData.fromEntity(Entity entity) {
    if ( entity is CandlestickListDataEntity ) {
      return CandlestickListData(
        response: entity.response,
        message: entity.message,
        type: entity.type,
        candlestickListData: entity.candlestickListData,
      );
    } else {
      throw EntityModelMapperException(message: 'Entity should be of type CandlestickListDataEntity');
    }
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
