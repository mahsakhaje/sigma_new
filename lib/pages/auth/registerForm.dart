import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_check_box.dart';
import 'package:sigma/global_custom_widgets/custom_drop_box.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/custom_textFiels.dart';
import 'package:sigma/global_custom_widgets/dual_widget.dart';
import 'package:sigma/global_custom_widgets/mobile_text_fiels.dart';
import 'package:sigma/global_custom_widgets/radio_list_tile.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/route_names.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/pages/auth/auth_controller.dart';
import 'package:sigma/pages/auth/auth_page.dart';

Widget buildRegister() {
  final AuthController authController = Get.put(AuthController());

  buildRegisterOtp() {
    return Expanded(
      child: Column(
        children: [
          SizedBox(height: 80),
          CustomText(
              'لطفاً کد فرستاده شده برای ${authController.mobileNumberController.text}${authController.haMobileNumberController.text} را وارد نمایید:',
              textAlign: TextAlign.center,
              isRtl: true),
          SizedBox(height: 30),
          SizedBox(
            child: PinCodeTextField(
              autoDisposeControllers: false,
              length: 5,
              controller: authController.codeController,
              animationType: AnimationType.fade,
              enableActiveFill: true,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(5),
                fieldHeight: 50,
                fieldWidth: 50,
                activeFillColor: AppColors.grey,
                disabledColor: AppColors.grey,
                errorBorderColor: Colors.white,
                activeColor: AppColors.grey,
                inactiveColor: AppColors.grey,
                inactiveFillColor: AppColors.grey,
                selectedColor: AppColors.grey,
                selectedFillColor: AppColors.grey,
              ),
              onCompleted: authController.onPinCompleted,
              appContext: Get.context!,
            ),
          ),
          SizedBox(height: 10),
          Obx(() => Text(
                '${authController.formattedTime} باقیمانده تا ارسال مجدد کد',
                style: TextStyle(color: Colors.white60, fontSize: 12),
              )),
          SizedBox(height: 30),
          ConfirmButton(
            () => authController.confirmCode(),
            'تایید',
          ),
          Obx(() => TextButton(
                onPressed: authController.canResend.value
                    ? authController.startTimer
                    : null,
                child: CustomText('ارسال مجدد کد'),
              )),
          Spacer(),
          Divider(color: Colors.white24),
        ],
      ),
    );
  }

  Widget buildLegalForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Form(
          key: authController.legalFormKey,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              dualRow(
                  CustomTextFormField(
                    authController.haNameController,
                    hintText: Strings.companyName,
                  ),
                  CustomTextFormField(
                    authController.haLastNameController,
                    hintText: Strings.companyLastName,
                  )),
              dualRow(
                  MobileTextFormField(authController.haMobileNumberController),
                  CustomTextFormField(
                    authController.haNationalCodeController,
                    hintText: Strings.companyNationalId,
                    isNationalId: true,
                    maxLen: 10,
                  )),
              dualRow(
                  CustomDropdown(
                    hint: Strings.province,
                    value: authController.selectedProvince.value,
                    items: authController.geoNames.value,
                    isTurn: false,
                    largeFont: true,
                    onChanged: authController.onProvinceChanged,
                  ),
                  CustomDropdown(
                    hint: Strings.city,
                    value: authController.selectedCity.value,
                    largeFont: true,
                    items: authController.geoCityNames.value,
                    isTurn: false,
                    onChanged: authController.onCityChanged,
                  )),
              dualRow(
                  CustomTextFormField(
                    authController.haPasswordController,
                    hintText: Strings.password,
                  ),
                  CustomTextFormField(
                    authController.haPasswordRepeatController,
                    hintText: Strings.repeatPassword,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: CustomTextFormField(
            authController.haReferralCodeController,
            hintText: Strings.referralCode,
            acceptAll: true,
          ),
        ),
      ],
    );
  }

  Widget buildHaghighiForm() {
    return Column(
      children: [
        Form(
          key: authController.haghighiFormKey,
          child: Column(
            children: [
              dualRow(
                  CustomTextFormField(
                    authController.nameController,
                    hintText: Strings.firstName,
                  ),
                  CustomTextFormField(
                    authController.lastNameController,
                    hintText: Strings.lastName,
                  )),
              dualRow(
                  MobileTextFormField(authController.mobileNumberController),
                  CustomTextFormField(
                    authController.nationalCodeController,
                    hintText: Strings.nationalCode,
                    isNationalId: true,
                    maxLen: 10,
                  )),
              dualRow(
                  CustomDropdown(
                    hint: Strings.province,
                    value: authController.selectedProvince.value,
                    items: authController.geoNames.value,
                    isTurn: false,
                    largeFont: true,
                    onChanged: authController.onProvinceChanged,
                  ),
                  CustomDropdown(
                    hint: Strings.city,
                    value: authController.selectedCity.value,
                    largeFont: true,
                    items: authController.geoCityNames.value,
                    isTurn: false,
                    onChanged: authController.onCityChanged,
                  )),
              dualRow(
                  CustomTextFormField(
                    authController.passwordController,
                    hintText: Strings.password,
                  ),
                  CustomTextFormField(
                    authController.passwordRepeatController,
                    hintText: Strings.repeatPassword,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: CustomTextFormField(
            authController.referralCodeController,
            hintText: Strings.referralCode,
            acceptAll: true,

          ),
        ),
      ],
    );
  }

  buildRegisterForms() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Directionality(
          textDirection: TextDirection.rtl,
          child: Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildRadioTile<UserState>(
                  label: Strings.natural,
                  value: UserState.normal,
                  groupValue: authController.userState,
                  onChanged: authController.setUserState,
                  values: UserState.values,
                ),
                const SizedBox(width: 36),
                buildRadioTile<UserState>(
                  label: Strings.legal,
                  value: UserState.legal,
                  groupValue: authController.userState,
                  onChanged: authController.setUserState,
                  values: UserState.values,
                ),
              ],
            ),
          ),
        ),
        authController.userState.value == UserState.normal
            ? Column(
                children: [
                  const SizedBox(
                      width: 240,
                      child: Divider(
                        color: Colors.white,
                        thickness: 0.3,
                      )),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildRadioTile<Gender>(
                          label: Strings.male,
                          value: Gender.male,
                          groupValue: authController.userGender,
                          onChanged: authController.setUserGender,
                          values: Gender.values,
                        ),
                        const SizedBox(width: 36),
                        buildRadioTile<Gender>(
                          label: Strings.female,
                          value: Gender.female,
                          groupValue: authController.userGender,
                          onChanged: authController.setUserGender,
                          values: Gender.values,
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        Obx(() {
          switch (authController.userState.value) {
            case UserState.normal:
              return buildHaghighiForm();
            case UserState.legal:
              return buildLegalForm();
            default:
              return SizedBox(); // or any fallback widget
          }
        }),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: CustomText(' سیگما را مطالعه نمودم و می پذیرم',
                  size: 12, maxLine: 2),
            ),
            InkWell(
              onTap: () => Get.toNamed(RouteName.rules),
              child: CustomText(' شرایط و قوانین ',
                  fontWeight: FontWeight.bold, size: 14),
            ),
            Obx(
              () => CustomCheckBox(
                  value: authController.hasConfirmedRules.value,
                  onChanged: authController.setHasConfirmedRules),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        ConfirmButton(() {
          authController.register();
        }, Strings.register),
        const SizedBox(
          height: 12,
        ),
        InkWell(
          child: CustomText(Strings.hasAlreadyAccount),
          onTap: () => authController.goToLogin(),
        )
      ],
    );
  }

  return Column(
    children: [
      SizedBox(
        height: 52,
      ),
      back(authController),
      CustomText(Strings.account, size: 32, fontWeight: FontWeight.bold),
      const SizedBox(
        height: 8,
      ),
      Obx(() => switch (authController.registerState.value) {
            RegisterPageState.forms => Expanded(
                child: SingleChildScrollView(child: buildRegisterForms())),
            RegisterPageState.otp => buildRegisterOtp()
          })
    ],
  );
}
