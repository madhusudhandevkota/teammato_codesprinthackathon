import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_sathi/src/core/constants/app_assets.dart';
import 'package:krishi_sathi/src/core/constants/app_colors.dart';
import 'package:krishi_sathi/src/core/constants/custom_locale.dart';
import 'package:krishi_sathi/src/core/screen_args.dart/message_screen_args.dart';
import 'package:krishi_sathi/src/features/chat/presentation/widgets/additional_functions.dart';

class AskQuestion extends StatelessWidget {
  final FollowupScreenArgs followupScreenArgs;
  const AskQuestion({super.key, required this.followupScreenArgs});

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 180,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            margin: const EdgeInsets.symmetric(vertical: 17, horizontal: 52),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.midnight,
              border: Border.all(
                color: AppColors.foreground,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Text(
              currentLocale == CustomLocale.english
                  ? followupScreenArgs.question
                  : followupScreenArgs.question,
              style: const TextStyle(
                color: AppColors.white,
              ),
            ),
          ),
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
                  currentLocale == CustomLocale.english
                      ? followupScreenArgs.message.summaryEnglish
                      : followupScreenArgs.message.summaryNepali,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.white,
                        fontSize: 13,
                      ),
                ),
              ),
            ],
          ),
          AdditionalFunctions(
              summaryEnglish: followupScreenArgs.message.summaryEnglish,
              summaryNepali: followupScreenArgs.message.summaryNepali),
        ],
      ),
    );
  }
}
