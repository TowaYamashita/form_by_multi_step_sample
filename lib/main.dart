import 'package:flutter/material.dart';
import 'package:form_by_multi_step_sample/confirm.dart';
import 'package:form_by_multi_step_sample/form_1.dart';
import 'package:form_by_multi_step_sample/form_2.dart';
import 'package:form_by_multi_step_sample/form_step.dart';

/// Flutter code sample for [Stepper].

void main() => runApp(const StepperExampleApp());

class StepperExampleApp extends StatelessWidget {
  const StepperExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const StepperExample(),
    );
  }
}

class StepperExample extends StatefulWidget {
  const StepperExample({super.key});

  @override
  State<StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  int _index = 0;

  final form1Key = GlobalKey<FormFieldState<String>>();
  final form2Key = GlobalKey<FormFieldState<String>>();
  final form3Key = GlobalKey<FormFieldState<String>>();
  final form4Key = GlobalKey<FormFieldState<String>>();
  final form5Key = GlobalKey<FormFieldState<String>>();

  Map<String, String> formValue = {
    "form1-1": "",
    "form1-2": "",
    "form2-1": "",
    "form2-2": "",
    "form2-3": "",
  };

  @override
  Widget build(BuildContext context) {
    final steps = [
      FormStep.create(
        label: 'フォーム1',
        content: Form1(
          form1Key: form1Key,
          form2Key: form2Key,
        ),
        state: _index == 0 ? StepState.editing : StepState.indexed,
      ),
      FormStep.create(
        label: 'フォーム2',
        content: Form2(
          form1Key: form3Key,
          form2Key: form4Key,
          form3Key: form5Key,
        ),
        state: _index == 1 ? StepState.editing : StepState.indexed,
      ),
      FormStep.create(
        label: '入力確認',
        content: Confirm(data: formValue),
        state: _index == 2 ? StepState.editing : StepState.indexed,
      ),
    ];

    void onStepCancel() {
      if (_index > 0) {
        setState(() {
          _index -= 1;
        });
      }
    }

    void showConfirmedDialog() {
      showDialog(
        context: context,
        builder: (_) {
          return const SimpleDialog(
            children: [
              Icon(Icons.check),
              Center(child: Text('完了')),
            ],
          );
        },
      );
    }

    void onStepContinue() {
      if (_index == 0) {
        if (form1Key.currentState == null || form2Key.currentState == null) {
          return;
        }

        if ([
          form1Key.currentState!.validate(),
          form2Key.currentState!.validate(),
        ].any((e) => e == false)) {
          return;
        }

        formValue.update("form1-1", (_) => form1Key.currentState?.value ?? '');
        formValue.update("form1-2", (_) => form2Key.currentState?.value ?? '');
      }

      if (_index == 1) {
        if (form3Key.currentState == null || form4Key.currentState == null || form5Key.currentState == null) {
          return;
        }

        if ([
          form3Key.currentState!.validate(),
          form4Key.currentState!.validate(),
          form5Key.currentState!.validate(),
        ].any((e) => e == false)) {
          return;
        }

        formValue.update("form2-1", (_) => form3Key.currentState?.value ?? '');
        formValue.update("form2-2", (_) => form4Key.currentState?.value ?? '');
        formValue.update("form2-3", (_) => form5Key.currentState?.value ?? '');
      }

      if (_index == steps.length - 1) {
        showConfirmedDialog();
        return;
      }
      if (_index >= 0) {
        setState(() {
          _index += 1;
        });
      }
    }

    void onStepTapped(int index) {
      setState(() {
        _index = index;
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Stepper Sample')),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _index,
        onStepCancel: onStepCancel,
        onStepContinue: onStepContinue,
        onStepTapped: onStepTapped,
        controlsBuilder: (_, details) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: details.onStepCancel,
                icon: const Icon(Icons.arrow_back),
                label: const Text('戻る'),
              ),
              ElevatedButton.icon(
                onPressed: details.onStepContinue,
                icon: const Icon(Icons.arrow_forward),
                label: const Text('進む'),
              ),
            ],
          );
        },
        steps: steps,
      ),
    );
  }
}
