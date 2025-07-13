import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/colors.dart';

class ConfirmButton extends StatefulWidget {
  void Function()? onPressed;
  String title;
  Color color;
  Color txtColor;
  double fontSize;
  double borderRadius;
  Widget? icon;
  final FocusNode? focusNode;

  ConfirmButton(@required this.onPressed, @required this.title,
      {super.key, this.color = AppColors.blue,
      this.txtColor = Colors.white,
      this.fontSize = 14,
      this.focusNode,
      this.icon,
      this.borderRadius = 5});

  @override
  _ConfirmButtonState createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                backgroundColor: widget.color,
                disabledBackgroundColor: AppColors.grey,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius)),
                minimumSize: const Size(254, 60), //////// HERE
              ),
              onPressed: widget.onPressed,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    widget.title,

                        color: widget.txtColor,
                        fontWeight: FontWeight.bold,
                        size: widget.fontSize),

                  widget.icon != null ? widget.icon! : const SizedBox()
                ],
              )),
        ),
      ],
    );
  }
}
