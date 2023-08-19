import 'package:flutter/material.dart';

class Form1 extends StatefulWidget {
  const Form1({
    super.key,
    required this.form1Key,
    required this.form2Key,
  });

  final GlobalKey<FormFieldState<String>> form1Key;
  final GlobalKey<FormFieldState<String>> form2Key;

  @override
  State<Form1> createState() => _Form1State();
}

class _Form1State extends State<Form1> {
  @override
  Widget build(BuildContext context) {
    const decoration = InputDecoration(
      border: OutlineInputBorder(),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    );

    return Column(
      children: [
        TextFormField(
          key: widget.form1Key,
          decoration: decoration.copyWith(
            label: const Text('入力項目1'),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '1文字以上の文字を入力してください。';
            }
            return null;
          },
        ),
        const SizedBox(height: 30),
        TextFormField(
          key: widget.form2Key,
          decoration: decoration.copyWith(
            label: const Text('入力項目2'),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '1文字以上の文字を入力してください。';
            }
            return null;
          },
        ),
      ],
    );
  }
}
