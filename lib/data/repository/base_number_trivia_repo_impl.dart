import 'package:dartz/dartz.dart';
import 'package:test_driven/core/error/exceptions.dart';
import 'package:test_driven/core/index.dart';
import 'package:test_driven/data/data/index.dart';
import 'package:test_driven/data/index.dart';

import '../../domain/index.dart';

class BaseNumberTriviaRepoImpl implements BaseNumberTriviaRepository {
  BaseNumberTriviaRepoImpl({
    required this.networkChecker,
    required this.numberTriviaLocalDS,
    required this.numberTriviaRemoteDS,
  });

  NumberTriviaRemoteDS numberTriviaRemoteDS;
  NumberTriviaLocalDS numberTriviaLocalDS;
  NetworkChecker networkChecker;

  Future<Either<Failure, TriviaResponseEntity>> _getRemoteAndCacheData({
    required Future<TriviaResponseModel> Function() execute,
  }) async {
    try {
      if (await networkChecker.isConnected()) {
        final triviaResponseModel = await execute();
        await numberTriviaLocalDS.cacheNumberTrivia(
          triviaResponseModel: triviaResponseModel,
        );
        return Right(
          triviaResponseModel.toEntity(),
        );
      } else {
        final localNumberTrivia =
            await numberTriviaLocalDS.getLastNumberTrivia();
        return Right(
          localNumberTrivia.toEntity(),
        );
      }
    } on ServerException {
      return Left(
        ServerFailure(),
      );
    } on CacheException {
      return Left(
        CacheFailure(),
      );
    }
  }

  @override
  Future<Either<Failure, TriviaResponseEntity>> getConcreteNumberTrivia({
    required TriviaRequestEntity requestTriviaEntity,
  }) async {
    return await _getRemoteAndCacheData(
      execute: () async {
        final concreteNumberTriviaModel =
            await numberTriviaRemoteDS.getConcreteNumberTrivia(
          triviaRequestModel: const TriviaRequestModel()
              .fromEntity(entity: requestTriviaEntity),
        );
        return concreteNumberTriviaModel;
      },
    );
  }

  @override
  Future<Either<Failure, TriviaResponseEntity>> getRandomNumberTrivia() async {
    return await _getRemoteAndCacheData(
      execute: () async {
        final randomNumberTriviaModel =
            await numberTriviaRemoteDS.getRandomNumberTrivia();
        return randomNumberTriviaModel;
      },
    );
  }
}
