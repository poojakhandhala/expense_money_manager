import 'dart:convert';

import 'package:expense_money_manager/servies/getx_storage.dart';
import 'package:expense_money_manager/utils/url_endpoint.dart';
import 'package:get/get_connect/connect.dart';

class ApiService extends GetConnect {
  Map<String, String> headers = {};

  @override
  void onInit() {
    // same api hoy to url use krvni
    httpClient.baseUrl = UrlEndPoints.baseUrl;

    httpClient.timeout = const Duration(seconds: 30);
    headers = {
      "Authorization": GetXStorage().getToken() ?? "",
      "Content-Type": "application/json",
    };

    super.onInit();
  }

  Future<Response> login(Map<String, dynamic> data) async {
    return post(UrlEndPoints.login, jsonEncode(data), headers: headers);
  }

  Future<Response> customers(Map<String, dynamic> data) async {
    return post(UrlEndPoints.customer, jsonEncode(data), headers: headers);
  }

  Future<Response> getCustomers() async {
    return get(UrlEndPoints.customer);
  }
}
