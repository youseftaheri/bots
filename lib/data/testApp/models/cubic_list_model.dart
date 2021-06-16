import 'package:my_flutter_test_app1/data/model/cubicData.dart';
import 'package:my_flutter_test_app1/domain/entities/cubic_list_data_entity.dart';

class CubicListModel extends CubicListDataEntity {

  CubicListModel(
      {message,
        type,
        cubicListData,
      }) : super(
    message: message,
    type: type,
    cubicListData: cubicListData,
  );

  factory CubicListModel.fromJson(Map<String, dynamic> json) {
    return CubicListModel(
      message: json['Message'].toString(),
      type: json['Type'],
      cubicListData: _getCubicListFromJson(json),
    );
  }

  static List<CubicData> _getCubicListFromJson(Map<String, dynamic> json){
    List<CubicData> cubicList = [];
    try {
      int count = json['Data'].length;
      for (int i = 0; i < count; i++) {
        cubicList.add(
            CubicData(
              volume: json['Data'][i]['volume'].toDouble() ?? 0.0,
            )
        );
      }
    }catch(e){
      print("$e");
    }
    return cubicList;
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'type': type,
      'cubicListData': cubicListData,
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
