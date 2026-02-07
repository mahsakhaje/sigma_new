import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/heades_page.dart';
import 'package:sigma/global_custom_widgets/outlined_button.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/pages/auth/auth_controller.dart';
import 'package:sigma/pages/auth/forget_form.dart';
import 'package:sigma/pages/auth/login_form.dart';
import 'package:sigma/pages/auth/registerForm.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return HeadedPage(
      title: '',
      hideAppBar: true,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/auth_bg.png',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 12),
            child: Obx(() => switch (authController.currentPage.value) {
                  AuthPageState.login => buildLogin(),
                  AuthPageState.register => buildRegister(),
                  AuthPageState.welcome => buildWelcome(),
                  AuthPageState.forgetPassword => buildForgetPassword(),
                  AuthPageState.otp => buildLogin()
                }),
          ),
        ],
      ),
    );
  }

  Widget buildWelcome() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        SvgPicture.asset('assets/sigma_persian.svg'),
        Column(
          children: [
            ConfirmButton(() => authController.goToLogin(), Strings.enter),
            const SizedBox(
              height: 16,
            ),
            customOutlinedButton(
                () => authController.goToRegister(), Strings.register)
          ],
        ),
        const SizedBox(),
      ],
    );
  }
}

Widget back(AuthController authController) {
  return Row(
    children: [
      InkWell(
        child: SvgPicture.asset('assets/back.svg'),
        onTap: () => authController.getBack(),
      )
    ],
  );
}
