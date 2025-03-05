import 'dart:convert';

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
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        final result = ResponseDataArrayModel.fromJson(CustomerModel(), data);
        customersApi.value = result.data ?? [];
        print(result);
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
  // void addCustomer(String name, String phone) async {
  //   setIsLoader(value: true);
  //   final newCustomer = {
  //     "name": name,
  //     "mobile": phone,
  //     "email": "", // Add email field if needed
  //     "address": "", // Add address field if needed
  //   };
  //
  //   try {
  //     final response = await apiService.createCustomer(newCustomer);
  //     print("Add Customer Response: ${response.body}");
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       var responseData = jsonDecode(response.body);
  //
  //       if (responseData['status'] == true && responseData['data'] != null) {
  //         var createdCustomer = CustomerModel.fromJson(responseData['data']);
  //         customersApi.add(createdCustomer);
  //         // customersApi.assignAll([...customersApi, createdCustomer]);
  //       } else {
  //         Get.snackbar(
  //           "Error",
  //           responseData['message'] ?? "Failed to add customer",
  //         );
  //       }
  //     } else {
  //       Get.snackbar("Error", "Failed to add customer");
  //     }
  //   } catch (e) {
  //     print("Add Customer Error: $e");
  //     Get.snackbar("Error", "An error occurred while adding customer.");
  //   }
  //   setIsLoader(value: false);
  // }

  //
  // void addCustomer(String name, String phone) async {
  //   setIsLoader(value: true);
  //   final newCustomer = {"name": name, "mobile": phone};
  //
  //   final response = await apiService.createCustomer(newCustomer);
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     fetchCustomers();
  //   } else {
  //     Get.snackbar("Error", "Failed to add customer");
  //   }
  //   setIsLoader(value: false);
  // }

  void deleteCustomer(int id) async {
    setIsLoader(value: true);
    try {
      final response = await apiService.deleteCustomer(id);
      print("Delete Response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 204) {
        customersApi.removeWhere((customer) => customer.id == id);
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
