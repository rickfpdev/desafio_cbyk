import 'package:cbyk_test/features/auth/domain/usecases/register_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUserUseCase registerUser;

  RegisterCubit(this.registerUser) : super(RegisterInitial());

  Future<void> register({
    required String name,
    required String cpf,
    required String password,
  }) async {
    emit(RegisterLoading());

    try {
      final user = await registerUser(
        name: name,
        cpf: cpf,
        password: password,
      );

      emit(RegisterSuccess(user));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
