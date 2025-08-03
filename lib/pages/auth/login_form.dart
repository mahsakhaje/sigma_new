import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/custom_textFiels.dart';
import 'package:sigma/global_custom_widgets/loading.dart';
import 'package:sigma/global_custom_widgets/mobile_text_fiels.dart';
import 'package:sigma/global_custom_widgets/outlined_button.dart';
import 'package:sigma/global_custom_widgets/support_call.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/pages/auth/auth_controller.dart';
import 'package:sigma/pages/auth/auth_page.dart';

Widget buildLogin() {
  final AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  final _otpFormKey = GlobalKey<FormState>();
  final _passWordController = TextEditingController();
  FocusNode textFieldPassWord = FocusNode();
  FocusNode textFieldMobile = FocusNode();
  FocusNode confirmButton = FocusNode();

  Widget _buildEnterCode() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 52,
        ),
        back(authController),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText('کد تایید را وارد نمائید.',
                size: 16, isRtl: true, fontWeight: FontWeight.bold),
          ],
        ),
        SizedBox(
          height: 62,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomText(
              ' کد تایید فرستاده شده برای${authController.loginMobileNumberController.text} را وارد نمایید'
                  .usePersianNumbers(),
              size: 14,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
        const SizedBox(height: 16),
        PinCodeTextField(
          length: 5,
          obscureText: false,
          autoDisposeControllers: false,
          keyboardType: TextInputType.number,
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
          textStyle: const TextStyle(fontSize: 18, height: 1.6,fontFamily: 'Peyda'),
          enableActiveFill: true,
          controller: authController.otpCodeController,
          onChanged: (value) {
            authController.otpCodeController.text = value.usePersianNumbers();
          },
          appContext: Get.context!,
        ),
        SizedBox(height: 10),
        Obx(() => CustomText(
            '${authController.formattedTime} باقیمانده تا ارسال مجدد کد'
                .usePersianNumbers(),
            isRtl: true)),
        SizedBox(height: 30),
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
                  if (authController.otpCodeController.text.length >= 5 &&
                      authController.otpCodeController.text.length < 8) {
                    authController.confirmOtp();
                  }
                },
                'تایید',
              )),
        Obx(() => TextButton(
              onPressed: authController.canResend.value
                  ? authController.startTimer
                  : null,
              child: CustomText('ارسال مجدد کد'),
            )),
        Divider(color: Colors.white24),
        SizedBox(height: 10,),
        SupportCall(authController.supportNumber.value)
      ],
    );
  }

  return authController.currentPage.value == AuthPageState.login
      ? buildMobileGetData(_formKey, _otpFormKey, _passWordController,
          textFieldMobile, textFieldPassWord, authController)
      : authController.currentPage.value == AuthPageState.otp
          ? _buildEnterCode()
          : SizedBox();
}

SizedBox buildMobileGetData(
    GlobalKey<FormState> _formKey,
    GlobalKey<FormState> _otpFormKey,
    TextEditingController _passWordController,
    FocusNode textFieldMobile,
    FocusNode textFieldPassWord,
    AuthController authController) {
  return SizedBox(
    height: MediaQuery.of(Get.context!).size.height,
    child: Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          back(authController),
          const SizedBox(height: 48),
          CustomText(Strings.welcome, size: 32, fontWeight: FontWeight.bold),
          const SizedBox(
            height: 18,
          ),
          Form(
            key: _otpFormKey,
            child: MobileTextFormField(
                authController.loginMobileNumberController,
                autovalidateMode:
                    authController.loginMobileNumberController.text.length != 11
                        ? AutovalidateMode.disabled
                        : AutovalidateMode.always,
                focusNode: textFieldMobile, onChanged: (txt) {
              if (txt.length == 11) {
                // FocusScope.of(GetXState().context).requestFocus(textFieldPassWord);
              }
            }),
          ),
          const SizedBox(
            height: 10,
          ),
          // TextFormField(controller: _passWordController),
          CustomTextFormField(
            _passWordController,
            focusNode: textFieldPassWord,
            autovalidateMode: AutovalidateMode.disabled,
            maxLen: 20,
            hintText: 'رمز عبور',
            onEditingComplete: () {
              // FocusScope.of(GetXState().context).requestFocus(confirmButton);
            },
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Get.toNamed(RouteName.privacy),
                child: CustomText(Strings.privacy),
              ),
              InkWell(
                onTap: authController.goToForget,
                child: CustomText(Strings.forgetPass),
              ),
            ],
          ),
          const SizedBox(
            height: 28,
          ),
          customOutlinedButton(() {
            if (_otpFormKey.currentState!.validate()) {
              authController.sendOtp();
            }
          }, 'ورود با رمز یکبارمصرف'),
          const SizedBox(
            height: 12,
          ),
          Obx(
            () => ConfirmButton(
                authController.isLoading.value
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          await authController.login(_passWordController.text);
                        }
                      },
                Strings.enter),
          ),
          const SizedBox(
            height: 12,
          ),
          InkWell(
            onTap: () => authController.goToRegister(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomText(Strings.doRegister, fontWeight: FontWeight.bold,isRtl:true),
                const SizedBox(
                  width: 4,
                ),
                CustomText(Strings.dontHaveAccount)
              ],
            ),
          )
        ],
      ),
    ),
  );
}
