import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BorrowController2 extends GetxController {
  var borrow = <Map<String, dynamic>>[].obs;
  var selectedborrowIndex = (-1).obs;
  final storage = GetStorage();
  @override
  void onInit() {
    super.onInit();
    loadborrowCustomers();
  }

  void addborrowCustomer(
    String name, {
    // String amount,
    int givenAmount = 0,
    int takenAmount = 0,
  }) {
    int balance = takenAmount - givenAmount;
    borrow.add({
      "name": name,

      "givenAmount": givenAmount,
      "takenAmount": takenAmount,
      "balance": balance,
    });
    saveborrowCustomers();
    update();
  }

  void deleteborrowCustomer(int index) {
    borrow.removeAt(index);
    saveborrowCustomers();
    if (selectedborrowIndex.value == index) {
      selectedborrowIndex.value = -1;
    }
    update();
  }

  void selectborrowCustomer(int index) {
    selectedborrowIndex.value = index;
  }

  void saveborrowCustomers() {
    storage.write('borrow_list', borrow);
  }

  void loadborrowCustomers() {
    var storedBorrowCustomers = storage.read<List>('borrow_list') ?? [];
    if (storedBorrowCustomers.isNotEmpty) {
      borrow.assignAll(
        storedBorrowCustomers.map((e) => Map<String, dynamic>.from(e)).toList(),
      );
    }
  }
  //
  // void saveborrowCustomers() {
  //   storage.write('customers', borrow);
  // }
  //
  // void loadborrowCustomers() {
  //   var storedCustomers = storage.read<List>('customers') ?? [];
  //   if (storedCustomers != null) {
  //     borrow.assignAll(
  //       storedCustomers.map((e) => Map<String, dynamic>.from(e)).toList(),
  //     );
  //   }
  // }

  void updateborrowBalance(
    String name,
    bool isGiven,
    int amount,
    String description,
  ) {
    int index = borrow.indexWhere((customer) => customer["name"] == name);
    if (index != -1) {
      // var customer = borrow[index];
      var customer = Map<String, dynamic>.from(borrow[index]);

      if (isGiven) {
        customer["givenAmount"] += amount;
      } else {
        customer["takenAmount"] += amount;
      }
      customer["balance"] = customer["takenAmount"] - customer["givenAmount"];
      borrow[index] = customer; // Update the list
      saveborrowCustomers();
      update(); // Notify UI
    }
  }
}
