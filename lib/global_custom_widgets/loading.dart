import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sigma/helper/colors.dart';

Widget loading(){
  return  LoadingAnimationWidget.inkDrop(
    color: AppColors.blue,
    size: 50,
  );
}