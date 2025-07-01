import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_sathi/src/core/constants/app_assets.dart';
import 'package:krishi_sathi/src/core/constants/app_colors.dart';
import 'package:krishi_sathi/src/core/constants/custom_locale.dart';
import 'package:krishi_sathi/src/core/screen_args.dart/message_screen_args.dart';
import 'package:krishi_sathi/src/features/chat/data/dto/ask_bot_request_dto.dart';
import 'package:krishi_sathi/src/features/chat/presentation/bloc/chat_bloc.dart';

typedef OnQuestionSelected = void Function(
    String englishQuestion, String nepaliQuestion);

class SuggestedQuestions extends StatelessWidget {
  final SuggestedQuestionScreenArgs screenArgs;
  final OnQuestionSelected onQuestionSelected;

  const SuggestedQuestions({
    super.key,
    required this.screenArgs,
    required this.onQuestionSelected,
  });

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
      ),
      itemCount: screenArgs.suggestedQuestionsEnglish.length + 1,
      itemBuilder: (context, index) {
        bool isLastItem = index >= screenArgs.suggestedQuestionsEnglish.length;
        return isLastItem
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                margin: const EdgeInsets.symmetric(vertical: 17, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.midnight,
                  border: Border.all(
                    color: AppColors.foreground,
                    width: 1.5,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.graphite,
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      AppIcons.question,
                      height: 25.0,
                      width: 25.0,
                      color: AppColors.white,
                    ),
                    const SizedBox(width: 5),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Ask',
                            style: TextStyle(
                              color: AppColors.gray,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: ' KrishiSathi',
                            style: TextStyle(
                              color: AppColors.frog,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : GestureDetector(
                onTap: () {
                  String selectedQuestion =
                      screenArgs.suggestedQuestionsEnglish[index];
                  onQuestionSelected(selectedQuestion,
                      screenArgs.suggestedQuestionsNepali[index]);

                  AskBotRequestDto dto = AskBotRequestDto(
                    text: selectedQuestion,
                    insect: screenArgs.insect,
                  );
                  context.read<ChatBloc>().add(GetFollowUp(dto: dto));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                  margin:
                      const EdgeInsets.symmetric(vertical: 17, horizontal: 5),
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
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    currentLocale == CustomLocale.english
                        ? screenArgs.suggestedQuestionsEnglish[index]
                        : screenArgs.suggestedQuestionsNepali[index],
                    style: const TextStyle(color: AppColors.anchor),
                  ),
                ),
              );
      },
    );
  }
}
