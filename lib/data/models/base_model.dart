abstract class BaseModel<T, M> {
  T toEntity();

  Map<String, dynamic> toJson();

  M fromEntity({
    required T entity,
  });
}
