import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUserUseCase {
  final AuthRepository repository;

  RegisterUserUseCase(this.repository);

  Future<UserEntity> call({
    required String name,
    required String cpf,
    required String password,
  }) {
    return repository.register(name, cpf, password);
  }
}