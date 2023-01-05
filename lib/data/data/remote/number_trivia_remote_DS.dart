import 'package:dio/dio.dart';
import 'package:test_driven/core/error/exceptions.dart';
import 'package:test_driven/data/data/index.dart';
import 'package:test_driven/data/models/index.dart';

abstract class NumberTriviaRemoteDS {
  Future<TriviaResponseModel> getConcreteNumberTrivia({
    required TriviaRequestModel triviaRequestModel,
  });

  Future<TriviaResponseModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDSImpl implements NumberTriviaRemoteDS {
  NumberTriviaRemoteDSImpl({
    required this.dio,
  });

  Dio dio;

  @override
  Future<TriviaResponseModel> getConcreteNumberTrivia({
    required TriviaRequestModel triviaRequestModel,
  }) async {
    final response = await dio.get(
      triviaRequestModel.numberTrivia.toString(),
      options: Options(
        contentType: 'application/json',
      ),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    }
    return TriviaResponseModel.fromJson(
      jsonData: response.data,
    );
  }

  @override
  Future<TriviaResponseModel> getRandomNumberTrivia() async {
    final response = await dio.get(
      ApiEndpoints.getRandomTrivia,
      options: Options(
        contentType: 'application/json',
      ),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    }
    return TriviaResponseModel.fromJson(
      jsonData: response.data,
    );
  }
}
