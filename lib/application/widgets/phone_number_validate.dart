bool phoneNumberValidate(String phoneNumber) {
  bool result;
  RegExp regExp;

  if (phoneNumber[0] == "+") {
    regExp = RegExp(r"^[+]\d{11,14}$");
  } else {
    print("Without +");
    regExp = RegExp(r"^\d{11,14}$");
  }

  if (regExp.hasMatch(phoneNumber)) {
    result = true;
  } else {
    result = false;
  }
  print(result);
  return result;
}
