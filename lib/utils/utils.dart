import 'dart:convert';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

class Utils {
  static String reviseOperationID(String? input) => input?.isNotEmpty == true
      ? input!
      : DateTime.now().millisecondsSinceEpoch.toString();

  static ffi.Pointer<ffi.Char> reviseToNativeOperationID(String? operationID) =>
      reviseOperationID(operationID).toNativeChar();

  static jsonDecodeTo<T>(ffi.Pointer<ffi.Char> data) =>
      jsonDecode(data.toDartString()) as T;
}

extension IMStringExt on String {
  ffi.Pointer<ffi.Char> toNativeChar() => toNativeUtf8().cast<ffi.Char>();
}

extension IMPointerStringExt on ffi.Pointer<ffi.Char> {
  // String toDartString() => cast<Utf8>().toDartString();
  String toDartString() {
    if (this == ffi.nullptr) {
      return ''; // Handle null pointer
    }

    int length = 0;
    while (elementAt(length).value != 0) {
      length++;
    }

    final List<int> codeUnits =
        List<int>.generate(length, (index) => elementAt(index).value);

    return String.fromCharCodes(codeUnits);
  }
}
