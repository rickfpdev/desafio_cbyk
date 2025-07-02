import 'package:cbyk_test/core/app/app_colors.dart';
import 'package:cbyk_test/core/constants/home_menu_items.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class QuoteHeader extends StatelessWidget {
  const QuoteHeader({super.key});

  void _handleTap(String label, String? url, BuildContext context) {
    if (label.toLowerCase() == 'automóvel') {
      if (kIsWeb) {
        openUrl(url!);
      } else {
        Navigator.pushNamed(context, '/webview', arguments: url);
      }
    }
  }

  void openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cotar e Contratar',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: homeMenuItems.length,
              itemBuilder: (context, index) {
                final item = homeMenuItems[index];
                return GestureDetector(
                  onTap: () => _handleTap(item.label, item.url, context),
                  child: Container(
                    width: kIsWeb
                        ? MediaQuery.of(context).size.width / 12
                        : MediaQuery.of(context).size.width / 3.7,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: AppColors.colorSecondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          item.iconAsset,
                          width: 32,
                          // ignore: deprecated_member_use
                        ),
                        const SizedBox(height: 8),
                        Text(item.label,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
