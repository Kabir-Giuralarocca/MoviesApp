import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
    required this.child,
    required this.showLoader,
    this.progress,
  });

  final Widget child;
  final bool showLoader;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: showLoader ? 0.3 : 1,
          child: AbsorbPointer(absorbing: showLoader, child: child),
        ),
        Visibility(
          visible: showLoader,
          child: Center(child: CircularProgressIndicator(value: progress)),
        ),
      ],
    );
  }
}
