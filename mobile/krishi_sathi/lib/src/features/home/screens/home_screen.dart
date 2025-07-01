import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_sathi/src/config/app_routes/app_route.dart';
import 'package:krishi_sathi/src/core/constants/app_colors.dart';
import 'package:krishi_sathi/src/core/constants/app_strings.dart';
import 'package:krishi_sathi/src/core/constants/custom_locale.dart';
import 'package:krishi_sathi/src/core/widgets/button/custom_rounded_button.dart';
import 'package:krishi_sathi/src/features/home/widgets/home_app_bar.dart';
import 'package:krishi_sathi/src/features/home/widgets/home_carousel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _toggleLocale() {
    Locale newLocale = context.locale.languageCode == 'en'
        ? CustomLocale.nepali
        : CustomLocale.english;
    context.setLocale(newLocale);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeAppBar(
              onLocaleChange: _toggleLocale,
            ),
            const HomeCarousel(),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomRoundedButton(
                title: AppStrings.con.tr(),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.mediaUpload,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.cursed,
        child: const Icon(
          Icons.mic,
          color: AppColors.white,
        ),
      ),
    );
  }
}
