import 'package:flutter/material.dart';

class FormStep extends Step {
  const FormStep._({
    required super.title,
    super.subtitle,
    required super.content,
    super.state,
    super.isActive,
    super.label,
  });

  factory FormStep.create({
    required String label,
    required Widget content,
    Widget? subTitle,
    StepState state = StepState.indexed,
    bool isActive = true,
  }) {
    return FormStep._(
      title: const SizedBox.shrink(),
      label: Text(label),
      subtitle: subTitle,
      content: content,
      state: state,
      isActive: isActive,
    );
  }
}
