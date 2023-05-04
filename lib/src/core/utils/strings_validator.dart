class StringsValidator {
  static const String _validEmailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static bool validateUserName(
    String userName, {
    bool skipEmpty = false,
  }) {
    if (skipEmpty && userName.isEmpty) return true;
    return userName.trim().length >= 3;
  }

  static bool validateEmail(
    String email, {
    bool skipEmpty = false,
  }) {
    if (skipEmpty && email.isEmpty) return true;
    RegExp emailRegex = RegExp(_validEmailRegex);
    return emailRegex.hasMatch(email);
  }

  static bool validatePhoneNumber(
    String phoneNumber, {
    bool skipEmpty = false,
  }) {
    if (skipEmpty && phoneNumber.isEmpty) return true;
    bool sufficientLength = phoneNumber.length == 11;
    bool egyptianNumber = phoneNumber.startsWith("01");
    return sufficientLength && egyptianNumber;
  }

  static bool validatePassword(
    String password, {
    bool skipEmpty = false,
  }) {
    if (skipEmpty && password.isEmpty) return true;
    return password.trim().length >= 8;
  }

  static bool validateAddress(
    String address, {
    bool skipEmpty = false,
  }) {
    if (skipEmpty && address.isEmpty) return true;

    return address.length >= 10 && address.contains(" ");
  }
}
