import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_flutter_test_app1/data/model/candlestickData.dart';
import 'package:my_flutter_test_app1/data/testApp/models/candlestick_list_model.dart';
import 'package:my_flutter_test_app1/domain/entities/candlestick_list_data_entity.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final candlestickListModel = CandlestickListModel(
      response: 'Success',
      message: '',
      type: 100,
      candlestickListData: [
        CandlestickData(
            val: 1.91,
            high: 1.91,
            low: 1.91,
            open: 1.91,
            close: 1.91
        ),
        CandlestickData(
            val: 1.91,
            high: 1.91,
            low: 1.91,
            open: 1.91,
            close: 1.91
        ),
      ]
  );

  group('extend Entity', () {
    test(
      'should be a subclass of CandlestickListDataEntity entity',
          () async {
        // assert
        expect(candlestickListModel, isA<CandlestickListDataEntity>());
      },
    );
  });

  group('fromJson', () {
    test(
      'should return a valid model',
          () async {
        // arrange
        final Map<String, dynamic> jsonMap =
        json.decode(fixture('testApp/candlestickList.json'));
        // act
        final result = CandlestickListModel.fromJson(jsonMap);
        // assert
        expect(result, candlestickListModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map with proper data',
          () async {
        // act
        final result = candlestickListModel.toJson();
        // assert
        final expectedMap = {
          'response': 'Success',
          'message': '',
          'type': 100,
          'candlestickListData': [
            CandlestickData(
                val: 1.91,
                high: 1.91,
                low: 1.91,
                open: 1.91,
                close: 1.91
            ),
            CandlestickData(
                val: 1.91,
                high: 1.91,
                low: 1.91,
                open: 1.91,
                close: 1.91
            ),
          ]
        };
        expect(result, expectedMap);
      },
    );
  });
}