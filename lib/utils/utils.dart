import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/foundation.dart';

import '../enum/enum.dart';
import 'define.dart';

class Utils {
  static String reviseOperationID(String? input) =>
      input?.isNotEmpty == true ? input! : DateTime.now().millisecondsSinceEpoch.toString();

  static ffi.Pointer<ffi.Char> reviseToNativeOperationID(String? operationID) =>
      reviseOperationID(operationID).toNativeChar();

  static Pointer<NativeFunction<CBSISSFunc>> createCBSISSFuncNativeCallable({
    required void Function(dynamic data) onSuccess,
    required void Function(IMSDKError error) onError,
  }) {
    late final ffi.NativeCallable<CBSISSFunc> callback;

    void onResponse(
      ffi.Pointer<ffi.Char> operationID,
      int errorCode,
      ffi.Pointer<ffi.Char> errorMsg,
      ffi.Pointer<ffi.Char> data,
    ) {
      if (errorCode > 0) {
        debugPrint(
            'Native CBSISS return failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        onError.call(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));

        if (errorMsg != ffi.nullptr) {
          calloc.free(errorMsg);
        }
      } else {
        final dataString = data.toDartString();

        debugPrint(
            'Native CBSISS return success: ${operationID.toDartString()}, $errorCode, $dataString[${dataString.length}]');

        if (dataString.isNotEmpty) {
          final json = jsonDecode(dataString);
          onSuccess.call(json);
        }

        if (data != ffi.nullptr) {
          calloc.free(data);
        }
      }

      calloc.free(operationID);
      callback.close();
    }

    callback = ffi.NativeCallable.listener(onResponse);

    return callback.nativeFunction;
  }

  static Pointer<NativeFunction<CBSISSIFunc>> createCBSISSIFuncNativeCallable({
    required void Function(int progress) onProgress,
    required void Function(dynamic data) onSuccess,
    required void Function(IMSDKError error) onError,
  }) {
    late final ffi.NativeCallable<CBSISSIFunc> callback;

    void onResponse(
      ffi.Pointer<ffi.Char> operationID,
      int errorCode,
      ffi.Pointer<ffi.Char> errorMsg,
      ffi.Pointer<ffi.Char> data,
      int progress,
    ) {
      if (errorCode > 0) {
        debugPrint('Native CBSISSI failed: ${operationID.toDartString()}, $errorCode, ${errorMsg.toDartString()}');
        onError.call(IMSDKError(SDKErrorCode.fromValue(errorCode), errorMsg.toDartString()));

        if (errorMsg != ffi.nullptr) {
          calloc.free(errorMsg);
        }
      } else {
        final dataString = data.toDartString();

        debugPrint(
            'Native CBSISSI success: ${operationID.toDartString()}, $errorCode, $dataString[${dataString.length}]');

        if (progress > 0) {
          onProgress.call(progress);
        }

        if (dataString.isNotEmpty) {
          final json = jsonDecode(dataString);
          onSuccess.call(json);
        }

        if (data != ffi.nullptr) {
          calloc.free(data);
        }
      }

      calloc.free(operationID);
      callback.close();
    }

    callback = ffi.NativeCallable.listener(onResponse);

    return callback.nativeFunction;
  }
}

extension IMStringExt on String {
  ffi.Pointer<ffi.Char> toNativeChar() => toNativeUtf8().cast<ffi.Char>();
}

extension IMPointerStringExt on ffi.Pointer<ffi.Char> {
  String toDartString() {
    if (this == ffi.nullptr) {
      return ''; // Handle null pointer
    }

    return cast<Utf8>().toDartString();
  }

  // String toDartString() {
  //   if (this == ffi.nullptr) {
  //     return ''; // Handle null pointer
  //   }
  //
  //   int length = 0;
  //   while (elementAt(length).value != 0) {
  //     length++;
  //   }
  //
  //   final List<int> codeUnits = List<int>.generate(length, (index) => elementAt(index).value);
  //
  //   return String.fromCharCodes(codeUnits);
  // }
}
