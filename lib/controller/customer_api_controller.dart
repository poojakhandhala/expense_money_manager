import 'package:expense_money_manager/model/customer_model.dart';
import 'package:expense_money_manager/servies/api_servies.dart';
import 'package:get/get.dart';

class CustomerApiController extends GetxController {
  var customers = <CustomerModel>[].obs;
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    fetchCustomers();
    super.onInit();
  }

  Future<void> fetchCustomers() async {
    try {
      final response = await apiService.getCustomers();
      if (response.statusCode == 200) {
        final responseData = response.body;
        if (responseData['status'] == true) {
          List<CustomerModel> customerList =
              (responseData['data'] as List)
                  .map((json) => CustomerModel.fromJson(json))
                  .toList();
          customers.assignAll(customerList);
        }
      } else {
        Get.snackbar("Error", "Failed to load customers");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    }
  }

  void deleteCustomer(int index) {
    customers.removeAt(index);
  }
}
