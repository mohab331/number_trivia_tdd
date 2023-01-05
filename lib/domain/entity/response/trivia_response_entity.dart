import 'package:equatable/equatable.dart';

class TriviaResponseEntity extends Equatable {
  const TriviaResponseEntity({
    this.number,
    this.description,
  });

  const TriviaResponseEntity.withParameter({
    required this.description,
    required this.number,
  });

  final String? description;
  final int? number;

  @override
  List<Object?> get props => [
        number,
        description,
      ];
}
