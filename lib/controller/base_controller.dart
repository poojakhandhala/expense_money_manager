import 'package:expense_money_manager/servies/api_servies.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  RxBool loader = false.obs;
  RxBool innerLoader = false.obs;
  final ApiService apiService = Get.find();

  setIsLoader({bool value = false}) {
    loader.value = value;
  }
}
