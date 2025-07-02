import 'package:cbyk_test/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String id;      
  final String username; 

  UserModel({
    required this.id,
    required this.username,
    required String uid,
    required String name,
    required String cpf,
    required String email,
  }) : super(
          uid: uid,
          name: name,
          cpf: cpf,
          email: email,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      cpf: json['cpf'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'uid': uid,
      'name': name,
      'cpf': cpf,
      'email': email,
    };
  }
}
