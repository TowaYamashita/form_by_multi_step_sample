import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_value.freezed.dart';

@freezed
class FormValue with _$FormValue {
  const factory FormValue({
    required String formValue1,
    required String formValue2,
    required String formValue3,
    required String formValue4,
    required String formValue5,
  }) = _FormValue;
}