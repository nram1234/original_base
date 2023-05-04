/// This class contains shared APIs used on original apps.
class APIs {
  static const String _baseUrl = "https://original1.online/api/v1";

  // auth APIs
  static const String logout = "$_baseUrl/logout";
  static const String revokeToken = "$_baseUrl/revoke";
  static const String resetPassword = "$_baseUrl/password/reset";
  static const String forgotPassword = "$_baseUrl/forgot-password";
  static const String socialTokenRevoke = "$_baseUrl/social-revoke";

  // cars types APIs
  static const String carBrands = "$_baseUrl/all-marks";
  static const String carModels = "$_baseUrl/models-by-mark";
  static const String carEngines = "$_baseUrl/model-engines";
  static const String yearsOfManufacture = "$_baseUrl/model-years";

  // chat APIs
  static const String singleUser = "$_baseUrl/single-user";
  static const String chatMediaUpload = "$_baseUrl/chat-file";

  // dashboard APIs
  static const String technicalSupport = "$_baseUrl/contact";

  // merchants APIs
  static const String merchantsCities = "$_baseUrl/all-addresses";

  // profile APIs
  static const String updateProfile = "$_baseUrl/update-profile";
}

/// This class contains messages returned from APIs requests.
class APIsMessages {
  static const String passwordResetEmailSent = "Mail send successfully";
  static const String passwordResetDone = "Password reset successfully";
  static const String wrongPasswordResetCode = "Your Code  inCorrect";
}
