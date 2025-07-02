import 'package:cbyk_test/features/auth/domain/repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call(String cpf, String password) {
    return repository.login(cpf, password);
  }
}
