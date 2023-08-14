import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GladTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool obscure;
  final String? hintText;
  final int limitCharacter;
  final bool enabled;
  final TextStyle? hintStyle;
  final BorderSide? borderSide;
  final bool readOnly;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry? contextFieldPadding;
  final Widget? prefixWidget;
  final InputBorder? enableBorder;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final Widget? suffixWidget;
  final String? Function(String?)? validator;
  final int maxLines;
  final Color? fillColor;
  final VoidCallback? onFieldTap;
  final double circleRadius;
  final FocusNode? focusNode;
  final VoidCallback? onEditCompleteTap;

  const GladTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
    this.borderSide,
    this.enableBorder,
    this.limitCharacter = 150,
    this.keyboardType = TextInputType.text,
    this.obscure = false,
    this.enabled = true,
    this.readOnly = false,
    this.margin = EdgeInsets.zero,
    this.prefixWidget,
    this.suffixWidget,
    this.maxLines = 1,
    this.hintStyle,
    this.fillColor,
    this.border,
    this.focusedBorder,
    this.onFieldTap,
    this.contextFieldPadding,
    this.circleRadius = 20,
    this.focusNode,
    this.onEditCompleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: TextFormField(
        onTap: onFieldTap,
        inputFormatters: [
          LengthLimitingTextInputFormatter(limitCharacter),
        ],
        obscureText: obscure,
        focusNode: focusNode,
        controller: controller,
        maxLines: maxLines,
        enabled: enabled,
        readOnly: readOnly,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: TextInputAction.done,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onEditingComplete: onEditCompleteTap,
        decoration: InputDecoration(
          prefixIcon: prefixWidget == null
              ? null
              : Padding(
            padding: const EdgeInsets.all(16.0),
            child: prefixWidget,
          ),
          contentPadding:
          contextFieldPadding ?? const EdgeInsets.fromLTRB(16, 12, 12, 12),
          suffixIcon: suffixWidget,
          enabledBorder: enableBorder ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(circleRadius),
                  ),
                  borderSide:
                  borderSide ?? const BorderSide(color: Colors.grey)),
          focusedBorder: focusedBorder ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(circleRadius),
                  ),
                  borderSide:
                  borderSide ?? const BorderSide(color: Colors.grey)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(circleRadius),
              ),
              borderSide: borderSide ?? const BorderSide(color: Colors.grey)),
          border: border ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(circleRadius),
                  ),
                  borderSide:
                  borderSide ?? const BorderSide(color: Colors.grey)),
          hintText: hintText,
          fillColor: fillColor ?? Colors.white,
          filled: true,
          hintStyle: hintStyle ??
              const TextStyle(
                  fontWeight: FontWeight.normal,
                  color:  Colors.deepPurple),
          // isDense: true,
        ),
      ),
    );
  }
}