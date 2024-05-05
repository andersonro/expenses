import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldAdaptativeWidget extends StatelessWidget {
  final Key keyTextField;
  final TextEditingController controller;
  final String label;
  final bool isValidate;
  final TextInputType keyboardType;
  final FilteringTextInputFormatter? filteringTextInputFormatter;

  const TextFieldAdaptativeWidget({
    super.key,
    required this.keyTextField,
    required this.controller,
    required this.label,
    this.isValidate = false,
    this.keyboardType = TextInputType.text,
    this.filteringTextInputFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextFormFieldRow(
            key: keyTextField,
            controller: controller,
            keyboardType: keyboardType,
            placeholder: label,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            validator: (value) {
              if (isValidate) {
                if (value == '') {
                  return 'Este campo deve ser preenchido!';
                }
              }
              return null;
            },
          )
        : TextFormField(
            key: keyTextField,
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
            inputFormatters: [
              if (filteringTextInputFormatter != null)
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
            ],
            validator: (value) {
              if (isValidate) {
                if (value == '') {
                  return 'Este campo deve ser preenchido!';
                }
              }
              return null;
            },
          );
  }
}
