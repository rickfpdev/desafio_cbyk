import 'package:cbyk_test/core/app/app_colors.dart';
import 'package:cbyk_test/features/auth/data/datasource/firebase_auth_datasource.dart';
import 'package:cbyk_test/features/auth/data/repositories/login_repository_impl.dart';
import 'package:cbyk_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cbyk_test/features/webview/presentation/pages/webview_page.dart';
import 'package:cbyk_test/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/register_usecase.dart';
import 'features/auth/domain/usecases/get_logged_user_usecase.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/auth/presentation/pages/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase com as opções do projeto
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Instancia a camada data
  final authDataSource = FirebaseAuthDataSource();
  final authRepository = AuthRepositoryImpl(authDataSource);

  // Use cases
  final loginUseCase = LoginUseCase(authRepository);
  final registerUseCase = RegisterUserUseCase(authRepository);
  final getLoggedUserUseCase = GetLoggedUserUseCase(authRepository);

  runApp(MyApp(
    loginUseCase: loginUseCase,
    registerUseCase: registerUseCase,
    getLoggedUserUseCase: getLoggedUserUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final LoginUseCase loginUseCase;
  final RegisterUserUseCase registerUseCase;
  final GetLoggedUserUseCase getLoggedUserUseCase;

  const MyApp({
    super.key,
    required this.loginUseCase,
    required this.registerUseCase,
    required this.getLoggedUserUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(loginUseCase, registerUseCase),
        ),
        BlocProvider(
          create: (_) => HomeBloc(getLoggedUserUseCase),
        ),
      ],
      child: MaterialApp(
        title: 'cbyk test',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.colorPrimary, // opcional
          textTheme: ThemeData.dark().textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
        ),
        home: const AuthPage(),
        onGenerateRoute: (settings) {
          if (settings.name == '/webview') {
            final url = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => WebViewPage(url: url),
            );
          }
          return null;
        },
        routes: {
          '/home': (_) => const HomePage(),
          '/login': (_) => const AuthPage(),
        },
      ),
    );
  }
}
