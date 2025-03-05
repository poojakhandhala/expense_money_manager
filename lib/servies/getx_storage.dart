import 'package:expense_money_manager/utils/app_prefernce_key.dart';
import 'package:get_storage/get_storage.dart';

class GetXStorage {
  void setData(String key, dynamic value) => GetStorage().write(key, value);

  int? getInt(String key) => GetStorage().read(key);

  String? getString(String key) => GetStorage().read(key);

  bool? getBool(String key) => GetStorage().read(key);

  double? getDouble(String key) => GetStorage().read(key);

  dynamic getData(String key) => GetStorage().read(key);

  void clearData() async => GetStorage().erase();
  String getToken() {
    if (getString(TOKEN) != null) {
      return getString(TOKEN) ?? "";
    }
    return "";
  }

  bool isLogin() {
    if (getToken() != "") {
      return true;
    }
    return false;
  }
}
