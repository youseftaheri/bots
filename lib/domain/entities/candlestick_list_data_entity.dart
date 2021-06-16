import 'package:my_flutter_test_app1/data/model/candlestickData.dart';
import 'entity.dart';

class CandlestickListDataEntity extends Entity {
  final String response;
  final String message;
  final int type;
  final List<CandlestickData> candlestickListData;

  CandlestickListDataEntity(
    {
      this.response,
      this.message,
      this.type,
      this.candlestickListData,
    });

  @override
  Map<String, dynamic> toMap() {
    return {
      'response': response,
      'message': message,
      'type': type,
      'candlestickListData': candlestickListData,
    };
  }

  @override
  List<Object> get props => [
    response,
    message,
    type,
    candlestickListData,
  ];
}
