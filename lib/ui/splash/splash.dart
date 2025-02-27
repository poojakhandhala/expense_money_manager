import 'dart:async';

import 'package:expense_money_manager/ui/dashborad/homePage.dart';
import 'package:expense_money_manager/ui/signin/sign_in.dart';
import 'package:expense_money_manager/utils/app_color.dart';
import 'package:expense_money_manager/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final storage = GetStorage();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      bool isLoggedIn = storage.read('isLoggedIn') ?? false;
      if (isLoggedIn) {
        Get.off(() => HomePage());
      } else {
        Get.off(() => SignIn());
      }
    });
  }

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
