import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.onIconTap,
  });

  final String label;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final VoidCallback? onIconTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: formInputDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormInputLabel(label: label),
          height_4,
          TextFormField(
            style: regular_14,
            obscureText: obscureText,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              hintText: hint,
              // errorText: "Campo obbligatiorio!",
              suffixIcon: GestureDetector(
                onTap: onIconTap,
                child: Icon(
                  icon,
                  size: 24,
                ),
              ),
              suffixIconConstraints: const BoxConstraints(
                maxHeight: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FormInputLabel extends StatelessWidget {
  const FormInputLabel({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: semibold_12.copyWith(
        color: Colors.grey[700],
      ),
    );
  }
}

final Decoration formInputDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(8),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      spreadRadius: 0,
      blurRadius: 24,
      offset: const Offset(0, 2),
    )
  ],
);
