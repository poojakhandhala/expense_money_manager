import 'package:expense_money_manager/model/respose_model.dart';

class CustomerModel extends ResponseDataObjectSerialization<CustomerModel> {
  final int id;
  final String name;
  final String phone;

  CustomerModel({required this.id, required this.name, required this.phone});

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'phone': phone};
  }

  @override
  CustomerModel fromJson(Map<String, dynamic> json) {
    return CustomerModel.fromJson(json);
  }
}
