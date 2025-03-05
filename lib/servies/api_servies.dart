import 'dart:convert';

import 'package:expense_money_manager/servies/getx_storage.dart';
import 'package:expense_money_manager/utils/url_endpoint.dart';
import 'package:get/get_connect/connect.dart';

class ApiService extends GetConnect {
  Map<String, String> headers = {};

  @override
  void onInit() {
    httpClient.baseUrl = UrlEndPoints.baseUrl;
    httpClient.timeout = const Duration(seconds: 30);
    headers = {
      // "Authorization": GetXStorage().getToken() ?? "",
      "Authorization": "Bearer ${GetXStorage().getToken() ?? ""}",
      "Content-Type": "application/json",
    };
    super.onInit();
  }

  Future<Response> login(Map<String, dynamic> data) async {
    return post(UrlEndPoints.login, data);
  }

  Future<Response> getCustomers() async {
    return get("${UrlEndPoints.customer}", headers: headers);
  }
  // Future<Response?> getCustomers() async {
  //   try {
  //     var response = await get(UrlEndPoints.customer, headers: headers);
  //     return response;
  //   } catch (e) {
  //     print("API Call Failed: $e");
  //     return null;
  //   }
  // }

  Future<Response> deleteCustomer(int id) async {
    return delete("${UrlEndPoints.customer}/$id", headers: headers);
  }

  // Create a new customer
  Future<Response> createCustomer(Map<String, dynamic> data) async {
    // updateHeaders();
    return post(UrlEndPoints.customer, jsonEncode(data), headers: headers);
  }

  // // Fetch customer list
  // Future<Response> getCustomers() async {
  //   return get(UrlEndPoints.customer, headers: headers);
  // }
  //
  // // Create a new customer
  // Future<Response> createCustomer(Map<String, dynamic> data) async {
  //   return post(UrlEndPoints.customer, data, headers: headers);
  // }
  //
  // // Update customer
  // Future<Response> updateCustomer(int id, Map<String, dynamic> data) async {
  //   return put("${UrlEndPoints.customer}/$id", data, headers: headers);
  // }
  //
  // // Delete customer
  // Future<Response> deleteCustomer(int id) async {
  //   return delete("${UrlEndPoints.customer}/$id", headers: headers);
  // }
}
