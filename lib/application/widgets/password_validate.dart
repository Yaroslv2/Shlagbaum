bool isPasswordValid(String password) {
  bool result;
  final RegExp regExp = RegExp(r"[0-9a-zA-z]");

  if (regExp.hasMatch(password)) {
    result = true;
  } else {
    result = false;
  }
  return result;
}
