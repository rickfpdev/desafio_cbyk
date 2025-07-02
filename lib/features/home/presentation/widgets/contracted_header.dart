import 'package:cbyk_test/core/app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContractedHeader extends StatelessWidget {
  const ContractedHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contratados',
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
                    child: SvgPicture.asset(
                  'assets/svg/no-insurance.svg', width: 50,
                  // ignore: deprecated_member_use
                  color: AppColors.colorWhite,
                )),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                  child: Text('Você ainda não possui seguros contratados.'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
