import 'package:flutter/material.dart';
import 'package:krishi_sathi/src/core/constants/app_colors.dart';

class CustomRoundedButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final double bottomPadding;
  final double buttonWidth;
  final double buttonHeight;
  final double radius;

  const CustomRoundedButton({
    super.key,
    required this.title,
    this.onPressed,
    this.bottomPadding = 16,
    this.buttonWidth = 145,
    this.buttonHeight = 10,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(bottom: bottomPadding),
      child: Material(
        color: AppColors.green,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        elevation: 4,
        child: InkWell(
          onTap: onPressed,
          splashColor: AppColors.steel,
          borderRadius: const BorderRadius.all(Radius.circular(24)),
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: buttonHeight, horizontal: buttonWidth),
            constraints: BoxConstraints(
              minWidth: buttonWidth,
              minHeight: buttonHeight + 20,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                maxLines: 2,
                style: _theme.textTheme.titleMedium!
                    .copyWith(fontSize: null, color: AppColors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
