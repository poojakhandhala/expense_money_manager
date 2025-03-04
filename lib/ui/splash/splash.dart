import 'dart:async';

import 'package:expense_money_manager/controller/login_controller.dart';
import 'package:expense_money_manager/routes/routes.dart';
import 'package:expense_money_manager/servies/getx_storage.dart';
import 'package:expense_money_manager/utils/app_color.dart';
import 'package:expense_money_manager/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart' show Get;
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final GetXStorage storage = GetXStorage();
  final LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 3), () {
      if (storage.isLogin()) {
        Get.offAllNamed(Routes.homePage);
      } else {
        Get.offAllNamed(Routes.signIn);
      }
    });
  }
  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(const Duration(seconds: 2), () {
  //     bool isLoggedIn = storage.read('isLoggedIn') ?? false;
  //     if (isLoggedIn) {
  //       Get.off(() => HomePage());
  //     } else {
  //       Get.off(() => SignIn());
  //     }
  //   });
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.white, body: _buildMain());
  }

  Widget _buildMain() {
    return Container(
      child: Center(
        child: Image.asset(
          AssetsPath.appLogo,
          width: 300,
          // height: 200,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
