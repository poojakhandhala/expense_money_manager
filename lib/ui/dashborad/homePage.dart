import 'package:easy_localization/easy_localization.dart';
import 'package:expense_money_manager/reusable_widgets/common_edit_text_field.dart';
import 'package:expense_money_manager/reusable_widgets/common_elevated_button.dart';
import 'package:expense_money_manager/ui/add_customer/customer_Info.dart';
import 'package:expense_money_manager/ui/borrow/borrow_detail.dart';
import 'package:expense_money_manager/ui/discount/interest_detail.dart';
import 'package:expense_money_manager/ui/setting/setting.dart';
import 'package:expense_money_manager/utils/app_color.dart';
import 'package:expense_money_manager/utils/app_textstyles.dart';
import 'package:expense_money_manager/utils/assets_path.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController lockPassController = TextEditingController();

  final List<Map<String, dynamic>> category = [
    {
      'icon': AssetsPath.borrow,
      'name': "borrow_lent_detail",
      "page": () => BorrowDetailPage(),
    },
    {
      'icon': AssetsPath.discount,
      'name': "given_interest",
      "page": () => InterestDetailPage(),
    },
    {
      'icon': AssetsPath.person,
      'name': "add_customer",
      "page": () => CustomerInfoPage(),
    },
    {
      'icon': AssetsPath.setting,
      'name': "settings",
      "page": () => SettingPage(),
    },
  ];
  // final double totalIncome = 5400000;
  final double outgoing = 1800000;
  final double Income = 3600000; // Remaining 67%
  bool isLocked = true;
  @override
  void initState() {
    super.initState();
    _checkLock();
  }
  //
  // Future<void> _checkLock() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   bool isLockEnabled = prefs.getBool("screenLock") ?? false;
  //   String? savedPin = prefs.getString("lockPin");
  //
  //   if (isLockEnabled && savedPin != null) {
  //     Future.delayed(Duration.zero, () {
  //       screenLock(
  //         context: context,
  //         correctString: savedPin,
  //         onUnlocked: () {
  //           setState(() {
  //             isLocked = false;
  //           });
  //           Get.snackbar(
  //             "Unlocked",
  //             "Welcome back!",
  //             snackPosition: SnackPosition.BOTTOM,
  //           );
  //         },
  //       );
  //     });
  //   } else {
  //     setState(() {
  //       isLocked = false;
  //     });
  //   }
  // }

  Future<void> _checkLock() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLockEnabled = prefs.getBool("screenLock") ?? false;
    String? savedPin = prefs.getString("lockPin");

    if (isLockEnabled && savedPin != null) {
      Future.delayed(Duration.zero, () {
        _showLockBottomSheet(savedPin);
      });
    } else {
      setState(() {
        isLocked = false;
      });
    }
  }

  void _showLockBottomSheet(String correctPin) {
    Get.bottomSheet(
      Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          top: 10,
          left: 15,
          right: 15,
          bottom: 15,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 70,
                height: 2,

                decoration: BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "unlock_pin",
              textAlign: TextAlign.start,
              style: TextStyles().textStylePoppins(
                size: 20,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
            const SizedBox(height: 15),
            CommonEditTextField(
              textInputType: TextInputType.number,
              prefixIcon: Icon(Icons.lock, color: AppColors.black, size: 24),
              hintText: "4_digit".tr(),
              textEditingController: lockPassController,
              maxLength: 4,
            ),
            const SizedBox(height: 15),
            CommonElevatedButton(
              onPressed: () {
                if (lockPassController.text == correctPin) {
                  setState(() {
                    isLocked = false;
                  });
                  Get.back();
                  Get.snackbar(
                    "unlock".tr(),
                    "Welcome_back".tr(),
                    snackPosition: SnackPosition.BOTTOM,
                  );
                } else {
                  Get.snackbar(
                    "error".tr(),
                    "incorrect_pin".tr(),
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.red,
                    colorText: AppColors.white,
                  );
                }
              },
              text: 'unlock'.tr(),
              backgroundColor: AppColors.primaryColor,
              progressColor: AppColors.primaryColor,
              disabledBackgroundColor: AppColors.primaryColor,
            ),
          ],
        ),
      ),
      isDismissible: false,
      enableDrag: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: AppBar(
        backgroundColor: AppColors.white,
        title:
            Text(
              "dashboard",
              style: TextStyles().textStylePoppins(
                size: 20,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
      ),
      body: _buildMain(),
    );
  }

  Widget _buildMain() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30),
      child: Column(children: [_buildAmuout(), _buildSection()]),
    );
  }

  Widget _buildSection() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 20,
          childAspectRatio: 1.3,
        ),
        itemCount: category.length,
        itemBuilder: (context, index) {
          final item = category[index];
          return GestureDetector(
            onTap: () {
              Get.to(item['page']);
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item['icon'],
                    height: 30,
                    width: 30,
                    color: AppColors.white,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item['name'],
                    textAlign: TextAlign.center,
                    style: TextStyles().textStylePoppins(
                      size: 16,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ).tr(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAmuout() {
    return SizedBox(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPieChart(),
          const SizedBox(width: 20),
          SizedBox(
            width: 100,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                _buildIncomeExpenseTile(
                  title: "income",
                  color: AppColors.primaryColor,
                  spredcolor: AppColors.primarylightColor,
                  amount: Income.toStringAsFixed(0),
                ),
                const SizedBox(height: 10),
                _buildIncomeExpenseTile(
                  title: "outgoing",
                  amount: outgoing.toStringAsFixed(0),
                  color: AppColors.grey,
                  spredcolor: AppColors.lightGrey1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //
  // // Pie Chart Widget
  Widget _buildPieChart() {
    return SizedBox(
      height: 150,
      width: 200,
      child: PieChart(
        swapAnimationDuration: Duration(milliseconds: 10),
        PieChartData(
          sections: [
            PieChartSectionData(
              color: AppColors.greyF2,
              value: outgoing,
              title: "".tr(),
              titlePositionPercentageOffset: 0.4,
              radius: 40,
              titleStyle: TextStyles().textStylePoppins(
                size: 12,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            PieChartSectionData(
              color: AppColors.primaryColor,
              value: Income,
              title: "".tr(),
              radius: 40,
              titlePositionPercentageOffset: 0.4,
              titleStyle: TextStyles().textStylePoppins(
                size: 12,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          borderData: FlBorderData(show: false),
          sectionsSpace: 10,
          centerSpaceRadius: 50,
        ),
      ),
    );
  }

  // Income & Expense Tile Widget
  Widget _buildIncomeExpenseTile({
    required String title,
    required String amount,
    required Color color,
    required Color spredcolor,
  }) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: spredcolor,
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor: color,
                  // height: 10,
                  // width: 10,
                  // decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                title,
                style: TextStyles().textStylePoppins(
                  size: 14,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ).tr(),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            "₹$amount",
            style: TextStyles().textStylePoppins(
              size: 16,
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
