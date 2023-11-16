import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';

class TargetPlatformInfo extends StatelessWidget {
  const TargetPlatformInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Text(
        "Target platform: ${defaultTargetPlatform.name}",
        textAlign: TextAlign.center,
        style: regular_14.copyWith(color: Colors.grey),
      ),
    );
  }
}
