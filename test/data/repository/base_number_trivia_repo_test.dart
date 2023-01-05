import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_driven/core/index.dart';
import 'package:test_driven/data/data/index.dart';
import 'package:test_driven/data/index.dart';
import 'package:test_driven/domain/index.dart';

class MockNetworkChecker extends Mock implements NetworkChecker {}

class MockNumberTriviaLocalDS extends Mock implements NumberTriviaLocalDS {}

class MockNumberTriviaRemoteDS extends Mock implements NumberTriviaRemoteDS {}

class FakeTriviaRequestModel extends Fake implements TriviaRequestModel {}

class FakeTriviaResponseModel extends Fake implements TriviaResponseModel {}

void main() {
  // SUT
  late BaseNumberTriviaRepository baseNumberTriviaRepository;

  late MockNetworkChecker mockNetworkChecker;
  late MockNumberTriviaLocalDS mockNumberTriviaLocalDS;
  late MockNumberTriviaRemoteDS mockNumberTriviaRemoteDS;

  setUp(() {
    registerFallbackValue(
      FakeTriviaRequestModel(),
    );
    registerFallbackValue(
      FakeTriviaResponseModel(),
    );

    mockNetworkChecker = MockNetworkChecker();
    mockNumberTriviaRemoteDS = MockNumberTriviaRemoteDS();
    mockNumberTriviaLocalDS = MockNumberTriviaLocalDS();

    baseNumberTriviaRepository = BaseNumberTriviaRepoImpl(
      networkChecker: mockNetworkChecker,
      numberTriviaLocalDS: mockNumberTriviaLocalDS,
      numberTriviaRemoteDS: mockNumberTriviaRemoteDS,
    );
  });

  const testTriviaResponseModel = TriviaResponseModel();
  const testTriviaRequestEntity = TriviaRequestEntity(
    numberTrivia: 1,
  );


  group(
    'Device is Online',
    () {
      setUp(() async {
        when(() => mockNetworkChecker.isConnected())
            .thenAnswer((_) async => true);
      });
      test(
        'should return remote data when the call to remote data source is successful and cached the data',
            () async {
          // arrange
          when(
                () =>
                mockNumberTriviaRemoteDS.getConcreteNumberTrivia(
                  triviaRequestModel:
                  any<TriviaRequestModel>(named: 'triviaRequestModel'),
                ),
          ).thenAnswer(
                (_) async => testTriviaResponseModel,
          );
          when(
                () =>
                mockNumberTriviaLocalDS.cacheNumberTrivia(
                  triviaResponseModel: any<TriviaResponseModel>(
                    named: 'triviaResponseModel',
                  ),
                ),
          ).thenAnswer(
                (_) async => Future.value(),
          );

          // act
          final result =
          await baseNumberTriviaRepository.getConcreteNumberTrivia(
            requestTriviaEntity: testTriviaRequestEntity,
          );

          // assert
          expect(
            result,
            Right(
              testTriviaResponseModel.toEntity(),
            ),
          );
          verify(
                () =>
                mockNumberTriviaRemoteDS.getConcreteNumberTrivia(
                  triviaRequestModel:
                  any<TriviaRequestModel>(named: 'triviaRequestModel'),
                ),
          ).called(1);
          verify(
                () =>
                mockNumberTriviaLocalDS.cacheNumberTrivia(
                  triviaResponseModel: any<TriviaResponseModel>(
                    named: 'triviaResponseModel',
                  ),
                ),
          ).called(1);
          verifyNoMoreInteractions(
            mockNumberTriviaRemoteDS,
          );
          verifyNoMoreInteractions(
            mockNumberTriviaLocalDS,
          );
        },
      );
      test(
        'should return remote data when the call to remote data source is successful and cached the data', () async {
            () async {
          // arrange
          when(
                () => mockNumberTriviaRemoteDS.getRandomNumberTrivia(),
          ).thenAnswer(
                (_) async => testTriviaResponseModel,
          );
          when(
                () =>
                mockNumberTriviaLocalDS.cacheNumberTrivia(
                  triviaResponseModel: any<TriviaResponseModel>(
                    named: 'triviaResponseModel',
                  ),
                ),
          ).thenAnswer(
                (_) async => Future.value(),
          );

          // act
          final result =
          await baseNumberTriviaRepository.getRandomNumberTrivia();
          // assert
          expect(
            result,
            Right(
              testTriviaResponseModel.toEntity(),
            ),
          );
          verify(
                () => mockNumberTriviaRemoteDS.getRandomNumberTrivia(),
          ).called(1);
          verify(
                () =>
                mockNumberTriviaLocalDS.cacheNumberTrivia(
                  triviaResponseModel: any<TriviaResponseModel>(
                    named: 'triviaResponseModel',
                  ),
                ),
          ).called(1);
          verifyNoMoreInteractions(
            mockNumberTriviaRemoteDS,
          );
          verifyNoMoreInteractions(
            mockNumberTriviaLocalDS,
          );
        };
      },);
    }
  );

  group('Device is Offline', () {
    setUp(() {
      when(
        ()=> mockNetworkChecker.isConnected(),
      ).thenAnswer(
        (_) async => false,
      );
    });

    test(
      'should return last cached number trivia when device is offline',
      () async {
        // arrange
        when(
          () => mockNumberTriviaLocalDS.getLastNumberTrivia(),
        ).thenAnswer(
          (_) async => testTriviaResponseModel,
        );

        // act
        final result = await baseNumberTriviaRepository.getConcreteNumberTrivia(
          requestTriviaEntity: testTriviaRequestEntity,
        );

        // assert
        expect(
          result,
          Right(
            testTriviaResponseModel.toEntity(),
          ),
        );
        verify(
          () => mockNumberTriviaLocalDS.getLastNumberTrivia(),
        ).called(1);
        verifyZeroInteractions(
          mockNumberTriviaRemoteDS,
        );
        verifyNoMoreInteractions(
          mockNumberTriviaLocalDS,
        );
      },
    );
  });
}
