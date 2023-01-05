extension NumberValidation on String? {
  String? validateNumber() {
    if (this == null || this == '' || int.tryParse(this!) == null) {
      return 'Please Enter A valid Number';
    }
    return null;
  }
}
