import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/core/services/shared/sailor_navigation_service.dart';
import 'package:original_base/src/core/services/auth/forgot_password_client.dart';
import 'package:original_base/src/core/models/results/http_client_result.dart';
import 'package:original_base/src/ui/widgets/popups/snack_bar_alert.dart';
import 'package:original_base/src/core/utils/strings_validator.dart';
//-------------------------------------------------------------------

final forgotPasswordProvider = ChangeNotifierProvider.autoDispose((_) {
  return ForgotPasswordNotifier();
});

class ForgotPasswordNotifier extends ChangeNotifier {
  bool isLoading = false;
  bool emailError = false;

  final emailController = TextEditingController();

  /// controllers texts getters.
  String get _email => emailController.text;

  /// validation results getters.
  bool get _validEmail => StringsValidator.validateEmail(_email);

  bool get _validInput {
    // update errors states
    updateEmailErrorState();

    return _validEmail;
  }

  Future<void> emitForgotPasswordEvent(BuildContext context) async {
    // if input is not valid, do not send reset password email.
    if (!_validInput) return;

    _changeLoadingState(true);

    var result = await ForgotPasswordClient().requestResetCode(_email);

    // resolve forgot password result
    if (result is SuccessfulRequest) {
      Sailor.toNamed(
        "auth/reset_password",
        args: {"email": _email},
      );
      Fluttertoast.showToast(
        msg: "#reset_password_code_sent".translate(context),
      );
    } else if (result is FailedRequest) {
      showSnackBarAlert(result.errorId, context);
    }

    _changeLoadingState(false);
  }

  void updateEmailErrorState() {
    bool emailHasError = !_validEmail;
    if (emailError != emailHasError) {
      emailError = emailHasError;
      notifyListeners();
    }
  }

  void _changeLoadingState(bool newBool) {
    isLoading = newBool;
    notifyListeners();
  }
}
