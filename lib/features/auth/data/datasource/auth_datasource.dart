import 'package:cbyk_test/features/auth/domain/entities/user_entity.dart';

abstract class AuthDataSource {
  Future<UserEntity> login(String cpf, String password);
  Future<UserEntity> register(String name, String cpf, String password);
  Future<UserEntity> getLoggedUser();
}