import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//-------------------------------------
import 'package:original_base/src/ui/responsive_layout/size_extension.dart';
import 'package:original_base/src/config/typography.dart';
import 'package:original_base/src/config/app_theme.dart';
import 'package:original_base/src/config/palette.dart';
//-----------------------------------------------------

class SmsCodeEntry extends StatelessWidget {
  final int fieldsCount = 4;

  final bool autoFocusFirstField;

  final ValueChanged<String> onSubmitted;

  SmsCodeEntry({
    required this.autoFocusFirstField,
    required this.onSubmitted,
  });

  late final List<String> _pins = List.filled(fieldsCount, "");
  late final List<FocusNode?> _focusNodes = List.filled(fieldsCount, null);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          fieldsCount,
          (i) {
            return Container(
              width: 40.0.w,
              height: 40.0.h,
              margin: const EdgeInsets.only(right: 15.0),
              decoration: BoxDecoration(
                color: Palette.desertStorm,
                borderRadius: BorderRadius.circular(
                  SharedStyles.smallComponentsRadius,
                ),
              ),
              child: Center(
                child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  textInputAction: i == fieldsCount - 1
                      ? TextInputAction.done
                      : TextInputAction.next,
                  cursorColor: Palette.burntSienna,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                  ],
                  autofocus: i == 0 && autoFocusFirstField,
                  style: TextStyles.h5.copyWith(
                    height: 1.0,
                    fontWeight: FontWeight.w500,
                    color: Palette.bigStone,
                    fontFamily: FontFamilies.roboto,
                  ),
                  focusNode: _focusNodes[i],
                  decoration: InputDecoration.collapsed(
                    border: InputBorder.none,
                    hintText: "-",
                    hintStyle: TextStyle(height: 1.0),
                  ),
                  onChanged: (String digit) {
                    _pins[i] = digit;
                    if (digit.isNotEmpty && i != fieldsCount - 1) {
                      FocusScope.of(context).nextFocus();
                    }
                    if (_pins.every((String digit) => digit.isNotEmpty)) {
                      FocusScope.of(context).unfocus();
                      onSubmitted(_pins.join());
                    }
                  },
                  onSubmitted: (_) => onSubmitted(_pins.join()),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
