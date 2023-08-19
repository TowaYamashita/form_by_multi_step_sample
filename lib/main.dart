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
      FormStep.sample(
        label: 'フォーム1',
        content: Form1(
          updateValue: (p0, p1) {
            formValue.update("form1-1", (_) => p0);
            formValue.update("form1-2", (_) => p1);
          },
        ),
        state: _index == 0 ? StepState.editing : StepState.indexed,
      ),
      FormStep.sample(
        label: 'フォーム2',
        content: Form2(
          updateValue: (p0, p1, p2) {
            formValue.update("form2-1", (_) => p0);
            formValue.update("form2-2", (_) => p1);
            formValue.update("form2-3", (_) => p2);
          },
        ),
        state: _index == 1 ? StepState.editing : StepState.indexed,
      ),
      FormStep.sample(
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
          return Column(
            children: [
              ElevatedButton.icon(
                onPressed: details.onStepContinue,
                icon: const Icon(Icons.arrow_forward),
                label: const Text('進む'),
              ),
              TextButton.icon(
                onPressed: details.onStepCancel,
                icon: const Icon(Icons.arrow_back),
                label: const Text('戻る'),
              ),
            ],
          );
        },
        steps: steps,
      ),
    );
  }
}
