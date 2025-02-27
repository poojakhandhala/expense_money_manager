import 'package:expense_money_manager/routes/routes.dart';
import 'package:expense_money_manager/ui/add_customer/balance_page.dart';
import 'package:expense_money_manager/ui/add_customer/customer_Info.dart';
import 'package:expense_money_manager/ui/add_customer/customer_detail.dart';
import 'package:expense_money_manager/ui/borrow/borrow_addform.dart';
import 'package:expense_money_manager/ui/borrow/borrow_detail.dart';
import 'package:expense_money_manager/ui/dashborad/homePage.dart';
import 'package:expense_money_manager/ui/setting/setting.dart';
import 'package:expense_money_manager/ui/signin/sign_in.dart';
import 'package:expense_money_manager/ui/splash/splash.dart';
import 'package:get/get.dart';

class RoutesFileName {
  static final routes = [
    GetPage(name: Routes.splash, page: () => const SplashPage()),
    GetPage(name: Routes.signIn, page: () => const SignIn()),
    GetPage(name: Routes.homePage, page: () => const HomePage()),
    GetPage(name: Routes.setting, page: () => SettingPage()),
    GetPage(name: Routes.borrwDetail, page: () => BorrowDetailPage()),
    GetPage(name: Routes.borrowAddForm, page: () => BorrowAddForm()),
    GetPage(name: Routes.customerInfo, page: () => CustomerInfoPage()),
    GetPage(
      name: Routes.cutomerDetail,
      page: () => CustomerDetailPage(customer: Get.arguments),
    ),
    GetPage(
      name: Routes.balancePage,
      page:
          () => UpdateBalancePage(
            customer: Get.arguments['customer'],
            isGiven: Get.arguments['isGiven'],
          ),
    ),
    GetPage(name: Routes.addCutomerPage, page: () => CustomerInfoPage()),
  ];
}
