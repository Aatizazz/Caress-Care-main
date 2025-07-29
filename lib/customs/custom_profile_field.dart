import 'package:flutter/material.dart';

class CustomProfileField extends StatelessWidget {
  final String label;
  final String initialValue;
  final TextEditingController controller;
  final bool isReadOnly;

  const CustomProfileField({
    Key? key,
    required this.label,
    required this.initialValue,
    required this.controller,
    this.isReadOnly = false,
    required String value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller..text = initialValue,
        readOnly: isReadOnly,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
