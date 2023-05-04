import 'dart:typed_data';
//-----------------------
import 'package:flutter/services.dart';
//-------------------------------------

Future<Uint8List> convertAssetFileToUnit8List(String filePath) async {
  ByteData byteData = await rootBundle.load("assets/$filePath");
  return byteData.buffer.asUint8List();
}
