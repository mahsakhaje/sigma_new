import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sigma/global_custom_widgets/confirm_button.dart';
import 'package:sigma/global_custom_widgets/custom_drop_box.dart';
import 'package:sigma/global_custom_widgets/custom_text.dart';
import 'package:sigma/global_custom_widgets/custom_textFiels.dart';
import 'package:sigma/global_custom_widgets/dark_main_widget.dart';
import 'package:sigma/global_custom_widgets/dual_widget.dart';
import 'package:sigma/global_custom_widgets/radio_list_tile.dart';
import 'package:sigma/helper/colors.dart';
import 'package:sigma/helper/helper.dart';
import 'package:sigma/helper/strings.dart';
import 'package:sigma/pages/profile/edit/edit_profile_controller.dart';
import 'package:sigma/global_custom_widgets/support_call.dart';
import 'package:sigma/global_custom_widgets/loading.dart';

class EditProfileInfo extends StatelessWidget {
  EditProfileInfo({Key? key}) : super(key: key);

  final EditProfileController controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return DarkBackgroundWidget(
      title: Strings.editProfile,
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: loading());
        }

        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 34),
                    _buildProfileHeader(),
                    const SizedBox(height: 34),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildRadioTile<Gender>(
                            label: Strings.male,
                            value: Gender.male,
                            enabled: controller.isEnabled.value,

                            groupValue: controller.userGender,
                            onChanged: controller.setUserGender,
                            values: Gender.values,
                          ),
                          const SizedBox(width: 36),
                          buildRadioTile<Gender>(
                            label: Strings.female,
                            enabled: controller.isEnabled.value,
                            value: Gender.female,
                            groupValue: controller.userGender,
                            onChanged: controller.setUserGender,
                            values: Gender.values,
                          ),
                        ],
                      ),
                    ),
                    _buildForm(),
                    const SizedBox(height: 34),
                    _buildSubmitButton(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        const SizedBox(height: 8),
        CustomText(controller.fullName.value, size: 16,fontWeight: FontWeight.bold),
        const SizedBox(height: 8),
        Center(
            child: CustomText(controller.phoneNumber.value!.usePersianNumbers(),fontWeight: FontWeight.bold,
                size: 16)),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildProvinceField() {
    return controller.isEnabled.value
        ? CustomDropdown(
            hint: Strings.province,
            value: controller.selectedProvince.value,
            items: controller.geoNames,
            isTurn: false,
            largeFont: true,
            onChanged: controller.onProvinceChanged,
          )
        : CustomTextFormField(
            controller.provinceController,
            enabled: false,
            maxLen: 20,
            // isOnlyLetter: true,
            hintText: Strings.province,
          );
  }

  Widget _buildCityField() {
    print(controller.selectedCity.value);
    print(controller.geoCityNames);
    return controller.isEnabled.value
        ? CustomDropdown(
            hint: Strings.city,
            value: controller.selectedCity.value,
            largeFont: true,
            items: controller.geoCityNames,
            isTurn: false,
            onChanged: controller.onCityChanged,
          )
        : CustomTextFormField(
            controller.cityController,
            enabled: false,
            maxLen: 20,

            // isOnlyLetter: true,
            hintText: Strings.city,
          );
  }

  Widget _buildForm() {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          dualRow(_buildNameField(), _buildLastNameField()),
         // dualRow(_buildNationalIdField(), _buildPostalCodeField()),
          dualRow(_buildProvinceField(), _buildCityField()),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: _buildAddressField(),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: _buildEmailField(),
          ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return CustomTextFormField(
      controller.nameController,
      enabled: controller.isEnabled.value,
      maxLen: 20,
      //isOnlyLetter: true,
      hintText: Strings.firstName,
    );
  }

  Widget _buildLastNameField() {
    return CustomTextFormField(
      controller.lastNameController,
      enabled: controller.isEnabled.value,
      maxLen: 30,
      // isOnlyLetter: true,
      hintText: Strings.lastName,
    );
  }

  Widget _buildNationalIdField() {
    return CustomTextFormField(
      controller.nationalIdController,
      enabled: controller.isEnabled.value,
      maxLen: 10,
      //isOnlyNumber: true,
      isNationalId: true,
      hintText: Strings.nationalCode,
    );
  }

  Widget _buildAddressField() {
    return CustomTextFormField(
      controller.addressController,
      enabled: controller.isEnabled.value,
      maxLen: 500,
      hintText: Strings.address,
      autovalidateMode: AutovalidateMode.disabled,
    );
  }

  Widget _buildPostalCodeField() {
    return CustomTextFormField(
      controller.postalCodeController,
      enabled: controller.isEnabled.value,
      maxLen: 10,
      isOnlyNumber: true,
      // isPostalCode: true,
      // isOnlyNumber: true,
      hintText: Strings.postalCode,
      autovalidateMode: AutovalidateMode.disabled,
    );
  }

  Widget _buildEmailField() {
    return CustomTextFormField(
      controller.emailController,
      hintText: Strings.email,
      maxLen: 50,
      autovalidateMode: AutovalidateMode.disabled,
      enabled: controller.isEnabled.value,
       isEmail: true,
    );
  }

  Widget _buildSubmitButton() {
    return controller.isLoading.value
        ? Center(child: loading())
        : ConfirmButton(
            controller.submitForm,
            controller.isEnabled.value ? "ثبت" : "ویرایش",
            color: AppColors.blue,
            txtColor: Colors.white,
          );
  }
}
