import 'package:flutter/foundation.dart';

const port = "44342";
get localhost {
  if (defaultTargetPlatform == TargetPlatform.iOS) {
    return "127.0.0.1";
  } else if (defaultTargetPlatform == TargetPlatform.android) {
    return "10.0.2.2";
  } else {
    return "localhost";
  }
}

final baseUrl = "$localhost:$port";
