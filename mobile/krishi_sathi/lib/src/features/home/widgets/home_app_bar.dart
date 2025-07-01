import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_sathi/src/core/constants/app_assets.dart';
import 'package:krishi_sathi/src/core/constants/app_colors.dart';
import 'package:krishi_sathi/src/core/constants/custom_locale.dart';

class HomeAppBar extends StatelessWidget {
  final VoidCallback onLocaleChange;

  const HomeAppBar({super.key, required this.onLocaleChange});

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 70,
              child: Image.asset(
                AppImages.appLogo,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: onLocaleChange, 
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 3),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColors.midnight,
              border: Border.all(color: AppColors.foreground, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                currentLocale == CustomLocale.english ? 'EN' : 'NP',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.charcoal,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
