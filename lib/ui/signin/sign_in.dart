import 'package:expense_money_manager/controller/login_controller.dart';
import 'package:expense_money_manager/reusable_widgets/common_edit_text_field.dart';
import 'package:expense_money_manager/reusable_widgets/common_elevated_button.dart';
import 'package:expense_money_manager/servies/getx_storage.dart';
import 'package:expense_money_manager/utils/app_color.dart';
import 'package:expense_money_manager/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GetXStorage storage = GetXStorage();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginController loginController = Get.put(LoginController());
  // void _login() {
  //   if (_formKey.currentState!.validate()) {
  //     print("Email: ${_phoneController.text}");
  //     print("Password: ${_passwordController.text}");
  //
  //     storage.write('isLoggedIn', true);
  //
  //     // Navigate to HomePage
  //     Get.off(() => HomePage());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Card(
          color: AppColors.white,
          margin: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Sign In",
                      style: TextStyles().textStylePoppins(
                        size: 24,
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CommonEditTextField(
                    validator:
                        (value) =>
                            value!.isEmpty
                                ? "Please enter your Phone number"
                                : null,
                    hintText: 'Phone',
                    textEditingController: _phoneController,
                    textInputType: TextInputType.number,
                    prefixIcon: Icon(
                      Icons.phone,
                      size: 24,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 15),
                  CommonEditTextField(
                    textEditingController: _passwordController,
                    hintText: "Password",
                    isPassword: true,
                    obscureText: true,
                    obscuringCharacter: "*",
                    textInputType: TextInputType.number,
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 24,
                      color: AppColors.black,
                    ),
                    validator:
                        (value) =>
                            value!.isEmpty
                                ? "Please enter your password"
                                : null,
                  ),
                  SizedBox(height: 20),
                  Obx(() {
                    return SizedBox(
                      width: double.infinity,
                      child: CommonElevatedButton(
                        onPressed:
                            loginController.isLoading.value
                                ? () {}
                                : () {
                                  if (_formKey.currentState!.validate()) {
                                    loginController.login(
                                      _phoneController.text,
                                      _passwordController.text,
                                    );
                                  }
                                },

                        text:
                            loginController.isLoading.value
                                ? 'Logging in...'
                                : 'Login',
                        backgroundColor: AppColors.primaryColor,
                        progressColor: AppColors.white,
                        disabledBackgroundColor: AppColors.green200,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
