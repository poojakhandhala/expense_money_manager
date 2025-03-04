class User {
  final int? id;
  final String? name;
  final String? mobile;
  final String? createdAt;
  final String? updatedAt;
  final dynamic deletedAt;

  User({
    this.id,
    this.name,
    this.mobile,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      mobile: json["mobile"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      deletedAt: json["deleted_at"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "mobile": mobile,
      "created_at": createdAt,
      "updated_at": updatedAt,
      "deleted_at": deletedAt,
    };
  }
}
