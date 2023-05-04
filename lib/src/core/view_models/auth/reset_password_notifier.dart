import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/core/services/shared/sailor_navigation_service.dart';
import 'package:original_base/src/core/services/auth/reset_password_client.dart';
import 'package:original_base/src/core/models/results/http_client_result.dart';
import 'package:original_base/src/ui/widgets/popups/snack_bar_alert.dart';
import 'package:original_base/src/core/utils/strings_validator.dart';
//-------------------------------------------------------------------

final resetPasswordProvider = ChangeNotifierProvider.autoDispose((_) {
  return ResetPasswordNotifier();
});

class ResetPasswordNotifier extends ChangeNotifier {
  bool isLoading = false;
  bool passwordError = false;
  bool verificationCodeError = false;
  bool passwordConfirmationError = false;

  final passwordConfirmationController = TextEditingController();
  final verificationCodeController = TextEditingController();
  final passwordController = TextEditingController();

  /// controllers texts getters.
  String get _passwordConfirmation => passwordConfirmationController.text;
  String get _verificationCode => verificationCodeController.text;
  String get _password => passwordController.text;

  /// validation results getters.
  bool get _validPasswordConfirmation => _password == _passwordConfirmation;
  bool get _validPassword => StringsValidator.validatePassword(_password);
  bool get _validVerificationCode => _verificationCode.isNotEmpty;

  bool get _validInput {
    // update errors states
    updatePasswordConfirmationErrorState();
    updateVerificationCodeErrorState();
    updatePasswordErrorState();

    return _validPassword &&
        _validPasswordConfirmation &&
        _validVerificationCode;
  }

  Future<void> resetUserPassword({
    required String email,
    required BuildContext context,
  }) async {
    // if input is not valid, do not request password reset.
    if (!_validInput) return;

    _changeLoadingState(true);

    var result = await ResetPasswordClient().requestPasswordReset(
      email: email,
      newPassword: _password,
      verificationCode: _verificationCode,
    );

    // resolve reset password result
    if (result is SuccessfulRequest) {
      Sailor.toNamed("auth/login");
      Fluttertoast.showToast(
        msg: "#password_reset_done".translate(context),
      );
    } else if (result is FailedRequest) {
      showSnackBarAlert(result.errorId, context);
    }

    _changeLoadingState(false);
  }

  void updateVerificationCodeErrorState() {
    bool verificationCodeHasError = !_validVerificationCode;
    if (verificationCodeError != verificationCodeHasError) {
      verificationCodeError = verificationCodeHasError;
      notifyListeners();
    }
  }

  void updatePasswordErrorState() {
    bool passwordHasError = !_validPassword;
    if (passwordError != passwordHasError) {
      passwordError = passwordHasError;
      notifyListeners();
    }
  }

  void updatePasswordConfirmationErrorState() {
    bool passwordConfirmationHasError = !_validPasswordConfirmation;
    if (passwordConfirmationError != passwordConfirmationHasError) {
      passwordConfirmationError = passwordConfirmationHasError;
      notifyListeners();
    }
  }

  void _changeLoadingState(bool newBool) {
    isLoading = newBool;
    notifyListeners();
  }
}
