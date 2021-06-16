import 'package:flutter/material.dart';
import 'package:my_flutter_test_app1/data/error/exceptions.dart';
import 'package:my_flutter_test_app1/data/model/candlestickData.dart';
import 'package:my_flutter_test_app1/data/model/candlestickListData.dart';
import 'package:my_flutter_test_app1/data/network/network_request.dart';
import 'package:my_flutter_test_app1/data/repositories/abstract/candlestick_list_repository.dart';
import 'package:my_flutter_test_app1/data/testApp/models/candlestick_list_model.dart';

class RemoteCandlestickListRepository extends CandlestickListRepository {

  final NetworkRequestAbstract testApp;

  RemoteCandlestickListRepository({@required this.testApp});

  @override
  Future<List<CandlestickData>> getCandlestickListResult({String page}) async {
    try
    {
      dynamic candlestickListData = await testApp.getCandlesticksResult(limit: page);
      List<CandlestickData> candlestickList = CandlestickListData.fromEntity(CandlestickListModel.fromJson(candlestickListData)).candlestickListData;
      return candlestickList;
    }
    on HttpRequestException {
      throw RemoteServerException();
    }
  }
}
