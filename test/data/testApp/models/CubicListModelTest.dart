import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_test_app1/data/model/cubicData.dart';
import 'package:my_flutter_test_app1/data/testApp/models/cubic_list_model.dart';
import 'package:my_flutter_test_app1/domain/entities/cubic_list_data_entity.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final cubicListModel = CubicListModel(
      message: 'Got the data',
      type: 100,
      cubicListData: [
        CubicData(
          volume: 36155531502.91
        ),
        CubicData(
          volume: 50179822740.08
        )
      ]
  );

  group('extend Entity', () {
    test(
      'should be a subclass of CubicListDataEntity entity',
          () async {
        // assert
        expect(cubicListModel, isA<CubicListDataEntity>());
      },
    );
  });

  group('fromJson', () {
    test(
      'should return a valid model',
          () async {
        // arrange
        final Map<String, dynamic> jsonMap =
        json.decode(fixture('testApp/cubicList.json'));
        // act
        final result = CubicListModel.fromJson(jsonMap);
        // assert
        expect(result, cubicListModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map with proper data',
          () async {
        // act
        final result = cubicListModel.toJson();
        // assert
        final expectedMap = {
          'message': 'Got the data',
          'type': 100,
          'cubicListData': [
            CubicData(
                volume: 36155531502.91
            ),
            CubicData(
                volume: 50179822740.08
            )
          ]
        };
        expect(result, expectedMap);
      },
    );
  });
}