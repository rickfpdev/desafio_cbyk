import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String cpf, String password);
  Future<UserEntity> register(String name, String cpf, String password);
  Future<UserEntity> getLoggedUser();
}