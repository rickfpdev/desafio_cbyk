import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUserUseCase registerUseCase;

  AuthBloc(this.loginUseCase, this.registerUseCase) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await loginUseCase(event.cpf, event.password);
        emit(AuthAuthenticated(user));
      } catch (e) {
        emit(AuthError('Senha inválida'));
      }
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await registerUseCase.call(
          name: event.name,
          cpf: event.cpf,
          password: event.password,
        );

        emit(AuthAuthenticated(user));
      } catch (e) {
        emit(AuthError('Já existe um usuário com essas credenciais, favor realizar login.'));
      }
    });
  }
}
