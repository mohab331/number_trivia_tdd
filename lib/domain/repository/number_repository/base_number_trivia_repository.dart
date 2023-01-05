import 'package:dartz/dartz.dart';
import 'package:test_driven/core/error/failure.dart';

import '../../entity/index.dart';

abstract class BaseNumberTriviaRepository {
  Future<Either<Failure, TriviaResponseEntity>> getConcreteNumberTrivia({
    required TriviaRequestEntity requestTriviaEntity,
  });

  Future<Either<Failure, TriviaResponseEntity>> getRandomNumberTrivia();
}
