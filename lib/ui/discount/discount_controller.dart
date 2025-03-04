import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DiscountController extends GetxController {
  final storage = GetStorage();
  var discount = <Map<String, dynamic>>[].obs;
  var selectedDiscountIndex = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    loadDiscountCustomers();
  }

  void addDiscountCustomer(
    String name, {
    int givenAmount = 0,
    int takenAmount = 0,
    String date = "",
    String description = "",
    String vyajDate = "",
    int discountPercentage = 0,
    int installmentAmount = 0,
  }) {
    int balance = takenAmount - givenAmount;
    double discountAmount = (balance * discountPercentage) / 100;
    balance -= discountAmount.toInt();
    discount.add({
      "name": name,
      "date": date,
      "description": description,
      "vyajDate": vyajDate,
      "discount": discountPercentage,
      "givenAmount": givenAmount,
      "takenAmount": takenAmount,
      "balance": balance,
      "installmentAmount": installmentAmount,
    });

    saveDiscountCustomers();
    update();
  }

  int getDiscountPercentage(String customerName, int amount) {
    int index = discount.indexWhere(
      (customer) => customer["name"] == customerName,
    );
    if (index != -1) {
      return discount[index]["discount"] ?? 0;
    }
    return 0;
  }

  void updateDiscountBalance(
    String name,
    bool isGiven,
    int amount,
    String description,
    int discountPercentage,
  ) {
    int index = discount.indexWhere((customer) => customer["name"] == name);
    if (index != -1) {
      // var customer = discount[index];
      var customer = Map<String, dynamic>.from(discount[index]);

      // Update Given or Taken Amount
      if (isGiven) {
        customer["givenAmount"] += amount;
      } else {
        customer["takenAmount"] += amount;
      }

      double discountAmount =
          (customer["givenAmount"] * discountPercentage) / 100;
      customer["balance"] =
          customer["takenAmount"] - customer["givenAmount"] + discountAmount;
      discount[index] = customer;

      saveDiscountCustomers();
      update(); // Notify UI
    }
  }

  void deleteDiscountCustomer(int index) {
    discount.removeAt(index);
    saveDiscountCustomers();
    if (selectedDiscountIndex.value == index) {
      selectedDiscountIndex.value = -1;
    }
    update();
  }

  void selectDiscountCustomer(int index) {
    selectedDiscountIndex.value = index;
  }

  void saveDiscountCustomers() {
    print("Saving discount list: ${discount.toList()}"); // Debug print
    storage.write('discount_list', discount);
  }

  void loadDiscountCustomers() {
    var storedDiscountCustomers = storage.read<List>('discount_list') ?? [];
    print("Loading stored data: $storedDiscountCustomers"); // Debug print
    if (storedDiscountCustomers.isNotEmpty) {
      discount.assignAll(
        storedDiscountCustomers
            .map((e) => Map<String, dynamic>.from(e))
            .toList(),
      );
      update();
    }
  }
}
