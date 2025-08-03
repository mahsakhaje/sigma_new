import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/helper.dart';

Widget CustomDropdown({
  required String hint,
  required String? value,
  required Map<String, String> items,
  required ValueChanged<String?> onChanged,
  bool isRtl = false,
  bool isTurn = false,
  bool isEng = false,
  bool largeFont = false,
  bool isFullLine = false,
  bool isDark=false
}) {
  return Container(
    decoration: isTurn
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
              color: isDark?Colors.black:Colors.white,
              width: 1,
            ),
          )
        : const BoxDecoration(),
    child: Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          hint: CustomText(hint, color:isDark?Colors.black: Colors.white, size: 14),
          alignment: Alignment.center,
          isExpanded: true,
          iconStyleData: const IconStyleData(
            icon: SizedBox.shrink(), // This removes the icon completely
          ),
          buttonStyleData: _decoration(isDark),
          style: const TextStyle(color: Colors.black87),
          value: value,
          items: items.entries.map((entry) {
            return DropdownMenuItem<String>(
              alignment: AlignmentDirectional.center,
              value: entry.key, // Return the key
              child: _buildDropdownItem(
                entry.value, // Show the value
                isEng: isEng,
                isRtl: isRtl,
                largeFont: largeFont,
                isFullLine: isFullLine,
              ),
            );
          }).toList(),
          onChanged: onChanged,
          selectedItemBuilder: (context) {
            return items.entries.map((entry) {
              return Align(
                alignment: Alignment.center,
                child: CustomText(
                  isEng ? entry.value : entry.value.usePersianNumbers(),
                  color: isDark?Colors.black:Colors.white, // white for selected item
                  isRtl: isRtl,
                  size: largeFont ? 15 : 12,
                ),
              );
            }).toList();
          },
        ),
      ),
    ),
  );
}

Widget _buildDropdownItem(
  String label, {
  required bool isEng,
  required bool isRtl,
  required bool largeFont,
  required bool isFullLine,
}) {
  final displayText = isEng ? label : label.usePersianNumbers();

  if (isFullLine && !isEng) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CustomText(
              displayText,
              color: Colors.black87,
              isRtl: isRtl,
              maxLine: 2,
              size: largeFont ? 15 : 12,
            ),
          ),
        ],
      ),
    );
  }

  return CustomText(displayText,
      isRtl: isRtl, size: largeFont ? 15 : 12, color: Colors.black87);
}

ButtonStyleData _decoration(bool isDark) {
  return ButtonStyleData(
    padding: EdgeInsets.symmetric(vertical: 4),
    decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      border: Border.all(color:isDark?Colors.black: Colors.white),
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
