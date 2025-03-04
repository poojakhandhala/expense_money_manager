import 'package:expense_money_manager/controller/base_controller.dart';
import 'package:expense_money_manager/model/login_api_model.dart';
import 'package:expense_money_manager/servies/api_servies.dart';
import 'package:expense_money_manager/servies/getx_storage.dart';
import 'package:expense_money_manager/ui/dashborad/homePage.dart';
import 'package:expense_money_manager/utils/app_prefernce_key.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final ApiService apiService = ApiService();
  final GetXStorage storage = GetXStorage();

  var isLoading = false.obs;

  Future<void> login(String mobile, String password) async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      print("Login Request: Mobile=$mobile, Password=$password");
      final response = await apiService.login({
        "mobile": mobile,
        "password": password,
      });

      if (response.statusCode == 200) {
        final loginResponse = LoginResponse.fromJson(response.body);

        if (loginResponse.status == true && loginResponse.token != null) {
          storage.setData(TOKEN, loginResponse.token);
          storage.setData(USER, loginResponse.user?.toJson());
          // storage.setData('isLoggedIn', true);
          print("Stored Token: ${storage.getToken()}");
          Get.off(() => HomePage()); // Navigate to home
        } else {
          Get.snackbar("Error", loginResponse.message ?? "Login failed");
        }
      } else {
        Get.snackbar("Error", "Invalid phone or password");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    storage.clearData();
    Get.offAllNamed('/signIn');
  }
}
