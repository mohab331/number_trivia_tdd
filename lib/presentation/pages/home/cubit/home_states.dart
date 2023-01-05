import 'package:equatable/equatable.dart';
import 'package:test_driven/domain/entity/index.dart';

abstract class HomeStates extends Equatable {}

class HomeInitialState extends HomeStates {
  @override
  List<Object?> get props => [];
}

class HomeLoadingState extends HomeStates {
  @override
  List<Object?> get props => [];
}

class HomeErrorState extends HomeStates {
  HomeErrorState({
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  List<Object?> get props => [];
}

class HomeGetNumberSuccessState extends HomeStates {
  HomeGetNumberSuccessState({
    required this.triviaResponseEntity,
  });

  final TriviaResponseEntity triviaResponseEntity;

  @override
  List<Object?> get props => [triviaResponseEntity];
}
