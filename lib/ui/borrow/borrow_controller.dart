import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BorrowController extends GetxController {
  final storage = GetStorage();
  var borrowList = <Map<String, dynamic>>[].obs;
  var selectedborrowCustomerIndex = (-1).obs;
  @override
  void onInit() {
    super.onInit();
    loadTransactions();
  }

  void addTransaction(Map<String, dynamic> transaction) {
    borrowList.add(transaction);
    saveTransactions();
  }

  void saveTransactions() {
    storage.write('borrowList', borrowList);
  }

  void loadTransactions() {
    var storedData = storage.read<List>('borrowList');
    if (storedData != null) {
      borrowList.assignAll(storedData.cast<Map<String, dynamic>>());
    }
  }

  void clearTransactions() {
    borrowList.clear();
    storage.remove('borrowList');
  }

  void updateTransaction(int index, Map<String, dynamic> updatedTransaction) {
    borrowList[index] = updatedTransaction;
    saveTransactions();
    update();
  }

  void deleteCustomer(int index) {
    borrowList.removeAt(index);
    saveTransactions();
    update();
  }
}
