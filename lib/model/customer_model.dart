import 'package:expense_money_manager/model/respose_model.dart';

class CustomerModel extends ResponseDataObjectSerialization<CustomerModel> {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? address;
  final int? userId;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  CustomerModel({
    this.email,
    this.address,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.id,
    this.name,
    this.phone,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] ?? 0,
      // id: json["id"].toString(),
      name: json['name'] ?? '',
      phone: json['mobile'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      userId: json['user_id'] ?? 0,
      // userId: json["user_id"].toString(),
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      deletedAt: json["deleted_at"],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobile': phone,
      "email": "email",
      "address": "address",
      "user_id": userId,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "deleted_at": deletedAt,
    };
  }

  @override
  CustomerModel fromJson(Map<String, dynamic> json) {
    return CustomerModel.fromJson(json);
  }
}
