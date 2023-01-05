import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_driven/core/error/exceptions.dart';
import 'package:test_driven/data/data/index.dart';
import 'package:test_driven/data/index.dart';

import '../../../fixtures/index.dart';

class MockSharedPreference extends Mock implements SharedPreferences {}

void main() {
  late NumberTriviaLocalDS numberTriviaLocalDS;
  late MockSharedPreference mockSharedPreference;
  setUp(
    () {
      mockSharedPreference = MockSharedPreference();
      numberTriviaLocalDS = NumberTriviaLocalDSImpl(
        sharedPreferences: mockSharedPreference,
      );
    },
  );
  final testCachedNumberTriviaModel = TriviaResponseModel.fromJson(
    jsonData: json.decode(
      fixture('trivia_cached.json'),
    ),
  );

  group(
    'Testing getLastNumberTrivia in both cases success and exception',
    () {
      test(
        'should get last NumberTrivia cached in shared preference when it exists',
        () async {
          // arrange
          when(
            () => mockSharedPreference.getString(
              any<String>(),
            ),
          ).thenReturn(
            fixture(
              'trivia_cached.json',
            ),
          );
          // act
          final result = await numberTriviaLocalDS.getLastNumberTrivia();
          // assert
          verify(
            () => mockSharedPreference.getString(
              ConstantMapKeys.cachedNumberTrivia,
            ),
          ).called(1);
          expect(result, testCachedNumberTriviaModel);
        },
      );

      test(
        'should throw cache exception when there is no data cached',
        () async {
          // arrange
          when(
            () => mockSharedPreference.getString(
              any<String>(),
            ),
          ).thenReturn(
            null,
          );
          // act
          final result = numberTriviaLocalDS.getLastNumberTrivia;
          // assert
          await expectLater(
            result(),
            throwsA(
              const TypeMatcher<CacheException>(),
            ),
          );
          verify(
            () => mockSharedPreference.getString(
              ConstantMapKeys.cachedNumberTrivia,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockSharedPreference);
        },
      );
    },
  );

  group(
    'Testing cacheNumberTrivia in both cases success and exception',
    () {
      test(
        'should cache NumberTriviaModel in shared preferences',
        () async {
          // arrange
          when(
            () => mockSharedPreference.setString(
              ConstantMapKeys.cachedNumberTrivia,
              any<String>(),
            ),
          ).thenAnswer(
            (_) async => true,
          );
          // act
          final result = numberTriviaLocalDS.cacheNumberTrivia;
          // assert
          await expectLater(
            result(
              triviaResponseModel: const TriviaResponseModel(),
            ),
            completes,
          );
          verify(
            () => mockSharedPreference.setString(
              ConstantMapKeys.cachedNumberTrivia,
              any<String>(),
            ),
          ).called(1);
          verifyNoMoreInteractions(mockSharedPreference);
        },
      );
      test(
        'should throw cache exception when there is failure in storing data',
        () async {
          // arrange
          when(
            () => mockSharedPreference.setString(
              ConstantMapKeys.cachedNumberTrivia,
              any<String>(),
            ),
          ).thenAnswer(
            (_) async => false,
          );
          // act
          final result = numberTriviaLocalDS.cacheNumberTrivia;
          // assert
          await expectLater(
            result(
              triviaResponseModel: const TriviaResponseModel(),
            ),
            throwsA(
              const TypeMatcher<CacheException>(),
            ),
          );
          verify(
            () => mockSharedPreference.setString(
              ConstantMapKeys.cachedNumberTrivia,
              any<String>(),
            ),
          ).called(1);
          verifyNoMoreInteractions(mockSharedPreference);
        },
      );
    },
  );
}
