abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String cpf;
  final String password;

  LoginRequested({required this.cpf, required this.password});
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String cpf;
  final String password;

  RegisterRequested({
    required this.name,
    required this.cpf,
    required this.password,
  });
}
