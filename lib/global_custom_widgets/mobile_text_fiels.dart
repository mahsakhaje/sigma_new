import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian/persian.dart';
import 'package:sigma/helper/helper.dart';

class MobileTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final AutovalidateMode autovalidateMode;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final bool canBeEmpty;
  final Color fillColor;
  final double radius;
  final bool isFromForm;

  const MobileTextFormField(this.controller, {
    super.key,
    this.onChanged,
    this.onEditingComplete,
    this.enabled = true,
    this.focusNode,
    this.isFromForm = false,
    this.fillColor = Colors.transparent,
    this.radius = 5,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.canBeEmpty = false,
  });

  @override
  State<MobileTextFormField> createState() => _MobileTextFormFieldState();
}

class _MobileTextFormFieldState extends State<MobileTextFormField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {}); // Just rebuild, no need for _value
    });
  }

  String? _validateMobile(String? value) {
    if (widget.canBeEmpty) return null;

    if (value?.length == 11) {
      value = value?.withEnglishNumbers();
      final regex = RegExp(r'09[01239]\d{8}');
      if (!regex.hasMatch(value ?? '')) {
        return 'شماره موبایل صحیح نیست';
      }
    }

    if (value == null || value.isEmpty || value.length != 11) {
      return 'شماره موبایل را وارد نمایید';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
        autovalidateMode: widget.autovalidateMode,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.center,

        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Peyda',
        ),
        cursorColor: Colors.white,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9 ۰-۹]")),
          LengthLimitingTextInputFormatter(11),
          PersianFormatter(),
        ],
        validator: _validateMobile,
        onEditingComplete: widget.onEditingComplete,
        onChanged: (value) {
          widget.onChanged?.call(value);
          setState(() {}); // Update UI if necessary
        },
        decoration: decoration('شماره موبایل'),
      ),
    );
  }
}

InputDecoration decoration(String hintText) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.transparent,
    hintText: hintText,
    contentPadding:
    const EdgeInsets.only(left: 16, bottom: 16, top: 16, right: 16),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.white, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.white, width: 1.0),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.white, width: 1.0),
    ),
    hintStyle: TextStyle(
        color: Colors.white,fontSize: 12), // optional: style for hint text
  ); // optional: style for input text

}