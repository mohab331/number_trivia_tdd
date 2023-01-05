import 'package:equatable/equatable.dart';
import 'package:test_driven/data/models/base_model.dart';
import 'package:test_driven/domain/entity/index.dart';

class TriviaRequestModel extends Equatable
    implements BaseModel<TriviaRequestEntity, TriviaRequestModel> {
  const TriviaRequestModel({
    this.numberTrivia,
  });

  final int? numberTrivia;

  @override
  TriviaRequestEntity toEntity() {
    return TriviaRequestEntity(numberTrivia: numberTrivia);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'number': numberTrivia,
    };
  }

  @override
  TriviaRequestModel fromEntity({required TriviaRequestEntity entity}) {
    return TriviaRequestModel(
      numberTrivia: entity.numberTrivia,
    );
  }

  @override
  List<Object?> get props => [numberTrivia];
}
