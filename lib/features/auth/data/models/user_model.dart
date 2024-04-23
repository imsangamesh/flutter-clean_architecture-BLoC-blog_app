import 'package:blog_app/core/services/typedefs.dart';
import 'package:blog_app/features/auth/domain/entity/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
  });

  factory UserModel.fromMap(DataMap map) => UserModel(
        id: map['id'] as String,
        email: map['email'] as String,
        name: map['name'] as String,
      );

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
  }) =>
      UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.name,
      );

  DataMap toMap() => {
        'id': id,
        'email': email,
        'name': name,
      };

  @override
  String toString() => 'UserModel(id: $id, email: $email, name: $name)';
}
