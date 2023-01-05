import 'package:dartz/dartz.dart';
import 'package:test_driven/core/error/failure.dart';
import 'package:test_driven/domain/entity/index.dart';
import 'package:test_driven/domain/repository/index.dart';

class GetRandomNumberTriviaUseCase {
  GetRandomNumberTriviaUseCase(this._baseNumberTriviaRepository);

  final BaseNumberTriviaRepository _baseNumberTriviaRepository;

  Future<Either<Failure, TriviaResponseEntity>> getRandomNumberTrivia() async {
    return await _baseNumberTriviaRepository.getRandomNumberTrivia();
  }
}
