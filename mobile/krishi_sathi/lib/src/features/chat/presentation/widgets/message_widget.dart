import 'package:flutter/material.dart';
import 'package:krishi_sathi/src/core/constants/app_assets.dart';
import 'package:krishi_sathi/src/core/constants/app_colors.dart';
import 'package:krishi_sathi/src/core/constants/app_strings.dart';

class MessageWidget extends StatelessWidget {
  final Function()? onPressed;
  const MessageWidget(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.white,
          radius: 22,
          child: ClipOval(
            child: Image.asset(
              AppImages.profile,
              width: 112,
              height: 112,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            AppStrings.message,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColors.charcoal, fontSize: 13),
            maxLines: 7,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}
