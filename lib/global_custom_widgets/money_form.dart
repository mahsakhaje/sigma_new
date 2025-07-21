import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/helper.dart';

class MoneyForm extends StatefulWidget {
  TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final AutovalidateMode autovalidateMode;
  final String labelText;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final String? hintText;
  bool isRight;
  bool showToman;
  int maxLen;
  int? min;
  int? max;
  bool isTurn;

  MoneyForm(
      this.controller, {
        this.onChanged,
        this.isTurn = false,
        this.isRight = false,
        this.onEditingComplete,
        this.enabled = true,
        this.min,
        this.max,
        this.showToman = false,
        this.labelText = "",
        this.focusNode,
        this.maxLen = 15,
        this.hintText = "بودجه به تومان",
        this.autovalidateMode = AutovalidateMode.onUserInteraction,
      });

  @override
  _MoneyFormState createState() => _MoneyFormState();
}

class _MoneyFormState extends State<MoneyForm> {
  String? _validator(String? value) {

    if (value == null || value.isEmpty) {
      return 'اطلاعات را وارد نمایید';
    }
    if(widget.min!=null && widget.max!=null){
      int a=double.tryParse(value.toEnglishDigit().replaceAll(',', ''))?.toInt() ??0;
      if(widget.min! > a ){
        return 'مبلغ کافی نیست';
      }
      if(a > widget.max!){
        return 'مبلغ بیش از حد مجاز است';

      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.isTurn
          ? BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white,
          width:1.5, // Border width
        ),
      )
          : BoxDecoration(),
      child: TextFormField(
        autovalidateMode: widget.autovalidateMode,
        onEditingComplete: widget.onEditingComplete,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
        maxLength: widget.maxLen,
        //  textDirection: TextDirection.rtl,
        textAlign: widget.isRight ? TextAlign.right : TextAlign.center,
        style: TextStyle(color: Colors.white,fontFamily: "Peyda"),
        controller: widget.controller,
        validator: _validator,
        textDirection: TextDirection.ltr,
        keyboardType: TextInputType.number,
        inputFormatters: [PersianFormatter(), MoneyTextInputFormatter()],
        onChanged: (value) {
          // widget.controller.selection = TextSelection.fromPosition(
          //     TextPosition(offset: 0));
          widget.onChanged?.call(value);
          final error = _validator(value);
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          hintText: widget.hintText,

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.white, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.white, width: 1.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.white, width: 1.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.white, width: 1.0),
          ),
          hintStyle: TextStyle(color: Colors.white,fontSize: 14,fontFamily: 'Peyda',),
          counterText: "",
          // focusColor: colors.textColorDark,
          // hoverColor: colors.textColorDark,
          labelText: widget.labelText,



          contentPadding:
          EdgeInsets.only(left: 12, bottom: 4, top: 4, right: 12),
          prefix: widget.showToman
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 64),
                child:
                CustomText('تومان', color: Colors.black87, size: 14),
              ),
            ],
          )
              : null,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          //hintTextDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}

class MoneyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.extentOffset;
      final v = newValue.text.replaceAll(',', '');
      final i = int.tryParse(v.toEnglishDigit());
      String newString = separateThousand(i ?? 0);

      return TextEditingValue(
        text: newString.usePersianNumbers(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndexFromTheRight,
        ),
      );
    } else {
      return newValue;
    }
  }
}