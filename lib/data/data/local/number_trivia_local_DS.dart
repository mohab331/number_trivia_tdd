import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_driven/core/error/exceptions.dart';
import 'package:test_driven/data/data/index.dart';
import 'package:test_driven/data/index.dart';

abstract class NumberTriviaLocalDS {
  Future<TriviaResponseModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia({
    required TriviaResponseModel triviaResponseModel,
  });
}

class NumberTriviaLocalDSImpl implements NumberTriviaLocalDS {
  NumberTriviaLocalDSImpl({
    required this.sharedPreferences,
  });

  SharedPreferences sharedPreferences;

  @override
  Future<TriviaResponseModel> getLastNumberTrivia() async {
    final response =
        sharedPreferences.getString(ConstantMapKeys.cachedNumberTrivia);
    if (response == null) {
      throw CacheException();
    }
    return TriviaResponseModel.fromJson(
      jsonData: json.decode(
        response,
      ),
    );
  }

  @override
  Future<void> cacheNumberTrivia({
    required TriviaResponseModel triviaResponseModel,
  }) async {
    final response = await sharedPreferences.setString(
      ConstantMapKeys.cachedNumberTrivia,
      json.encode(
        triviaResponseModel.toJson(),
      ),
    );
    if (response == false) {
      throw CacheException();
    }
  }
}
