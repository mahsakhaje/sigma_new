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
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Radio<T>(
        value: value,
        groupValue: groupValue.value,
        onChanged: (val) {
          if (val != null) {
            onChanged(val);
          }
        },
        activeColor: Colors.white,
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white; // selected color
          }
          return Colors.white; // unselected color
        }),
      ),
      title: CustomText(label, isRtl: true,size: 13),
      onTap: () => onChanged(value),
    ),
  );
}
