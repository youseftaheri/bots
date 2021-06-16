import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:my_flutter_test_app1/data/error/exceptions.dart';
import 'package:my_flutter_test_app1/domain/usecases/cubic_list_usecase.dart';
import 'package:my_flutter_test_app1/utils/constants/strings.dart';

import '../../fixtures/fixture_reader.dart';
import 'use_case_test_include.dart';

void main() {

  setupLocator();
  MockTestAppWrapper testApp;
  CubicListUseCase cubicListUseCase;
  CubicListParams cubicListParams;

  setUp(() {
    testApp = sl();
    cubicListUseCase = CubicListUseCaseImpl();
    cubicListParams = CubicListParams(
        page: Strings.limit
    );
  });
  
  group('Get list of cubics ', () {
    test(
      'should return list of cubics when cubicDetailsUseCase.execute is successful',
          () async {
        // arrange
        when(testApp.getCubicsResult(limit: Strings.limit))
            .thenAnswer((_) async => json.decode(fixture('testApp/cubicList.json'))
        );
        // act
        final cubics = await cubicListUseCase.execute(cubicListParams);
        // assert
        expect(cubics.cubics.length, equals(2));
      },
    );

    test(
      'should return server failure when cubicDetailsUseCase.execute is unsuccessful',
          () async {
        // arrange
        when(testApp.getCubicsResult(limit: Strings.limit))
            .thenThrow(HttpRequestException());
        // act
        final cubics = await cubicListUseCase.execute(cubicListParams);
        // assert
        expect(cubics.validResults, equals(false));
        expect(cubics.exception, isInstanceOf<EmptyCubicListException>());
      },
    );

  });

}