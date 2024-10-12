import 'dart:ffi' as ffi;

import '../enum/enum.dart';

typedef CBSFunc = ffi.Void Function(
  ffi.Pointer<ffi.Char>,
);

typedef CBISFunc = ffi.Void Function(
  ffi.Int,
  ffi.Pointer<ffi.Char>,
);

typedef CBIS = ffi.Pointer<ffi.NativeFunction<CBISFunc>>;

typedef CBSISSFunc = ffi.Void Function(
  ffi.Pointer<ffi.Char>,
  ffi.Int,
  ffi.Pointer<ffi.Char>,
  ffi.Pointer<ffi.Char>,
);
typedef CBSISSIFunc = ffi.Void Function(
  ffi.Pointer<ffi.Char>,
  ffi.Int,
  ffi.Pointer<ffi.Char>,
  ffi.Pointer<ffi.Char>,
  ffi.Int,
);

class IMSDKError extends Error {
  final SDKErrorCode code;
  final String? message;

  IMSDKError(
    this.code,
    this.message,
  );
}
