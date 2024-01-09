class UserModel {
  String email;
  String password;
  String name;
  String id;

//<editor-fold desc="Data Methods">
  UserModel({
    required this.email,
    required this.password,
    required this.name,
    required this.id,
  });

  UserModel copyWith({
    String? email,
    String? password,
    String? name,
    String? id,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'password': this.password,
      'name': this.name,
      'id': this.id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      password: map['password'] as String,
      name: map['name'] as String,
      id: map['id'] as String,
    );
  }

//</editor-fold>
}