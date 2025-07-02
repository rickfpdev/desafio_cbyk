import 'package:cbyk_test/features/auth/data/datasource/auth_datasource.dart';
import 'package:cbyk_test/features/auth/domain/repositories/auth_repository.dart';
import '../../domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<UserEntity> login(String cpf, String password) {
    return dataSource.login(cpf, password);
  }

  @override
  Future<UserEntity> register(String name, String cpf, String password) {
    return dataSource.register(name, cpf, password);
  }

  @override
  Future<UserEntity> getLoggedUser() {
    return dataSource.getLoggedUser();
  }
}
