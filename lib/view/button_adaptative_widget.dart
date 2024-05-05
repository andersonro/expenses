import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonAdaptativeWidget extends StatelessWidget {
  final String label;
  final Function() fn;

  const ButtonAdaptativeWidget(
      {super.key, required this.label, required this.fn});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(onPressed: fn, child: Text(label))
        : ElevatedButton(onPressed: fn, child: Text(label));
  }
}
