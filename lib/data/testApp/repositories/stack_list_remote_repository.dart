import 'package:flutter/material.dart';
import 'package:my_flutter_test_app1/data/error/exceptions.dart';
import 'package:my_flutter_test_app1/data/model/stackData.dart';
import 'package:my_flutter_test_app1/data/model/stackListData.dart';
import 'package:my_flutter_test_app1/data/network/network_request.dart';
import 'package:my_flutter_test_app1/data/repositories/abstract/stack_list_repository.dart';
import 'package:my_flutter_test_app1/data/testApp/models/stack_list_model.dart';

class RemoteStackListRepository extends StackListRepository {

  final NetworkRequestAbstract testApp;

  RemoteStackListRepository({@required this.testApp});

  @override
  Future<List<StackData>> getStackListResult({String page}) async {
    try
    {
      dynamic stackListData = await testApp.getStacksResult(limit: page);
      List<StackData> stackList = StackListData.fromEntity(StackListModel.fromJson(stackListData)).stackListData;
      return stackList;
    }
    on HttpRequestException {
      throw RemoteServerException();
    }
  }
}
