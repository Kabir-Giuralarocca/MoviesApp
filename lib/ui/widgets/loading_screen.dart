import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
    required this.child,
    required this.showLoader,
  });

  final Widget child;
  final bool showLoader;

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
          child: const Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}
