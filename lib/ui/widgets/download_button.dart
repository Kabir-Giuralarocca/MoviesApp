import 'package:flutter/material.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({
    super.key,
    this.onPressed,
    required this.label,
  });

  final void Function()? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      // visible: kIsWeb && defaultTargetPlatform == TargetPlatform.android,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: const Icon(Icons.download),
          label: Text(label),
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                backgroundColor:
                    MaterialStatePropertyAll(Colors.blueGrey.shade900),
              ),
        ),
      ),
    );
  }
}
