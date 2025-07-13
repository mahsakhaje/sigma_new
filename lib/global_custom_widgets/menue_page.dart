import 'package:flutter/material.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/helper/colors.dart';

class MenuePage extends StatelessWidget {
  Widget child;
  String title;
  bool hideAppBar;
  MenuePage({super.key,required this.child,required this.title,this.hideAppBar=true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: CustomText(title,color: Colors.black,fontWeight: FontWeight.bold,textAlign: TextAlign.center),),
      body: Stack(
        children: [
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/menue_bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),          child,
        ],
      ),
    );
  }
}
