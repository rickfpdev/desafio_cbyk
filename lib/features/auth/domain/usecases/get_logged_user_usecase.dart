import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class GetLoggedUserUseCase {
  final AuthRepository repository;

  GetLoggedUserUseCase(this.repository);

  Future<UserEntity> call() async {
    return await repository.getLoggedUser();
  }
}
