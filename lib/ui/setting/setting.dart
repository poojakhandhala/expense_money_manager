import 'package:easy_localization/easy_localization.dart';
import 'package:expense_money_manager/reusable_widgets/common_app_bar.dart';
import 'package:expense_money_manager/reusable_widgets/common_edit_text_field.dart';
import 'package:expense_money_manager/reusable_widgets/common_elevated_button.dart';
import 'package:expense_money_manager/ui/dashborad/homePage.dart';
import 'package:expense_money_manager/utils/app_color.dart';
import 'package:expense_money_manager/utils/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isScreenLockEnabled = false;
  String selectedLanguage = "English";
  final TextEditingController lockpass = TextEditingController();
  List<bool> isSelected = [true, false];
  @override
  void initState() {
    super.initState();
    _loadScreenLockState();
    _loadSelectedLanguage(); // Load stored language on init
  }

  Future<void> _loadScreenLockState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isScreenLockEnabled = prefs.getBool("screenLock") ?? false;
    });
  }

  Future<void> _updateScreenLock(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("screenLock", value);
    setState(() {
      isScreenLockEnabled = value;
    });
    if (value) {
      _showSetPinDialog();
    }
  }

  Future<void> _updateLanguage(Locale locale, int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      "selectedLanguage",
      locale.languageCode,
    ); // Store selected language
    await context.setLocale(locale); // Change the language
    setState(() {
      isSelected = [index == 0, index == 1]; // Update UI toggle state
    });
  }

  Future<void> _loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? langCode =
        prefs.getString("selectedLanguage") ?? "en"; // Default to English
    Locale locale = Locale(langCode, langCode == "en" ? "US" : "IN");

    if (context.supportedLocales.contains(locale)) {
      await context.setLocale(locale);
      setState(() {
        isSelected = [langCode == "en", langCode == "gu"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CommonAppBar(title: 'settings'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: Column(
          children: [
            _buildScreenLockToggle(),
            const SizedBox(height: 20),
            _buildLanguageDropdown(context),
          ],
        ),
      ),
    );
  }

  Widget _buildScreenLockToggle() {
    return Card(
      elevation: 3,
      // color: AppColors.inActiveColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title:
            Text(
              "screen_lock",
              style: TextStyles().textStylePoppins(
                size: 14,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
        trailing: Switch(
          value: isScreenLockEnabled,
          onChanged: _updateScreenLock,
          activeColor: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown(BuildContext context) {
    return Card(
      elevation: 3,
      // color: AppColors.inActiveColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "languages",
              style: TextStyles().textStylePoppins(
                size: 14,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ).tr(),
            SizedBox(height: 10),

            Center(
              child: ToggleButtons(
                borderRadius: BorderRadius.circular(10),
                selectedColor: AppColors.white,
                fillColor: AppColors.primaryColor,
                color: AppColors.black,
                isSelected: isSelected,
                onPressed: (index) async {
                  final locale =
                      index == 0 ? Locale('en', 'US') : Locale('gu', 'IN');
                  await _updateLanguage(locale, index);
                },

                // onPressed: (index) {
                //   setState(() {
                //     for (int i = 0; i < isSelected.length; i++) {
                //       isSelected[i] = i == index;
                //     }
                //     if (index == 0) {
                //       // English is selected
                //       context.setLocale(Locale('en', 'US'));
                //     } else {
                //       // Gujarati is selected
                //       context.setLocale(Locale('gu', 'IN'));
                //     }
                //   });
                // },
                // onPressed: (index) async {
                //   final locale =
                //       index == 0 ? Locale('en', 'US') : Locale('gu', 'IN');
                //
                //   if (context.supportedLocales.contains(locale)) {
                //     await context.setLocale(locale);
                //     setState(() {
                //       isSelected = [index == 0, index == 1];
                //     });
                //   } else {
                //     print("Locale not supported: $locale");
                //   }
                // },
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child:
                        Text(
                          'english',
                          style: TextStyles().textStylePoppins(
                            size: 14,

                            fontWeight: FontWeight.w500,
                          ),
                        ).tr(),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child:
                        Text(
                          'gujarati',
                          style: TextStyles().textStylePoppins(
                            size: 14,

                            fontWeight: FontWeight.w500,
                          ),
                        ).tr(),
                  ),
                ],
              ),
            ),

            // trailing: DropdownButton<String>(
            //   value: selectedLanguage,
            //   onChanged: (newValue) {
            //     if (newValue != null) {
            //       _updateLanguage(newValue);
            //     }
            //   },
            //   items:
            //       ["English", "Gujarati", "Hindi"]
            //           .map(
            //             (translations) => DropdownMenuItem(value: translations, child: Text(translations)),
            //           )
            //           .toList(),
            // ),
          ],
        ),
      ),
    );
  }

  void _showSetPinDialog() {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "set_PIN",
                  style: TextStyles().textStylePoppins(
                    size: 20,
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ).tr(),
                TextButton(
                  onPressed: _resetPin,
                  child:
                      Text(
                        'reset_pass',
                        style: TextStyles().textStylePoppins(
                          size: 14,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ).tr(),
                ),
              ],
            ),

            Text(
              "enter_pinTital",
              style: TextStyles().textStylePoppins(
                size: 14,
                color: AppColors.grey,
                fontWeight: FontWeight.w500,
              ),
            ).tr(),
            const SizedBox(height: 15),
            CommonEditTextField(
              textInputType: TextInputType.number,
              prefixIcon: Icon(Icons.lock, color: AppColors.black, size: 24),
              hintText: "4_digit".tr(),
              textEditingController: lockpass,

              maxLength: 4,
              onChange: (value) {
                if (value.length == 4) {
                  _setNewPin(value);
                }
              },
            ),
            const SizedBox(height: 15),
            CommonElevatedButton(
              onPressed: () => Get.back(),
              text: 'done'.tr(),
              progressColor: AppColors.white,
              backgroundColor: AppColors.primaryColor,
              disabledBackgroundColor: AppColors.lightGrey1,
            ),
          ],
        ),
      ),
    );
  }

  void _setNewPin(String pin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("lockPin", pin);
    Get.back();
    Get.snackbar(
      "success".tr(),
      "success_pin".tr(),
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.offAll(() => HomePage());
  }

  void _resetPin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("lockPin");
    lockpass.clear();
    Get.snackbar(
      "reset".tr(),
      "reset_pin".tr(),
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.offAll(() => HomePage());
  }

  // void _showSetPinDialog() {
  //   Get.bottomSheet(
  //     Container(
  //       width: double.infinity,
  //       padding: const EdgeInsets.all(20),
  //       decoration: BoxDecoration(
  //         color: AppColors.white,
  //         borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Text(
  //             "Welcome to Screen Lock",
  //             style: TextStyles().textStylePoppins(
  //               size: 20,
  //               color: AppColors.black,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           SizedBox(height: 10),
  //           Text(
  //             "Set PIN Code",
  //             style: TextStyles().textStylePoppins(
  //               size: 16,
  //               color: AppColors.primaryColor,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           const SizedBox(height: 15),
  //           CommonEditTextField(
  //             prefixIcon: Icon(Icons.lock, color: AppColors.black, size: 24),
  //             hintText: "****",
  //             textEditingController: lockpass,
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               Get.back();
  //               _setNewPin();
  //             },
  //             child: const Text("Set PIN"),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // void _setNewPin() {
  //   screenLockCreate(
  //     digits: 4,
  //     context: context,
  //     onConfirmed: (pin) async {
  //       final prefs = await SharedPreferences.getInstance();
  //       await prefs.setString("lockPin", pin);
  //       Get.snackbar(
  //         "Success",
  //         "PIN set successfully",
  //         snackPosition: SnackPosition.BOTTOM,
  //       );
  //     },
  //   );
  // }
}
