import 'package:cbyk_test/core/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FamilyHeader extends StatelessWidget {
  const FamilyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Minha Família',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: AppColors.colorSecondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: SvgPicture.asset('assets/svg/add.svg',
                        // ignore: deprecated_member_use
                        color: AppColors.colorWhite,
                        width: 50)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                  child: Text(
                    'Adicione aqui membros da sua família e compartilhe os seguros com eles.',
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
