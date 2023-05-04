import 'package:flutter_svg/svg.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
//-------------------------------------
import 'package:original_base/src/core/services/shared/expire_date_formatter.dart';
import 'package:original_base/src/ui/responsive_layout/size_extension.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class OriginalTextField extends StatelessWidget {
  final bool enabled;
  final bool secret;
  final bool allowDigitsOnly;
  final bool preventWhiteSpaces;
  final bool enableCopyAndPaste;

  /// determines if this is a search text field or not.
  final bool searchTextField;

  /// determines if this is a multiline text field or not.
  final bool textArea;

  /// determines if this text field is used to enter a card expire date.
  final bool expireDateEntry;

  /// determines if this text field is used to enter a CCV number.
  final bool ccvEntry;

  /// determines if this text field is used to enter a card number.
  final bool cardNumber;

  /// determines if the user will write a promo code in this field.
  final bool promoCode;

  final String? errorText;
  final String hintText;

  final TextInputType inputType;

  final TextEditingController? controller;

  final ValueChanged<String>? onChanged;

  /// a callback function that gets executed on text submission.
  final ValueChanged<String>? onSubmitted;

  final Widget? suffix;

  double get textHeight {
    if (searchTextField) {
      return 1.25;
    } else if (textArea) {
      return 1.4;
    } else {
      return 1.0;
    }
  }

  const OriginalTextField({
    this.enabled = true,
    this.enableCopyAndPaste = true,
    this.searchTextField = false,
    this.preventWhiteSpaces = false,
    this.allowDigitsOnly = false,
    this.secret = false,
    this.textArea = false,
    this.expireDateEntry = false,
    this.ccvEntry = false,
    this.cardNumber = false,
    this.promoCode = false,
    this.hintText = "",
    this.errorText,
    this.inputType = TextInputType.text,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      controller: controller,
      keyboardType: textArea ? TextInputType.multiline : inputType,
      maxLines: textArea ? 3 : 1,
      minLines: textArea ? 3 : null,
      style: TextStyles.body1.copyWith(
        fontSize: 15.0.sp,
        height: textHeight,
      ),
      toolbarOptions: ToolbarOptions(
        cut: enableCopyAndPaste,
        copy: enableCopyAndPaste,
        paste: enableCopyAndPaste,
        selectAll: enableCopyAndPaste,
      ),
      obscureText: secret,
      cursorColor: Palette.burntSienna,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        fillColor: Palette.solitude,
        hintText: hintText,
        hintStyle: TextStyles.body2.copyWith(
          height: textHeight,
          color: Palette.spunPearl,
        ),
        errorText: errorText,
        errorStyle: TextStyles.caption.copyWith(
          height: 1.0,
          fontSize: 13.0.sp,
          color: Palette.burntSienna,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: SharedStyles.componentsPadding,
          horizontal: 8.0,
        ),
        prefixIconConstraints: BoxConstraints(
          maxHeight: 20.0.h,
          maxWidth: 40.0.w,
        ),
        prefixIcon: searchTextField
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SvgPicture.asset("assets/icons/search_icon.svg"),
              )
            : null,
        suffixIcon: suffix,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(
            SharedStyles.smallComponentsRadius,
          ),
        ),
      ),
      inputFormatters: [
        if (inputType == TextInputType.phone || allowDigitsOnly)
          FilteringTextInputFormatter.digitsOnly,
        if (preventWhiteSpaces) ...[
          FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
          FilteringTextInputFormatter.deny(" "),
        ],
        if (inputType == TextInputType.phone) ...[
          LengthLimitingTextInputFormatter(11),
          FilteringTextInputFormatter(" ", allow: false),
        ],
        if (expireDateEntry) ...[
          LengthLimitingTextInputFormatter(5),
          ExpireDateFormatter(),
        ],
        if (ccvEntry) LengthLimitingTextInputFormatter(4),
        if (cardNumber) LengthLimitingTextInputFormatter(16),
        if (promoCode) LengthLimitingTextInputFormatter(6),
      ],
    );
  }
}
