import 'dart:async';

import 'package:flutter/material.dart';
import 'package:krishi_sathi/src/config/app_routes/app_route.dart';
import 'package:krishi_sathi/src/core/constants/app_assets.dart';
import 'package:krishi_sathi/src/core/constants/app_constants.dart';
import 'package:krishi_sathi/src/core/constants/media_query_values.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: AppConstants.animationTime),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();

    _timer = Timer(
        const Duration(milliseconds: AppConstants.navigateTime),
        () => Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.home,
              (route) => false,
            ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.width,
        height: context.height,
        margin: const EdgeInsets.only(bottom: 50),
        child: FadeTransition(
          opacity: _animation,
          child: Stack(
            children: [
              _buildSplashImage(),
            ],
          ),
        ),
      ),
    );
  }

  Align _buildSplashImage() {
    return const Align(
      alignment: Alignment.center,
      child: Image(
        width: 100,
        height: 100,
        fit: BoxFit.contain,
        image: AssetImage(AppImages.appLogo),
      ),
    );
  }
}
