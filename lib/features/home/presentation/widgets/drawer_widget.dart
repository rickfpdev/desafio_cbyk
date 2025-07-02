import 'package:cbyk_test/core/app/app_colors.dart';
import 'package:cbyk_test/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:cbyk_test/features/auth/presentation/bloc/auth_state.dart';
import 'package:cbyk_test/features/home/presentation/widgets/user_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.colorPrimary,
      width: kIsWeb
          ? MediaQuery.of(context).size.width * 0.2
          : MediaQuery.of(context).size.width * 0.7,
      height: double.infinity,
      child: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            String? name;
            if (state is AuthAuthenticated) {
              name = state.user.name;
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  UserHeader(userName: name!),
                  buildItem(
                    'Home/Seguro',
                    'assets/svg/config.svg',
                  ),
                  buildItem(
                    'Minhas Contratações',
                    'assets/svg/config.svg',
                  ),
                  buildItem(
                    'Meus Sinistros',
                    'assets/svg/config.svg',
                  ),
                  buildItem(
                    'Minha Família',
                    'assets/svg/config.svg',
                  ),
                  buildItem(
                    'Meus Bens',
                    'assets/svg/config.svg',
                  ),
                  buildItem(
                    'Pagamentos',
                    'assets/svg/config.svg',
                  ),
                  buildItem(
                    'Coberturas',
                    'assets/svg/config.svg',
                  ),
                  buildItem(
                    'Validar Boleto',
                    'assets/svg/config.svg',
                  ),
                  buildItem(
                    'Telefones Importantes',
                    'assets/svg/config.svg',
                  ),
                  buildItem(
                    'Configurações',
                    'assets/svg/config.svg',
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: GestureDetector(
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login', (route) => false);
                        },
                        child: const Text('Sair')),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  buildItem(String title, String asset, {Function? onTap}) {
    return Container(
      decoration: const BoxDecoration(
          // border: Border(
          //   bottom: BorderSide(color: colorGrey2),
          // ),
          ),
      child: ListTile(
        onTap: () async {
          if (onTap != null) {
            onTap();
          }
        },
        leading: SvgPicture.asset(
          asset,
          // ignore: deprecated_member_use
          color: AppColors.appGreen,
          width: 25,
        ),
        title: Text(title),
      ),
    );
  }
}
