// // import 'package:get/get.dart';
// // import 'package:get_storage/get_storage.dart';
// //
// // class DiscountController extends GetxController {
// //   final storage = GetStorage();
// //   var discountList = <Map<String, dynamic>>[].obs;
// //   var selectedDiscountIndex = (-1).obs;
// //   @override
// //   void onInit() {
// //     super.onInit();
// //     loadDiscountCustomers();
// //   }
// //
// //   void addTransaction(Map<String, dynamic> transaction) {
// //     discountList.add(transaction);
// //     saveTransactions();
// //   }
// //
// //   void saveTransactions() {
// //     storage.write('borrowList', discountList);
// //   }
// //
// //   void loadDiscountCustomers() {
// //     var storedData = storage.read<List>('borrowList');
// //     if (storedData != null) {
// //       discountList.assignAll(storedData.cast<Map<String, dynamic>>());
// //     }
// //   }
// //
// //   void clearTransactions() {
// //     discountList.clear();
// //     storage.remove('borrowList');
// //   }
// // }
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
//
// class DiscountController extends GetxController {
//   final storage = GetStorage();
//   var discount = <Map<String, dynamic>>[].obs;
//   var selectedDiscountIndex = (-1).obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     loadDiscountCustomers();
//   }
//
//   // void addDiscountCustomer(
//   //   String name, {
//   //   // String amount,
//   //   int givenAmount = 0,
//   //   int takenAmount = 0,
//   // }) {
//   //   int balance = takenAmount - givenAmount;
//   //   discount.add({
//   //     "name": name,
//   //
//   //     "givenAmount": givenAmount,
//   //     "takenAmount": takenAmount,
//   //     "balance": balance,
//   //   });
//   //   saveDiscountCustomers();
//   // }
//   void addDiscountCustomer(
//     String name, {
//     int givenAmount = 0,
//     int takenAmount = 0,
//     String date = "",
//     String description = "",
//     String vyajDate = "",
//     int discountPercentage = 0,
//   }) {
//     int balance = takenAmount - givenAmount;
//     discount.add({
//       "name": name,
//       "date": date,
//       "description": description,
//       "vyajDate": vyajDate,
//       "discount": discountPercentage,
//       "givenAmount": givenAmount,
//       "takenAmount": takenAmount,
//       "balance": balance,
//     });
//
//     saveDiscountCustomers();
//   }
//
//   void deleteDiscountCustomer(int index) {
//     discount.removeAt(index);
//     saveDiscountCustomers();
//     if (selectedDiscountIndex.value == index) {
//       selectedDiscountIndex.value = -1;
//     }
//   }
//
//   void selectDiscountCustomer(int index) {
//     selectedDiscountIndex.value = index;
//   }
//
//   void saveDiscountCustomers() {
//     print("Saving discount list: ${discount.toList()}"); // Debug print
//     storage.write('discount_list', discount);
//   }
//
//   void loadDiscountCustomers() {
//     var storedDiscountCustomers = storage.read<List>('discount_list') ?? [];
//     print("Loading stored data: $storedDiscountCustomers"); // Debug print
//     if (storedDiscountCustomers.isNotEmpty) {
//       discount.assignAll(
//         storedDiscountCustomers
//             .map((e) => Map<String, dynamic>.from(e))
//             .toList(),
//       );
//     }
//   }
//
//   //
//   // void saveborrowCustomers() {
//   //   storage.write('customers', borrow);
//   // }
//   //
//   // void loadborrowCustomers() {
//   //   var storedCustomers = storage.read<List>('customers') ?? [];
//   //   if (storedCustomers != null) {
//   //     borrow.assignAll(
//   //       storedCustomers.map((e) => Map<String, dynamic>.from(e)).toList(),
//   //     );
//   //   }
//   // }
//   //
//   // void updateDiscountBalance(
//   //   String name,
//   //   bool isGiven,
//   //   int amount,
//   //   String description,
//   // ) {
//   //   int index = discount.indexWhere((customer) => customer["name"] == name);
//   //   if (index != -1) {
//   //     var customer = discount[index];
//   //     if (isGiven) {
//   //       customer["givenAmount"] += amount;
//   //     } else {
//   //       customer["takenAmount"] += amount;
//   //     }
//   //     customer["balance"] = customer["takenAmount"] - customer["givenAmount"];
//   //     // discount[index] = customer; // Update the list
//   //
//   //     // Print to check values
//   //     print("Updating balance for: $name");
//   //     print("Given Amount: ${customer["givenAmount"]}");
//   //     print("Taken Amount: ${customer["takenAmount"]}");
//   //     print("New Balance: ${customer["balance"]}");
//   //
//   //     // Ensure GetX detects the change
//   //     discount[index] = Map<String, dynamic>.from(customer);
//   //     saveDiscountCustomers();
//   //     update(); // Notify UI
//   //   }
//   // }
//   void updateDiscountBalance(
//     String name,
//     bool isGiven,
//     int amount,
//     String description,
//   ) {
//     int index = discount.indexWhere((customer) => customer["name"] == name);
//     if (index != -1) {
//       var customer = discount[index];
//
//       // Update Given or Taken Amount
//       if (isGiven) {
//         customer["givenAmount"] += amount;
//       } else {
//         customer["takenAmount"] += amount;
//       }
//
//       // Update Pending Balance
//       customer["balance"] = customer["takenAmount"] - customer["givenAmount"];
//
//       // Print values for debugging
//       print("Updating balance for: $name");
//       print("Given Amount: ${customer["givenAmount"]}");
//       print("Taken Amount: ${customer["takenAmount"]}");
//       print("New Balance: ${customer["balance"]}");
//
//       // Ensure GetX detects the change
//       customer["balance"] = customer["takenAmount"] - customer["givenAmount"];
//       discount[index] = customer;
//       saveDiscountCustomers();
//       update(); // Notify UI
//     }
//   }
// }
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
  }) {
    int balance = takenAmount - givenAmount;
    discount.add({
      "name": name,
      "date": date,
      "description": description,
      "vyajDate": vyajDate,
      "discount": discountPercentage,
      "givenAmount": givenAmount,
      "takenAmount": takenAmount,
      "balance": balance,
    });

    saveDiscountCustomers();
  }

  void deleteDiscountCustomer(int index) {
    if (index >= 0 && index < discount.length) {
      discount.removeAt(index);
      saveDiscountCustomers();
    }
    if (selectedDiscountIndex.value == index) {
      selectedDiscountIndex.value = -1;
    }
  }

  void selectDiscountCustomer(int index) {
    if (index >= 0 && index < discount.length) {
      selectedDiscountIndex.value = index;
    }
  }

  void updateDiscountBalance(
    String name,
    bool isGiven,
    int amount,
    String description,
  ) {
    int index = discount.indexWhere((customer) => customer["name"] == name);
    if (index != -1) {
      var customer = discount[index];

      // Update Given or Taken Amount
      customer["givenAmount"] += isGiven ? amount : 0;
      customer["takenAmount"] += !isGiven ? amount : 0;

      // Update Balance
      customer["balance"] = customer["takenAmount"] - customer["givenAmount"];

      print("Updating balance for: $name");
      print(
        "Given: ${customer["givenAmount"]}, Taken: ${customer["takenAmount"]}, Balance: ${customer["balance"]}",
      );

      // Ensure GetX detects the change
      discount[index] = Map<String, dynamic>.from(customer);
      saveDiscountCustomers();
      update(); // Notify UI
    }
  }

  void saveDiscountCustomers() {
    storage.write('discount_list', discount);
  }

  void loadDiscountCustomers() {
    var storedData = storage.read<List>('discount_list') ?? [];
    if (storedData.isNotEmpty) {
      discount.assignAll(
        storedData.map((e) => Map<String, dynamic>.from(e)).toList(),
      );
    }
  }
}
