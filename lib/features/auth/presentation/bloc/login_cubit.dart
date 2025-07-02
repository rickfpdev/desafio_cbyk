import 'package:cbyk_test/features/auth/presentation/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String cpf, String password) async {
    emit(LoginLoading());

    await Future.delayed(const Duration(seconds: 2)); // Simulação

    if (cpf == '12345678900' && password == '123456') {
      emit(LoginSuccess());
    } else {
      emit(LoginFailure(error: 'CPF ou senha inválidos'));
    }
  }
}
