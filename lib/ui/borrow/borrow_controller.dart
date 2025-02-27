import 'package:get/get.dart';

class BorrowController extends GetxController {
  var borrowList = <Map<String, dynamic>>[].obs;

  void addTransaction(Map<String, dynamic> transaction) {
    borrowList.add(transaction);
  }
}
