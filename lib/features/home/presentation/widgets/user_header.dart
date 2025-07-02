import 'package:cbyk_test/core/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserHeader extends StatelessWidget {
  final String userName;

  const UserHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Olá!',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.grey,
                child: SvgPicture.asset('assets/svg/profile.svg'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: AppColors.colorWhite,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      'Minha conta',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xff29a385),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
