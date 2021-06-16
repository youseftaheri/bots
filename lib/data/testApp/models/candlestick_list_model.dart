import 'package:my_flutter_test_app1/data/model/candlestickData.dart';
import 'package:my_flutter_test_app1/domain/entities/candlestick_list_data_entity.dart';

class CandlestickListModel extends CandlestickListDataEntity {

  CandlestickListModel(
      {response,
        message,
        type,
        candlestickListData,
      }) : super(
    response: response,
    message: message,
    type: type,
    candlestickListData: candlestickListData,
  );

  factory CandlestickListModel.fromJson(Map<String, dynamic> json) {
    return CandlestickListModel(
      response: json['Response'].toString(),
      message: json['Message'].toString(),
      type: json['Type'],
      candlestickListData: _getCandlestickListFromJson(json),
    );
  }

  static List<CandlestickData> _getCandlestickListFromJson(Map<String, dynamic> json){
    List<CandlestickData> candlestickList = [];
    try {
      int count = json['Data']['Data'].length;
      for (int i = 0; i < count; i++) {
        candlestickList.add(
            CandlestickData(
              val: json['Data']['Data'][i]['volumefrom'].toDouble() ?? 0.0,
              high: json['Data']['Data'][i]['high'].toDouble() ?? 0.0,
              low: json['Data']['Data'][i]['low'].toDouble() ?? 0.0,
              open: json['Data']['Data'][i]['open'].toDouble() ?? 0.0,
              close: json['Data']['Data'][i]['close'].toDouble() ?? 0.0,
            )
        );
      }
    }catch(e){
      print("$e");
    }
    return candlestickList;
  }

  Map<String, dynamic> toJson() {
    return {
      'response': response,
      'message': message,
      'type': type,
      'candlestickListData': candlestickListData,
    };
  }
  static String stripTags(String htmlText) {
    RegExp exp = RegExp(
        r'<[^>]*>',
        multiLine: true,
        caseSensitive: true
    );
    return htmlText.replaceAll(exp, '');
  }
}
