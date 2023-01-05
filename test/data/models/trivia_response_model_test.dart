import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:test_driven/data/models/index.dart';

import '../../fixtures/index.dart';


void main() {

  group('should return triviaResponseModel from json file', () {

    test('should return a valid triviaResponseModel from trivia.json when number is integer', () {

      // arrange
     const testTriviaResponseModel = TriviaResponseModel(
        isFound: true,
        description:
        '418 is the error code for "I\'m a teapot" in the Hyper Text Coffee Pot Control Protocol.',
        number: 418,
      );
      Map<String,dynamic> jsonData = jsonDecode(fixture('trivia.json',),);

      // act
      final result = TriviaResponseModel.fromJson(jsonData: jsonData);

      // assert
      expect(result, testTriviaResponseModel,);
    });

    test('should return a valid triviaResponseModel from trivia_double.json when number is double', (){
      const testTriviaResponseModel = TriviaResponseModel(
        isFound: true,
        description:
        'Test Text',
        number: 1,
      );

      // arrange
      Map<String,dynamic> jsonData = jsonDecode(fixture('trivia_double.json',),);
      // act
      final result = TriviaResponseModel.fromJson(jsonData: jsonData);
      // assert
      expect(result, testTriviaResponseModel);
    });

  });
}
