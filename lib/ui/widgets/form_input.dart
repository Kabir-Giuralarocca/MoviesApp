import 'package:flutter/material.dart';
import 'package:flutter_movies_app/ui/theme/text_styles.dart';
import 'package:flutter_movies_app/ui/utils/common_widget.dart';
import 'package:flutter_movies_app/ui/utils/form_validators.dart';

class FormInput extends StatefulWidget {
  const FormInput({
    super.key,
    required this.label,
    required this.hint,
    this.icon,
    this.obscureText = false,
    this.onIconTap,
    this.controller,
    this.validator,
    this.maxLines,
    this.onTap,
  });

  final String label;
  final String hint;
  final IconData? icon;
  final int? maxLines;
  final bool obscureText;
  final VoidCallback? onIconTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function()? onTap;

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? () => focusNode.requestFocus(),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: formInputDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.label.toUpperCase(),
              style: semibold_12.copyWith(color: Colors.grey[700]),
            ),
            height_4,
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              focusNode: focusNode,
              controller: widget.controller,
              validator: widget.validator ?? requiredValidator,
              style: regular_14,
              obscureText: widget.obscureText,
              cursorColor: Colors.black,
              maxLines: widget.maxLines ?? 1,
              readOnly: widget.onTap != null,
              onTap: widget.onTap,
              decoration: InputDecoration(
                hintText: widget.hint,
                suffixIcon: widget.icon != null
                    ? GestureDetector(
                        onTap: widget.onIconTap,
                        child: Icon(widget.icon, size: 24),
                      )
                    : null,
                suffixIconConstraints: const BoxConstraints(maxHeight: 24),
              ),
            ),
          ],
        ),
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
