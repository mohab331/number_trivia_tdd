import 'package:equatable/equatable.dart';

class TriviaRequestEntity extends Equatable {
  const TriviaRequestEntity({
    required this.numberTrivia,
  });

  final int? numberTrivia;

  @override
  List<Object?> get props => [numberTrivia];
}
