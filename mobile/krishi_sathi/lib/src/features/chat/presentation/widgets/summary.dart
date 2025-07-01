import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_sathi/src/core/constants/app_assets.dart';
import 'package:krishi_sathi/src/core/constants/app_colors.dart';
import 'package:krishi_sathi/src/core/constants/custom_locale.dart';
import 'package:krishi_sathi/src/core/screen_args.dart/message_screen_args.dart';

class Summary extends StatelessWidget {
  final MessageScreenArgs messageScreenArgs;
  const Summary({super.key, required this.messageScreenArgs});

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;
    String text = currentLocale == CustomLocale.english
        ? messageScreenArgs.message.summaryEnglish
        : messageScreenArgs.message.summaryNepali;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 54),
          height: 200,
          child: Image.file(
            messageScreenArgs.media,
          ),
        ),
        const SizedBox(height: 18),
        Row(
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
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.white,
                      fontSize: 13,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
