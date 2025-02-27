import 'package:expense_money_manager/reusable_widgets/common_edit_text_field.dart';
import 'package:expense_money_manager/reusable_widgets/common_elevated_button.dart';
import 'package:expense_money_manager/ui/dashborad/homePage.dart';
import 'package:expense_money_manager/utils/app_color.dart';
import 'package:expense_money_manager/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final storage = GetStorage();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void _login() {
    if (_formKey.currentState!.validate()) {
      print("Email: ${_emailController.text}");
      print("Password: ${_passwordController.text}");

      storage.write('isLoggedIn', true);

      // Navigate to HomePage
      Get.off(() => HomePage());
    }
  }

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
            padding: const EdgeInsets.all(20),
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
                            value!.isEmpty ? "Please enter your email" : null,
                    hintText: 'Email',
                    textEditingController: _emailController,
                    textInputType: TextInputType.emailAddress,
                    prefixIcon: Icon(
                      Icons.email,
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
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: CommonElevatedButton(
                      onPressed: _login,

                      text: 'Login',

                      backgroundColor: AppColors.primaryColor,
                      progressColor: AppColors.white,
                      disabledBackgroundColor: AppColors.green200,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
