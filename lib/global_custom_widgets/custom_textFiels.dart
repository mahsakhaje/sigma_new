import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sigma/helper/helper.dart';

class CustomTextFormField extends StatefulWidget {
  TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final bool isOnlyNumber;
  final AutovalidateMode autovalidateMode;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final String? hintText;
  Color fillColor;
  int maxLen;
  bool isNationalId;
  bool isEmail;
  bool isCoNationalId;
  bool acceptAll;
  double borderRadius;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool isDark = false;

  CustomTextFormField(
    this.controller, {
    this.onChanged,
    this.onEditingComplete,
    this.enabled = true,
    this.isDark = false,
    this.acceptAll = false,
    this.maxLen = 1000,
    this.prefixIcon = null,
    this.suffixIcon = null,
    this.isNationalId = false,
    this.isCoNationalId = false,
    this.isOnlyNumber = false,
    this.isEmail = false,
    this.focusNode,
    this.borderRadius = 5,
    this.fillColor = Colors.transparent,
    this.hintText = "نام و نام خانوادگی",
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
  });

  @override
  State<StatefulWidget> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isPasswordVisible = false;
  String _value = "";

  @override
  void initState() {
    _value = widget.controller.text;
    widget.controller.addListener(() {
      if (mounted) {
        setState(() {
          _value = widget.controller.text;
        });
      }
    });
    super.initState();
  }

  String? _validator(String? value) {
    if (widget.autovalidateMode == AutovalidateMode.disabled) {
      return null;
    }
    value = value?.toEnglishDigit();
    if (widget.isCoNationalId) {
      if ((value?.length ?? 0) < 11) {
        return 'شناسه ملی وارد شده صحیح نمی باشد';
      } else if (!isValidCoNationalId(value ?? "")) {
        return 'شناسه ملی  وارد شده صحیح نمی باشد';
      }
      return null;
    }
    if (widget.isNationalId) {
      if ((value?.length ?? 0) < 10) {
        return 'کدملی وارد شده صحیح نمی باشد.';
      }
      final pattern = r'^\d{10}$';
      final regExp = RegExp(pattern);
      if (!regExp.hasMatch(value!)) {
        return 'Please enter a valid national ID';
      } else if (!isValidNationalId(value)) {
        return 'کدملی وارد شده صحیح نمی باشد.';
      }
      return null;
    }
    if (widget.isEmail) {
      final emailRegExp =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (value == null || value.isEmpty) {
        return null;
      }

      if (!emailRegExp.hasMatch(value ?? '')) {
        return 'ایمیل وارد شده صحیح نمی باشد.';
      }
    }
    if (value == null || value.isEmpty) {
      return 'اطلاعات را وارد نمایید.';
    }

    return null;
  }

  bool isValidNationalId(String value) {
    final chars = value.split('');
    final checkDigit = int.parse(chars[9]);
    var sum = 0;
    for (var i = 0; i < 9; i++) {
      sum += int.parse(chars[i]) * (10 - i);
    }
    var remainder = sum % 11;
    if (remainder < 2 && checkDigit == remainder ||
        remainder >= 2 && checkDigit == 11 - remainder) {
      return true;
    } else {
      return false;
    }
  }

  // Helper method to check if this is a password field
  bool get _isPasswordField => (widget.hintText ?? "").contains('رمز');

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        autovalidateMode: widget.autovalidateMode,
        onEditingComplete: widget.onEditingComplete,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
        cursorColor: widget.isDark ? Colors.black87 : Colors.white,
        obscureText: _isPasswordField ? !_isPasswordVisible : false,
        inputFormatters: getFormatter(),
        keyboardType: widget.isEmail
            ? TextInputType.emailAddress
            : widget.isNationalId || widget.isOnlyNumber
                ? TextInputType.number
                : TextInputType.text,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
        maxLength: widget.maxLen,
        style: TextStyle(
          color: widget.isDark ? Colors.black87 : Colors.white,
          fontFamily: "Peyda",
        ),
        controller: widget.controller,
        validator: _validator,
        onChanged: (value) {
          widget.onChanged?.call(value);
          final error = _validator(value);
          setState(() {
            _value = value;
          });
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          hintText: widget.hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: widget.isDark ? Colors.black87 : Colors.white,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: widget.isDark ? Colors.black87 : Colors.white,
              width: 1.0,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: widget.isDark ? Colors.black87 : Colors.grey,
              width: 1.0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: widget.isDark ? Colors.black87 : Colors.white,
              width: 1.0,
            ),
          ),
          hintStyle: TextStyle(
            color: widget.isDark
                ? Colors.black87
                : widget.enabled
                    ? Colors.white
                    : Colors.grey,
            fontSize: 12,
          ),
          counterText: "",
          prefixIcon: _isPasswordField
              ? IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: widget.isDark ? Colors.black87 : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                )
              : widget.prefixIcon,
          suffixIcon: !_isPasswordField ? widget.suffixIcon : null,
          contentPadding:
              const EdgeInsets.only(left: 16, bottom: 16, top: 16, right: 16),
          hintTextDirection: TextDirection.rtl,
          errorStyle: TextStyle(fontFamily: 'Peyda', locale: Locale('Fa')),
        ),
      ),
    );
  }

  bool isValidCoNationalId(String value) {
    bool isValidNationalId = true; // Initialize as true

    // Assuming getValues() returns a String or null

    if (value == null) {
      isValidNationalId = false;
    }

    if ((value?.length != 11) || !RegExp(r'^[0-9]*$').hasMatch(value ?? "")) {
      isValidNationalId = false;
    }

    var sumOfDigits = 0;
    var cntr = 0;
    var zaribArray = [29, 27, 23, 19, 17, 29, 27, 23, 19, 17];
    var checkDigit = int.parse(value!.substring(10, 11));
    var lastNumber = int.parse(value.substring(9, 10));
    var nCodeArray = List<int>.filled(10, 0);

    for (cntr = 0; cntr < 10; cntr++) {
      nCodeArray[cntr] = int.parse(value.substring(cntr, cntr + 1));
      nCodeArray[cntr] += lastNumber + 2;
      nCodeArray[cntr] *= zaribArray[cntr];
      sumOfDigits += nCodeArray[cntr];
    }

    var mod = sumOfDigits % 11;

    if (mod > 9) {
      mod = 0;
    }

    if (mod != checkDigit) {
      isValidNationalId = false;
    }

    return isValidNationalId;
  }

  List<TextInputFormatter> getFormatter() {
    if (widget.isOnlyNumber || widget.isNationalId) {
      return [PersianFormatter()];
    }
    if ((widget.hintText ?? '').contains('شاسی')) {
      return [
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z  0-9  ۰-۹]")),
        UpperCaseTextFormatter(),
        EnglishFormatter()
      ];
    }
    if (widget.hintText!.contains('رمز')) {
      return [];
    }
    if (widget.isEmail || widget.acceptAll) {
      return [];
    }
    return [PersianLettersFormatter()];
  }
}
