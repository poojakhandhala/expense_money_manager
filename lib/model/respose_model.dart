abstract class ResponseDataObjectSerialization<T> {
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}

class ResponseDataObjectModel<T extends ResponseDataObjectSerialization> {
  ResponseDataObjectModel({
    this.data,
    this.message,
    this.status,
    // this.success,
    this.code,
  });

  factory ResponseDataObjectModel.fromJson(
    T model,
    Map<String, dynamic> json,
  ) => ResponseDataObjectModel(
    data:
        json["data"] == null
            ? null
            : model.fromJson(json["data"] as Map<String, dynamic>) as T,
    message: json["message"] == null ? null : json["message"] as String,
    status: json["status"] == null ? null : json["status"] as bool,
    // success: json["success"] == null ? null : json["success"] as bool,
    code: json["code"] == null ? null : json["code"] as int,
  );

  T? data;
  String? message;
  bool? status;
  // bool? success;
  int? code;

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "status": status,
    // "success": success,
    "code": code,
  };
}

class ResponseDataArrayModel<T extends ResponseDataObjectSerialization> {
  ResponseDataArrayModel({
    this.data,
    this.message,
    this.status,
    // this.success,
    this.code,
  });

  factory ResponseDataArrayModel.fromJson(T model, Map<String, dynamic> json) =>
      ResponseDataArrayModel(
        data:
            json["data"] == null
                ? null
                : List<T>.from(
                  (json["data"] as List<dynamic>).map(
                    (x) => model.fromJson(x as Map<String, dynamic>),
                  ),
                ),
        message: json["message"] == null ? null : json["message"] as String,
        status: json["status"] == null ? null : json["status"] as bool,
        // success: json["success"] == null ? null : json["success"] as bool,
        code: json["code"] == null ? null : json["code"] as int,
      );

  List<T>? data;
  String? message;
  bool? status;
  // bool? success;
  int? code;

  Map<String, dynamic> toJson() => {
    "data":
        data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
    "status": status,
    // "success": success,
    "code": code,
  };
}
