import 'package:equatable/equatable.dart';
import 'package:test_driven/data/models/base_model.dart';
import 'package:test_driven/domain/entity/index.dart';

class TriviaResponseModel extends Equatable
    implements BaseModel<TriviaResponseEntity, TriviaResponseModel> {
  const TriviaResponseModel({
    this.number,
    this.description,
    this.isFound,
  });

  factory TriviaResponseModel.fromJson({
    required Map<String, dynamic>? jsonData,
  }) =>
      TriviaResponseModel(
        number: (jsonData?['number'] as num).toInt(),
        description: jsonData?['text'].toString(),
        isFound: jsonData?['found'],
      );
  final int? number;
  final String? description;
  final bool? isFound;

  @override
  TriviaResponseEntity toEntity() {
    return TriviaResponseEntity.withParameter(
      description: description,
      number: number,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'text': description,
      'found': isFound,
    };
  }

  @override
  List<Object?> get props => [
        number,
        description,
        isFound,
      ];

  @override
  TriviaResponseModel fromEntity({required TriviaResponseEntity entity}) {
    return TriviaResponseModel(
      number: entity.number,
      description: entity.description,
      isFound: true,
    );
  }
}
