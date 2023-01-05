import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_driven/domain/entity/index.dart';
import 'package:test_driven/domain/repository/index.dart';
import 'package:test_driven/domain/usecases/get_random_number_trivia_usecase.dart';

class MockBaseNumberTriviaRepository extends Mock implements BaseNumberTriviaRepository{}

void main(){
  late MockBaseNumberTriviaRepository mockBaseNumberTriviaRepository;
  late GetRandomNumberTriviaUseCase getRandomNumberTriviaUseCase;
  setUp(() {
    mockBaseNumberTriviaRepository = MockBaseNumberTriviaRepository();
    getRandomNumberTriviaUseCase = GetRandomNumberTriviaUseCase(mockBaseNumberTriviaRepository);
  });

  test('should return trivia for random number', ()async{

    //arrange
    int testNumber = 1;
    TriviaResponseEntity testTriviaResponseEntity = TriviaResponseEntity.withParameter(description: 'description', number: testNumber,);
    when(()=>mockBaseNumberTriviaRepository.getRandomNumberTrivia()).thenAnswer((_) async=> Right(testTriviaResponseEntity,),);
    //act
    final result = await getRandomNumberTriviaUseCase.getRandomNumberTrivia();
    //assert
    expect(result, Right(testTriviaResponseEntity));
    verify(()=>mockBaseNumberTriviaRepository.getRandomNumberTrivia(),).called(1);
    verifyNoMoreInteractions(mockBaseNumberTriviaRepository);
  });
}