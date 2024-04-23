// ignore_for_file: avoid_field_initializers_in_const_classes

import 'package:blog_app/core/common/common_widgets.dart';
import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton.elevated(
    this.label,
    this.onPressed, {
    required this.isLoading,
    super.key,
  }) : _variant = _ButtonVariant.elevated;

  const LoadingButton.outlined(
    this.label,
    this.onPressed, {
    required this.isLoading,
    super.key,
  }) : _variant = _ButtonVariant.outlined;

  const LoadingButton.text(
    this.label,
    this.onPressed, {
    required this.isLoading,
    super.key,
  }) : _variant = _ButtonVariant.text;

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final _ButtonVariant _variant;

  @override
  Widget build(BuildContext context) {
    switch (_variant) {
      //
      /// `ELEVATED BUTTON`
      case _ButtonVariant.elevated:
        return ElevatedButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: isLoading ? loader : const SizedBox(),
          label: Text(label),
        );

      /// `OUTLINED BUTTON`
      case _ButtonVariant.outlined:
        return OutlinedButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: isLoading ? loader : const SizedBox(),
          label: Text(label),
        );

      /// `TEXT BUTTON`
      case _ButtonVariant.text:
        return TextButton.icon(
          onPressed: isLoading ? null : onPressed,
          icon: isLoading ? loader : const SizedBox(),
          label: Text(label),
        );
    }
  }

  Padding get loader => const Padding(
        padding: EdgeInsets.only(right: 5),
        child: Loader(),
      );
}

enum _ButtonVariant { elevated, outlined, text }
