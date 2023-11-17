import 'package:flutter/foundation.dart';

final bool isAndroid = defaultTargetPlatform == TargetPlatform.android;
final bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;
final bool isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
final bool isWindows = defaultTargetPlatform == TargetPlatform.windows;

final isMobile = isAndroid && isIOS;
