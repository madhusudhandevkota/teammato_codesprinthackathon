import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_intro/flutter_carousel_intro.dart';
import 'package:flutter_carousel_intro/slider_item_model.dart';
import 'package:flutter_carousel_intro/utils/enums.dart';
import 'package:krishi_sathi/src/core/constants/app_assets.dart';
import 'package:krishi_sathi/src/core/constants/app_colors.dart';
import 'package:krishi_sathi/src/core/constants/app_strings.dart';


class HomeCarousel extends StatelessWidget {
  const HomeCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final double carouselHeight = MediaQuery.of(context).size.height * 0.6;
    return SizedBox(
      height: carouselHeight,
      child: FlutterCarouselIntro(
        animatedRotateX: false,
        animatedRotateZ: false,
        scale: true,
        autoPlay: true,
        animatedOpacity: false,
        autoPlaySlideDuration: const Duration(seconds: 2),
        autoPlaySlideDurationTransition: const Duration(milliseconds: 1100),
        primaryColor: AppColors.green,
        secondaryColor: AppColors.white,
        scrollDirection: Axis.horizontal,
        indicatorAlign: IndicatorAlign.bottom,
        indicatorEffect: IndicatorEffects.swap,
        showIndicators: true,
        slides: [
          SliderItem(
            title: '',
            subtitle: const SizedBox.shrink(),
            widget: _buildSlideContent(
              'Step 1',
              AppImages.card1,
              AppStrings.card1.tr(),
            ),
          ),
          SliderItem(
            title: '',
            subtitle: const SizedBox.shrink(),
            widget: _buildSlideContent(
              'Step 2',
              AppImages.appLogo,
              AppStrings.card1.tr(),
            ),
          ),
          SliderItem(
            title: '',
            subtitle: const SizedBox.shrink(),
            widget: _buildSlideContent(
              'Step 3',
              AppImages.appLogo,
              AppStrings.card1.tr(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlideContent(String step, String imagePath, String description) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(22),
        ),
      ),
      width: 300,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.blackWith40Opacity,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(22),
                  topRight: Radius.circular(22),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Text(
                  step,
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.whiteWith40Opacity,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 180,
              child: Center(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  letterSpacing: 0,
                  color: AppColors.shadow,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
