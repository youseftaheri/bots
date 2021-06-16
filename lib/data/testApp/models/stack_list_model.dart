import 'package:my_flutter_test_app1/data/model/stackData.dart';
import 'package:my_flutter_test_app1/domain/entities/stack_list_data_entity.dart';

class StackListModel extends StackListDataEntity {

  StackListModel(
      {message,
        type,
        stackListData,
      }) : super(
    message: message,
    type: type,
    stackListData: stackListData,
  );

  factory StackListModel.fromJson(Map<String, dynamic> json) {
    return StackListModel(
      message: json['Message'].toString(),
      type: json['Type'],
      stackListData: _getStackListFromJson(json),
    );
  }

  static List<StackData> _getStackListFromJson(Map<String, dynamic> json){
    List<StackData> stackList = [];
    try {
      int count = json['Data'].length;
      for (int i = 0; i < count; i++) {
        stackList.add(
            StackData(
              volumefrom: json['Data'][i]['volumefrom'].toDouble() ?? 0.0,
              volumeto: json['Data'][i]['volumeto'].toDouble() ?? 0.0,
            )
        );
      }
    }catch(e){
      print("$e");
    }
    return stackList;
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'type': type,
      'stackListData': stackListData,
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
