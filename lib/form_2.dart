import 'package:flutter/material.dart';

class Form2 extends StatefulWidget {
  const Form2({
    super.key,
    required this.updateValue,
  });

  final void Function(String, String, String) updateValue;

  @override
  State<Form2> createState() => _Form2State();
}

class _Form2State extends State<Form2> {
  final formKey = GlobalKey<FormState>();
  final form1Key = GlobalKey<FormFieldState<String>>();
  final form2Key = GlobalKey<FormFieldState<String>>();
  final form3Key = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    const decoration = InputDecoration(
      border: OutlineInputBorder(),
      floatingLabelBehavior: FloatingLabelBehavior.always,
    );

    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.disabled,
      onChanged: () {
        if (formKey.currentState != null && formKey.currentState!.validate()) {
          final form1 = form1Key.currentState?.value ?? '';
          final form2 = form2Key.currentState?.value ?? '';
          final form3 = form3Key.currentState?.value ?? '';
          widget.updateValue(form1, form2, form3);
        }
      },
      child: Column(
        children: [
          TextFormField(
            key: form1Key,
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
            key: form2Key,
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
          const SizedBox(height: 30),
          TextFormField(
            key: form3Key,
            decoration: decoration.copyWith(
              label: const Text('入力項目3'),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '1文字以上の文字を入力してください。';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
