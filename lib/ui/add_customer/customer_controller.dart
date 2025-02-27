import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CustomerController extends GetxController {
  var customers = <Map<String, dynamic>>[].obs;
  var selectedCustomerIndex = (-1).obs;

  final storage = GetStorage();
  @override
  void onInit() {
    super.onInit();
    loadCustomers();
  }

  void addCustomer(
    String name,
    String phone, {
    int givenAmount = 0,
    int takenAmount = 0,
  }) {
    int balance = takenAmount - givenAmount;
    customers.add({
      "name": name,
      "phone": phone,
      "givenAmount": givenAmount,
      "takenAmount": takenAmount,
      "balance": balance,
    });
    saveCustomers();
  }

  void deleteCustomer(int index) {
    customers.removeAt(index);
    saveCustomers();
    if (selectedCustomerIndex.value == index) {
      selectedCustomerIndex.value = -1;
    }
  }

  void selectCustomer(int index) {
    selectedCustomerIndex.value = index;
  }

  void saveCustomers() {
    storage.write('customers', customers);
  }

  void loadCustomers() {
    var storedCustomers = storage.read<List>('customers') ?? [];
    if (storedCustomers != null) {
      customers.assignAll(
        storedCustomers.map((e) => Map<String, dynamic>.from(e)).toList(),
      );
    }
  }

  void updateBalance(
    String phone,
    bool isGiven,
    int amount,
    DateTime date,
    String description,
  ) {
    int index = customers.indexWhere((customer) => customer["phone"] == phone);

    if (index != -1) {
      var customer = customers[index];

      if (isGiven) {
        customer["givenAmount"] += amount;
      } else {
        customer["takenAmount"] += amount;
      }

      customer["balance"] = customer["givenAmount"] - customer["takenAmount"];

      customers[index] = customer; // Update the list
      saveCustomers();
      update(); // Notify UI
    }
  }

  // void selectCustomer(int index) {
  //   if (selectedCustomerIndex.value == index) {
  //     selectedCustomerIndex.value = -1; // Unselect if already selected
  //   } else {
  //     selectedCustomerIndex.value = index;
  //   }
  // }
}
