extension ParseString on String {
  int? parseStringToInt() {
    return int.tryParse(this);
  }
}
