bool carNumberValidate(String carNumber) {
  bool result;
  print(carNumber);
  final regExp = RegExp(r"^[АВЕКМНОРСТУХ]{1}[0-9]{3}[АВЕКМНОРСТУХ]{2}\d{2,3}$");

  if (regExp.hasMatch(carNumber)) {
    result = true;
  } else {
    result = false;
  }
  print(result);
  return result;
}
