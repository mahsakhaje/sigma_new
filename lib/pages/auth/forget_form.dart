import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/custom_textFiels.dart';
import 'package:sigma/global_custom_widgets/mobile_text_fiels.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/pages/auth/auth_controller.dart';
import 'package:sigma/pages/auth/auth_page.dart';

import '../../global_custom_widgets/support_call.dart';

Widget buildForgetPassword() {
  final AuthController authController = Get.put(AuthController());

  Widget _buildEnterPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        back(authController),
        const SizedBox(height: 60),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomText(
              'لطفا شماره موبایل خود را وارد کنید',
              size: 16,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Form(
          key: authController.forgetFormKey,
          child: MobileTextFormField(
            authController.forgetMobileNumberController,
            fillColor: Colors.white,
            radius: 5,
            autovalidateMode: AutovalidateMode.disabled,
          ),
        ),
        const SizedBox(height: 8),
        Obx(() => authController.isLoading.value
            ?  Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: loading(),
                ),
              )
            : ConfirmButton(
                () {
                  hideKeyboard(Get.context!);
                  authController.forgetPassword();
                },
                'بازیابی رمز عبور',
              )),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildEnterCode() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomText(
              ' کد تایید فرستاده شده برای${authController.forgetMobileNumberController.text} را وارد نمایید'
                  .usePersianNumbers(),
              size: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        const SizedBox(height: 16),
        PinCodeTextField(
          length: 5,
          autoDisposeControllers: false,
          obscureText: false,
          keyboardType: TextInputType.visiblePassword,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 50,
            fieldOuterPadding: const EdgeInsets.all(4),
            activeFillColor: AppColors.grey,
            disabledColor: AppColors.grey,
            errorBorderColor: Colors.white,
            activeColor: AppColors.grey,
            inactiveColor: AppColors.grey,
            inactiveFillColor: AppColors.grey,
            selectedColor: AppColors.grey,
            selectedFillColor: AppColors.grey,
          ),
          textStyle: const TextStyle(fontSize: 18, height: 1.6),
          enableActiveFill: true,
          controller: authController.codeController,
          onChanged: (value) {
            authController.codeController.text = value.usePersianNumbers();
          },
          appContext: Get.context!,
        ),
        const SizedBox(height: 12),
        Obx(() => authController.isLoading.value
            ?  Center(
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: loading(),
                ),
              )
            : ConfirmButton(
                () {
                  hideKeyboard(Get.context!);
                  if (authController.codeController.text.length >= 5 &&
                      authController.codeController.text.length < 8) {
                    authController.verifyResetPassword(
                      cellNumber:
                          authController.forgetMobileNumberController.text,
                      password:
                          englishToPersian(authController.codeController.text),
                    );
                  }
                },
                'تایید',
              )),
      ],
    );
  }

  Widget _buildNewPassword() {
    return Form(
      key: authController.passwordFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(
                'لطفا رمز جدید خود را ثبت کنید',
                size: 16,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            authController.passwordController,
            hintText: 'رمز عبور جدید',
            maxLen: 20,
            autovalidateMode: AutovalidateMode.disabled,
          ),
          const SizedBox(height: 12),
          Obx(() => authController.isLoading.value
              ?  Center(
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: loading(),
                  ),
                )
              : ConfirmButton(
                  () {
                    hideKeyboard(Get.context!);
                    authController.confirmNewPassword();
                  },
                  'تغییر رمز',
                )),
        ],
      ),
    );
  }

  Widget _getContent() {
    switch (authController.currentState.value) {
      case PageState.EnterPhoneNumber:
        return _buildEnterPhoneNumber();
      case PageState.EnterCode:
        return _buildEnterCode();
      case PageState.NewPassword:
        return _buildNewPassword();
    }
  }

  ListView _buildContentListView() {
    return ListView(
      shrinkWrap: true,
      children: [
        Obx(() => _getContent()),
        const SizedBox(height: 8),
      ],
    );
  }

  return Center(
    child: ListView(
      padding: const EdgeInsets.all(20),
      shrinkWrap: true,
      children: [
        _buildContentListView(),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const Divider(
                height: 3,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Obx(() => SupportCall(authController.supportNumber.value)),
            ],
          ),
        ),
      ],
    ),
  );
}
