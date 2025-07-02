// auth_page.dart
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cbyk_test/core/app/app_colors.dart';
import 'package:cbyk_test/core/validators/field_validators.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final cpfController = TextEditingController();
  final passwordController = TextEditingController();

  bool isRememberChecked = false;
  bool isLogin = true;

  @override
  void dispose() {
    nameController.dispose();
    cpfController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      label: Center(child: Text(label)),
      labelStyle: const TextStyle(color: AppColors.colorWhite),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(color: AppColors.colorWhite),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(color: AppColors.colorWhite),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(color: AppColors.colorWhite),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
    );
  }

  void _submit() {
    final name = nameController.text.trim();
    final rawCpf =
        cpfController.text.replaceAll(RegExp(r'\D'), ''); // remove máscara
    final password = passwordController.text.trim();

    if (_formKey.currentState?.validate() ?? false) {
      if (isLogin) {
        context
            .read<AuthBloc>()
            .add(LoginRequested(cpf: rawCpf, password: password));
      } else {
        context.read<AuthBloc>().add(
            RegisterRequested(name: name, cpf: rawCpf, password: password));
      }
    }
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 40.0, vertical: kIsWeb ? 40.0 : 70.0),
        child: Column(
          crossAxisAlignment:
              kIsWeb ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/tokiologo.png',
                width: MediaQuery.of(context).size.width * 0.3),
            const SizedBox(height: 15),
            const Text(
              'Bem vindo!',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Aqui você gerencia seus seguros e de seus familiares em poucos cliques!',
              style: theme.textTheme.titleSmall
                  ?.copyWith(color: AppColors.colorWhite),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.colorPrimary,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => isLogin = true),
                  child: Text(
                    'Entrar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isLogin ? AppColors.appGreen : Colors.grey,
                      decoration: isLogin ? TextDecoration.underline : null,
                      decorationColor: AppColors.appGreen,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () => setState(() => isLogin = false),
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: !isLogin ? AppColors.appGreen : Colors.grey,
                      decoration: !isLogin ? TextDecoration.underline : null,
                      decorationColor: AppColors.appGreen,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (!isLogin) ...[
              TextField(
                controller: nameController,
                decoration: _inputDecoration('Nome'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
            ],
            TextFormField(
              controller: cpfController,
              decoration: _inputDecoration('CPF'),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CpfInputFormatter(),
              ],
              validator: (value) {
                if (!FieldValidators.isValidCPF(value!)) return 'CPF inválido';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: _inputDecoration('Senha'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            if (isLogin)
              Row(
                children: [
                  Checkbox(
                    value: isRememberChecked,
                    onChanged: (bool? value) =>
                        setState(() => isRememberChecked = value ?? false),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    checkColor: AppColors.colorWhite,
                    activeColor: AppColors.appGreen,
                  ),
                  const Text("Lembrar sempre"),
                  const Spacer(),
                  const Text(
                    "Esqueceu a senha?",
                    style: TextStyle(color: AppColors.appGreen),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _submit,
              child: Center(
                child: Container(
                  width: isLogin ? 56 : MediaQuery.of(context).size.width * 0.3,
                  height:
                      isLogin ? 56 : MediaQuery.of(context).size.height * 0.04,
                  decoration: BoxDecoration(
                    shape: isLogin ? BoxShape.circle : BoxShape.rectangle,
                    borderRadius: isLogin ? null : BorderRadius.circular(24),
                    gradient: AppColors.primaryGradient,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 3))
                    ],
                  ),
                  child: Center(
                    child: isLogin
                        ? const Icon(Icons.arrow_forward,
                            color: AppColors.colorWhite)
                        : const Text('Registrar',
                            style: TextStyle(color: AppColors.colorWhite)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget socialHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Text('Acesse através das redes sociais',
              style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: deprecated_member_use
              SvgPicture.asset(
                'assets/svg/google.svg',
                width: 30,
                color: AppColors.colorWhite,
              ),
              const SizedBox(width: 20),
              SvgPicture.asset(
                'assets/svg/facebook.svg',
                width: 30,
                color: AppColors.colorWhite,
              ),

              const SizedBox(width: 20),
              SvgPicture.asset('assets/svg/twitter.svg',
                  width: 30, color: AppColors.colorWhite),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // evita o movimento da tela
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is AuthAuthenticated) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Form(
            key: _formKey,
            child: Stack(
              children: [
                // Header fixo
                _buildHeader(context),
            
                // Formulário rola sozinho
                Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _buildFormCard(context),
                  ),
                ),
            
                // Social fixo no rodapé
                Positioned(
                  bottom: 16,
                  left: 0,
                  right: 0,
                  child: socialHeader(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
