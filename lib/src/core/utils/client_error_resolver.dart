import 'dart:io';
//---------------
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
//--------------------------------------------------------------
import 'package:original_base/src/core/services/notifications/firebase_messaging_service.dart';
import 'package:original_base/src/core/services/shared/sailor_navigation_service.dart';
import 'package:original_base/src/config/hive_boxes.dart';
import 'package:original_base/src/config/errors_ids.dart';
//--------------------------------------------------------

String resolveClientError(error, stackTrace) {
  if (_isNetworkConnectionError(error)) {
    return ErrorsIds.networkError;
  } else if (_isUnauthorizedAccessError(error)) {
    FirebaseMessagingService().invalidateDevicePushToken();
    Future.delayed(const Duration(seconds: 3), () {
      HiveBoxes.loggedInUser.clear();
      Sailor.startOverFrom("auth/intro");
    });
    return ErrorsIds.sessionExpired;
  }

  // if the error is not a network connection error then it's an unexpected error
  // and therefore this indicates a system internal error.
  FirebaseCrashlytics.instance.recordError(error, stackTrace);
  return ErrorsIds.internalError;
}

bool _isNetworkConnectionError(error) {
  return error is SocketException ||
      (error is DioError &&
          error.type == DioErrorType.other &&
          error.error is SocketException);
}

bool _isUnauthorizedAccessError(error) {
  return error is DioError &&
      error.response != null &&
      error.response!.statusCode == 401;
}
