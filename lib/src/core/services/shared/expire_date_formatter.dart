import 'package:flutter/services.dart';
//-------------------------------------

class ExpireDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(_, TextEditingValue newValue) {
    String valueToReturn = "";
    String newValueString = newValue.text;

    for (int i = 0; i < newValueString.length; i++) {
      if (newValueString[i] != "/") {
        valueToReturn += newValueString[i];
      }

      bool containsSlash = valueToReturn.contains(RegExp(r'\/'));
      int nonZeroIndex = i + 1;

      if (nonZeroIndex % 2 == 0 &&
          nonZeroIndex != newValueString.length &&
          !(containsSlash)) {
        valueToReturn += "/";
      }
    }

    return newValue.copyWith(
      text: valueToReturn,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}
