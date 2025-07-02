import 'package:cbyk_test/core/app/app_colors.dart';
import 'package:cbyk_test/features/home/domain/entities/home_state.dart';
import 'package:cbyk_test/features/home/presentation/widgets/contracted_header.dart';
import 'package:cbyk_test/features/home/presentation/widgets/drawer_widget.dart';
import 'package:cbyk_test/features/home/presentation/widgets/family_header.dart';
import 'package:cbyk_test/features/home/presentation/widgets/gradient_user_header.dart';
import 'package:cbyk_test/features/home/presentation/widgets/quote_header.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadHomeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: AppColors.colorPrimary,
        elevation: 0,
        foregroundColor: Colors.white,
        title: Builder(
          builder: (context) {
            final screenWidth = MediaQuery.of(context).size.width;
            final logoHeight = kIsWeb ? screenWidth * 0.035 : screenWidth * 0.1;

            return Image.asset('assets/images/tokiologo.png',
                height: logoHeight);
          },
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: SvgPicture.asset(
              'assets/svg/drawer_menu.svg',
              // ignore: deprecated_member_use
              color: AppColors.colorWhite,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [SvgPicture.asset('assets/svg/notification.svg')],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomeLoaded) {
            final user = state.user;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GradientUserHeader(userName: user),
                const Expanded(
                    child: SingleChildScrollView(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      QuoteHeader(),
                      FamilyHeader(),
                      ContractedHeader(),
                    ],
                  ),
                )),
              ],
            );
          }

          if (state is HomeError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
