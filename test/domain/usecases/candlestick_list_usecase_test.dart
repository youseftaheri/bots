import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_flutter_test_app1/data/error/exceptions.dart';
import 'package:my_flutter_test_app1/domain/usecases/candlestick_list_usecase.dart';
import 'package:my_flutter_test_app1/utils/constants/strings.dart';

import '../../fixtures/fixture_reader.dart';
import 'use_case_test_include.dart';

void main() {

  setupLocator();
  MockTestAppWrapper testApp;
  CandlestickListUseCase candlestickListUseCase;
  CandlestickListParams candlestickListParams;

  setUp(() {
    testApp = sl();
    candlestickListUseCase = CandlestickListUseCaseImpl();
    candlestickListParams = CandlestickListParams(
        page: Strings.limit
    );
  });
  
  group('Get list of candlesticks ', () {
    test(
      'should return list of candlesticks when candlestickDetailsUseCase.execute is successful',
          () async {
        // arrange
        when(testApp.getCandlesticksResult(limit: Strings.limit))
            .thenAnswer((_) async => json.decode(fixture('testApp/candlestickList.json'))
        );
        // act
        final candlesticks = await candlestickListUseCase.execute(candlestickListParams);
        // assert
        expect(candlesticks.candlesticks.length, equals(2));
      },
    );

    test(
      'should return server failure when candlestickDetailsUseCase.execute is unsuccessful',
          () async {
        // arrange
        when(testApp.getCandlesticksResult(limit: Strings.limit))
            .thenThrow(HttpRequestException());
        // act
        final candlesticks = await candlestickListUseCase.execute(candlestickListParams);
        // assert
        expect(candlesticks.validResults, equals(false));
        expect(candlesticks.exception, isInstanceOf<EmptyCandlestickListException>());
      },
    );

  });

}