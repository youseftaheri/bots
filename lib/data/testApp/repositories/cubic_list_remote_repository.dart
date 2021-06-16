import 'package:flutter/material.dart';
import 'package:my_flutter_test_app1/data/error/exceptions.dart';
import 'package:my_flutter_test_app1/data/model/cubicData.dart';
import 'package:my_flutter_test_app1/data/model/cubicListData.dart';
import 'package:my_flutter_test_app1/data/network/network_request.dart';
import 'package:my_flutter_test_app1/data/repositories/abstract/cubic_list_repository.dart';
import 'package:my_flutter_test_app1/data/testApp/models/cubic_list_model.dart';

class RemoteCubicListRepository extends CubicListRepository {

  final NetworkRequestAbstract testApp;

  RemoteCubicListRepository({@required this.testApp});

  @override
  Future<List<CubicData>> getCubicListResult({String page}) async {
    try
    {
      dynamic cubicListData = await testApp.getCubicsResult(limit: page);
      List<CubicData> cubicList = CubicListData.fromEntity(CubicListModel.fromJson(cubicListData)).cubicListData;
      return cubicList;
    }
    on HttpRequestException {
      throw RemoteServerException();
    }
  }
}
