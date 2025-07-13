import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';

Widget buildRadioTile<T extends Enum>({
  required String label,
  required T value,
  required Rx<T> groupValue,
  required void Function(T) onChanged,
  required List<T> values,
}) {
  return SizedBox(
    width: 110,
    child:  RadioListTile<int>(
      contentPadding: EdgeInsets.zero,
      activeColor: Colors.white,
      hoverColor: Colors.white,
      selected: groupValue.value == value,
      value: value.index,
      groupValue: groupValue.value.index,
      title: CustomText(label, isRtl: true),
      onChanged: (val) {
        if (val != null) {
          onChanged(values[val]);
        }
      },
    ),
  );
}
