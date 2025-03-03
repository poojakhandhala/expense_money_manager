import 'package:easy_localization/easy_localization.dart';
import 'package:expense_money_manager/routes/routes.dart';
import 'package:expense_money_manager/routes/routes_file_name.dart';
import 'package:expense_money_manager/ui/borrow/borrow_controller2.dart';
import 'package:expense_money_manager/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'ui/add_customer/customer_controller.dart';
import 'ui/discount/discount_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();
  Get.put(CustomerController());
  Get.put(BorrowController2());
  Get.put(DiscountController());
  runApp(
    EasyLocalization(
      supportedLocales: [Locale("en", "US"), Locale("gu", "IN")],
      path: "assets/translations",
      // fallbackLocale: Locale('en', 'US'),
      saveLocale: true,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: context.locale, // Use EasyLocalization context
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      getPages: RoutesFileName.routes,
      initialRoute: Routes.splash,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
      ),
    );
  }
}
