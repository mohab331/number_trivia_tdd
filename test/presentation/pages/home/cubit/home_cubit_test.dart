import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_driven/core/error/failure.dart';
import 'package:test_driven/domain/index.dart';
import 'package:test_driven/presentation/pages/home/cubit/home_cubit.dart';
import 'package:test_driven/presentation/pages/home/cubit/home_states.dart';

class MockGetConcreteNumberTriviaUC extends Mock
    implements GetConcreteNumberTriviaUseCase {}

class MockGetRandomNumberTriviaUC extends Mock
    implements GetRandomNumberTriviaUseCase {}

class FakeRequestTriviaEntity extends Fake implements TriviaRequestEntity {}

void main() {
  // SUT
  late HomeCubit homeCubit;
  // mocks
  late MockGetConcreteNumberTriviaUC mockGetConcreteNumberTriviaUC;
  late MockGetRandomNumberTriviaUC mockGetRandomNumberTriviaUC;

  setUp(() {
    registerFallbackValue(FakeRequestTriviaEntity());

    mockGetConcreteNumberTriviaUC = MockGetConcreteNumberTriviaUC();
    mockGetRandomNumberTriviaUC = MockGetRandomNumberTriviaUC();

    homeCubit = HomeCubit(
      getConcreteNumberTriviaUseCase: mockGetConcreteNumberTriviaUC,
      getRandomNumberTriviaUseCase: mockGetRandomNumberTriviaUC,
    );
  });
  tearDown(
    () => homeCubit.close(),
  );
  group('Testing HomeCubit', () {
    test(
      'Test home cubit emits HomeInitialState when created',
      () {
        expect(homeCubit.state.runtimeType, HomeInitialState);
      },
    );
    group(
      'Testing when calling mockGetConcreteNumberTriviaUC in case of fail and success',
      () {
        blocTest(
          'HomeCubit should emit HomeLoadingState then HomeGetNumberSuccessState in case of success',
          build: () => homeCubit,
          act: (HomeCubit cubitUnderTest) async {
            // arrange
            // stubs
            when(
              () => mockGetConcreteNumberTriviaUC.getConcreteNumberTrivia(
                requestTriviaEntity: any<TriviaRequestEntity>(
                  named: 'requestTriviaEntity',
                ),
              ),
            ).thenAnswer(
              (_) async => Right(
                TriviaResponseEntity(),
              ),
            );

            // act
            await cubitUnderTest.getConcreteNumberTrivia(
              number: 1,
            );
          },
          expect: () => [
            HomeLoadingState(),
            HomeGetNumberSuccessState(
              triviaResponseEntity: TriviaResponseEntity(),
            ),
          ],
          verify: (_) {
            verify(
              () => mockGetConcreteNumberTriviaUC.getConcreteNumberTrivia(
                requestTriviaEntity:
                    any<TriviaRequestEntity>(named: 'requestTriviaEntity'),
              ),
            ).called(1);
            verifyNoMoreInteractions(mockGetConcreteNumberTriviaUC);
            verifyZeroInteractions(mockGetRandomNumberTriviaUC);
          },
        );
        blocTest(
          'HomeCubit should emit HomeLoadingState then HomeErrorState in case of failure',
          act: (HomeCubit cubitUnderTest) async {
            // arrange
            // stubs
            when(
              () => mockGetConcreteNumberTriviaUC.getConcreteNumberTrivia(
                requestTriviaEntity: any<TriviaRequestEntity>(
                  named: 'requestTriviaEntity',
                ),
              ),
            ).thenAnswer(
              (_) async => Left(
                ServerFailure(),
              ),
            );

            // act
            await cubitUnderTest.getConcreteNumberTrivia(
              number: 1,
            );
          },
          expect: () => [
            HomeLoadingState(),
            HomeErrorState(
              errorMessage: '',
            ),
          ],
          verify: (_) {
            verify(
              () => mockGetConcreteNumberTriviaUC.getConcreteNumberTrivia(
                requestTriviaEntity:
                    any<TriviaRequestEntity>(named: 'requestTriviaEntity'),
              ),
            ).called(1);
            verifyNoMoreInteractions(mockGetConcreteNumberTriviaUC);
            verifyZeroInteractions(mockGetRandomNumberTriviaUC);
          },
          build: () => homeCubit,
        );
      },
    );
    group(
      'Testing when calling GetRandomNumberTriviaUC in case of fail and success',
      () {
        () {
          blocTest(
            'HomeCubit should emit HomeLoadingState then HomeGetNumberSuccessState in case of success',
            build: () => homeCubit,
            act: (HomeCubit cubitUnderTest) async {
              // arrange
              // stubs
              when(
                () => mockGetRandomNumberTriviaUC.getRandomNumberTrivia(),
              ).thenAnswer(
                (_) async => Right(
                  TriviaResponseEntity(),
                ),
              );

              // act
              await cubitUnderTest.getRandomNumberTrivia();
            },
            expect: () => [
              HomeLoadingState(),
              HomeGetNumberSuccessState(
                triviaResponseEntity: TriviaResponseEntity(),
              ),
            ],
            verify: (_) {
              verify(
                () => mockGetRandomNumberTriviaUC.getRandomNumberTrivia(),
              ).called(1);
              verifyNoMoreInteractions(mockGetRandomNumberTriviaUC);
              verifyZeroInteractions(mockGetConcreteNumberTriviaUC);
            },
          );
          blocTest(
            'HomeCubit should emit HomeLoadingState then HomeErrorState in case of failure',
            act: (HomeCubit cubitUnderTest) async {
              // arrange
              // stubs
              when(
                () => mockGetRandomNumberTriviaUC.getRandomNumberTrivia(),
              ).thenAnswer(
                (_) async => Left(
                  ServerFailure(),
                ),
              );

              // act
              await cubitUnderTest.getRandomNumberTrivia();
            },
            expect: () => [
              HomeLoadingState(),
              HomeErrorState(
                errorMessage: '',
              ),
            ],
            verify: (_) {
              verify(
                () => mockGetRandomNumberTriviaUC.getRandomNumberTrivia(),
              ).called(1);
              verifyNoMoreInteractions(mockGetRandomNumberTriviaUC);
              verifyZeroInteractions(mockGetConcreteNumberTriviaUC);
            },
            build: () => homeCubit,
          );
        };
      },
    );
  });
}
