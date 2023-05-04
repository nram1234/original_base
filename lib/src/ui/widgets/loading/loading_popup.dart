import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//--------------------------------------
import 'package:original_base/src/core/services/localization/localization_helper.dart';
import 'package:original_base/src/ui/responsive_layout/size_extension.dart';
import 'package:original_base/src/config/typography.dart';
//--------------------------------------------------------

void showLoadingPopup(String titleId, BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (ctx) => WillPopScope(
      onWillPop: () => Future.value(false),
      child: AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              titleId.translate(context),
              style: TextStyles.subtitle2.copyWith(
                fontSize: 15.0.sp,
                height: 1.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 25.0),
            CupertinoActivityIndicator(radius: 15.0),
          ],
        ),
      ),
    ),
  );
}
