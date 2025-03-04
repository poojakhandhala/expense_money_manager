import 'package:expense_money_manager/model/respose_model.dart';
import 'package:expense_money_manager/model/user_login.dart';

class LoginResponse extends ResponseDataObjectSerialization<LoginResponse> {
  final bool? status;
  final String? message;
  final User? user;
  final String? token;

  LoginResponse({this.status, this.message, this.user, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json["status"],
      message: json["message"],
      user:
          json["data"] != null && json["data"]["user"] != null
              ? User.fromJson(json["data"]["user"])
              : null,
      token: json["data"]?["token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "data": {"user": user?.toJson(), "token": token},
    };
  }

  @override
  LoginResponse fromJson(Map<String, dynamic> json) {
    return LoginResponse.fromJson(json);
  }
}
