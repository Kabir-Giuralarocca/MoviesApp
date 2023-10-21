import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

const width_4 = SizedBox(width: 4);

const height_4 = SizedBox(height: 4);
const height_8 = SizedBox(height: 8);
const height_16 = SizedBox(height: 16);
const height_24 = SizedBox(height: 24);
const height_36 = SizedBox(height: 36);
const height_68 = SizedBox(height: 68);

// Layout
Widget filler = Expanded(child: Container());

// Shadows
List<BoxShadow> lightShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.08),
    spreadRadius: 5,
    blurRadius: 16,
    offset: const Offset(0, 2),
  )
];

List<BoxShadow> darkShadow = [
  BoxShadow(
    color: Colors.black.withOpacity(0.25),
    spreadRadius: 2,
    blurRadius: 24,
    offset: const Offset(0, 2),
  )
];

// Loader
Dialog loaderDialog = const Dialog(
  backgroundColor: Colors.transparent,
  surfaceTintColor: Colors.transparent,
  shadowColor: Colors.transparent,
  child: Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircularProgressIndicator(),
    ],
  ),
);

// SnackBar
SnackBar messageSnackBar({
  required String message,
  bool isError = false,
  String? label,
  void Function()? onPressed,
}) {
  return SnackBar(
    backgroundColor: isError ? Colors.red : Colors.blueGrey,
    content: Text(message),
    action: label != null && onPressed != null
        ? SnackBarAction(label: label, onPressed: onPressed)
        : null,
  );
}

// Shimmer
class BaseShimmer extends StatelessWidget {
  const BaseShimmer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade500,
      period: const Duration(seconds: 1),
      child: child,
    );
  }
}
