// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TextForm extends StatefulWidget {
  final String label;
  final String helpingText;
  final TextInputType keyboardtype;
  final TextEditingController controller;
  final String? placeholder;
  const TextForm(
      {super.key,
      required this.label,
      required this.helpingText,
      required this.keyboardtype,
      required this.controller,
      this.placeholder});

  @override
  State<TextForm> createState() => _TextFormState();
}

class _TextFormState extends State<TextForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardtype,
      decoration: (InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
        helperText: widget.helpingText,
      )),
    );
  }
}
