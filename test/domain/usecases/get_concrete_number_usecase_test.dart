import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_driven/domain/entity/index.dart';
import 'package:test_driven/domain/repository/index.dart';
import 'package:test_driven/domain/usecases/get_concrete_number_usecase.dart';

class MockBaseNumberTriviaRepository extends Mock
    implements BaseNumberTriviaRepository {}

void main() {
  late GetConcreteNumberTriviaUseCase getConcreteNumberTriviaUC;
  late MockBaseNumberTriviaRepository mockBaseNumberRepository;

  setUp(() {
    mockBaseNumberRepository = MockBaseNumberTriviaRepository();
    getConcreteNumberTriviaUC =
        GetConcreteNumberTriviaUseCase(mockBaseNumberRepository);
  });

  test('should get trivia for the number ', () async {
    const testNumberTrivia = 1;
    TriviaResponseEntity testTriviaResponseEntity =
        const TriviaResponseEntity.withParameter(
      description: 'description',
      number: 1,
    );

    TriviaRequestEntity testRequestTriviaEntity =
        const TriviaRequestEntity(numberTrivia: testNumberTrivia);

    // arrange
    when(
      () => mockBaseNumberRepository.getConcreteNumberTrivia(
          requestTriviaEntity: testRequestTriviaEntity,),
    ).thenAnswer(
      (_) async => Right(
        testTriviaResponseEntity,
      ),
    );
    // act
    final result = await getConcreteNumberTriviaUC.getConcreteNumberTrivia(
      requestTriviaEntity: testRequestTriviaEntity,
    );

    //assert -- what do you wanna check for
    verify(
      () => mockBaseNumberRepository.getConcreteNumberTrivia(
        requestTriviaEntity: testRequestTriviaEntity,
      ),
    ).called(1);
    expect(result, Right(testTriviaResponseEntity));
    verifyNoMoreInteractions(mockBaseNumberRepository);
  });
}
