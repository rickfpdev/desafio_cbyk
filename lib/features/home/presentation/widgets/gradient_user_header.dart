import 'package:cbyk_test/core/app/app_colors.dart';
import 'package:cbyk_test/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GradientUserHeader extends StatelessWidget {
  final UserEntity userName;
  const GradientUserHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.grey,
                child: SvgPicture.asset('assets/svg/profile.svg'),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bem-vindo',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: const Color(0xffe3e3e2),
                        ),
                  ),
                  Text(
                    userName.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColors.colorWhite,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
