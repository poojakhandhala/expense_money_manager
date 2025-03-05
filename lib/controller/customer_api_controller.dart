import 'package:expense_money_manager/controller/base_controller.dart';
import 'package:expense_money_manager/model/customer_model.dart';
import 'package:expense_money_manager/model/respose_model.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/get_rx.dart';

class CustomerApiController extends BaseController {
  // final ApiService apiService = ApiService();
  var customersApi = <CustomerModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchCustomers();
    super.onInit();
  }

  // Fetch customers
  Future<void> fetchCustomers() async {
    apiService.onInit();
    setIsLoader(value: true);
    try {
      final response = await apiService.getCustomers();
      print('Response: ${response.body}');
      // if (response.statusCode == 200) {
      //   // Ensure response.body is properly parsed as Map
      //   Map<String, dynamic> data =
      //       response.body is String ? jsonDecode(response.body) : response.body;
      //
      //   // Extract data correctly
      //   if (data['status'] == true && data.containsKey('data')) {
      //     final result = ResponseDataArrayModel.fromJson(CustomerModel(), data);
      //     customersApi.value = result.data ?? [];
      //     print(result);
      //   } else {
      //     print("Invalid response format: $data");
      //     Get.snackbar("Error", "Invalid response format.");
      //   }
      // } else {
      //   String errorMessage = response.body["message"] ?? "Unknown error";
      //   print('Error: $errorMessage');
      //   Get.snackbar("Error", "Failed to fetch customers");
      // }
      if (response.statusCode == 200) {
        // Map<String, dynamic> data = jsonDecode(response.bodyString!);
        Map<String, dynamic> data = response.body;
        if (data["status"] == true) {
          final result = ResponseDataArrayModel.fromJson(CustomerModel(), data);
          customersApi.value = result.data ?? [];
          print(result);
          // final List<dynamic> customersList = data["data"];
          // customersApi.value =
          //     customersList.map((e) => CustomerModel.fromJson(e)).toList();
          // print(customersApi);
        } else {
          Get.snackbar("Error", "Failed to fetch customers");
        }
        // final result = ResponseDataArrayModel.fromJson(CustomerModel(), data);
        // customersApi.value = result.data ?? [];
        // print(result);
      } else {
        String errorMessage = response.body["message"] ?? "Unknown error";
        print('Error: $errorMessage');

        Get.snackbar("Error", "Failed to fetch customers");
      }
    } catch (e) {
      print(e);
    } finally {
      setIsLoader(value: false);
    }
  }

  // Add new customer
  Future<void> addCustomer(Map<String, dynamic> customerData) async {
    setIsLoader(value: true);
    try {
      final response = await apiService.createCustomer(customerData);
      print("Add Customer Response: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> data = response.body;
        if (data["status"] == true) {
          // Parse new customer and add to list
          CustomerModel newCustomer = CustomerModel.fromJson(data["data"]);
          customersApi.add(newCustomer);
          Get.snackbar("Success", "Customer added successfully");
        } else {
          print("API Response Error: ${response.body}");
          Get.snackbar("Error", "Failed to add customer");
        }
      } else {
        String errorMessage = response.body["message"] ?? "Unknown error";
        print('Error: $errorMessage');
        Get.snackbar("Error", "Failed to add customer");
      }
    } catch (e) {
      print("Add Customer Error: $e");
      Get.snackbar("Error", "An error occurred while adding the customer.");
    } finally {
      setIsLoader(value: false);
    }
  }

  void deleteCustomer(int id) async {
    setIsLoader(value: true);
    try {
      final response = await apiService.deleteCustomer(id);
      print("Delete Response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 204) {
        customersApi.removeWhere((customer) => customer.id == id);
        Get.snackbar("Success", "Customer deleted successfully");
      } else {
        Get.snackbar("Error", "Failed to delete customer");
      }
    } catch (e) {
      print("Delete Customer Error: $e");
      Get.snackbar("Error", "An error occurred while deleting customer.");
    }
    setIsLoader(value: false);
  }
}
