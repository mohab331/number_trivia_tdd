import 'package:dartz/dartz.dart';
import 'package:test_driven/core/error/failure.dart';
import 'package:test_driven/domain/entity/index.dart';
import 'package:test_driven/domain/repository/index.dart';

class GetConcreteNumberTriviaUseCase {
  const GetConcreteNumberTriviaUseCase(
    this._baseNumberTriviaRepository,
  );

  final BaseNumberTriviaRepository _baseNumberTriviaRepository;

  Future<Either<Failure, TriviaResponseEntity>> getConcreteNumberTrivia({
    required TriviaRequestEntity requestTriviaEntity,
  }) async {
    return await _baseNumberTriviaRepository.getConcreteNumberTrivia(
      requestTriviaEntity: requestTriviaEntity,
    );
  }
}
