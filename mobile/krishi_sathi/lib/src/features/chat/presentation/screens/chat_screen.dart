import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_sathi/src/core/constants/app_assets.dart';
import 'package:krishi_sathi/src/core/constants/app_colors.dart';
import 'package:krishi_sathi/src/core/constants/app_enums.dart';
import 'package:krishi_sathi/src/core/constants/app_strings.dart';
import 'package:krishi_sathi/src/core/constants/custom_locale.dart';
import 'package:krishi_sathi/src/core/functions/build_toast.dart';
import 'package:krishi_sathi/src/core/screen_args.dart/message_screen_args.dart';
import 'package:krishi_sathi/src/core/widgets/input_field/description_field.dart';
import 'package:krishi_sathi/src/features/chat/data/dto/ask_bot_request_dto.dart';
import 'package:krishi_sathi/src/features/chat/domain/entities/message.dart';
import 'package:krishi_sathi/src/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:krishi_sathi/src/features/chat/presentation/widgets/additional_functions.dart';
import 'package:krishi_sathi/src/features/chat/presentation/widgets/ask_question.dart';
import 'package:krishi_sathi/src/features/chat/presentation/widgets/audio_record.dart';
import 'package:krishi_sathi/src/features/chat/presentation/widgets/suggested_questions.dart';
import 'package:krishi_sathi/src/features/chat/presentation/widgets/summary.dart';

class ChatScreen extends StatefulWidget {
  final MessageScreenArgs messageScreenArgs;
  const ChatScreen({super.key, required this.messageScreenArgs});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  MessageEntity? _latestFollowup;
  late final TextEditingController _descriptionController;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<MessageEntity> _followup = [];
  final List<String> _questionFollowupEnglish = [];
  final List<String> _questionFollowupNepali = [];
  String? _selectedQuestion;
  String? _selectedQuestionNepali;

  void _handleQuestionSelected(String questionEnglish, String questionNepali) {
    setState(() {
      _selectedQuestion = questionEnglish;
      _selectedQuestionNepali = questionNepali;
    });
  }

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;
    String text = currentLocale == CustomLocale.english
        ? widget.messageScreenArgs.message.summaryEnglish
        : widget.messageScreenArgs.message.summaryNepali;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: BlocConsumer<ChatBloc, ChatState>(
          buildWhen: (previous, current) {
            return current is FollowUpSuccess || current is FollowUpLoading;
          },
          listener: (context, state) {
            if (state is FollowUpFailed) {
              buildToast(toastType: ToastType.error, msg: state.message);
            }
            if (state is FollowUpSuccess) {
              _followup.add(state.followup);
              _latestFollowup = state.followup;
              if (_selectedQuestion != null) {
                _questionFollowupEnglish.add(_selectedQuestion!);
                _questionFollowupNepali.add(_selectedQuestionNepali!);
              }
              _scrollToBottom();
            }
            if (state is AudioTranscriptSuccess) {
              _descriptionController.text = state.audioTranscript;
            }
          },
          builder: (context, state) {
            if (state is FollowUpLoading) {
              _descriptionController.clear();
              FocusScope.of(context).unfocus();
              return const Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.white,
                  animating: true,
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 30),
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
                          Summary(
                            messageScreenArgs: widget.messageScreenArgs,
                          ),
                          AdditionalFunctions(
                            summaryEnglish:
                                widget.messageScreenArgs.message.summaryEnglish,
                            summaryNepali:
                                widget.messageScreenArgs.message.summaryNepali,
                          ),
                          const SizedBox(height: 20),
                          if (_followup.isNotEmpty)
                            ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return AskQuestion(
                                    followupScreenArgs: FollowupScreenArgs(
                                        question: currentLocale ==
                                                CustomLocale.english
                                            ? _questionFollowupEnglish[index]
                                            : _questionFollowupNepali[index],
                                        message: _followup[index]));
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 10),
                              itemCount: _followup.length,
                            ),
                          Container(
                            margin: const EdgeInsets.only(top: 20, bottom: 10),
                            child: Center(
                              child: Text(
                                AppStrings.followUpQuestions.tr(),
                                style: const TextStyle(
                                  color: AppColors.gray,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          SuggestedQuestions(
                            screenArgs: SuggestedQuestionScreenArgs(
                              suggestedQuestionsEnglish: _latestFollowup != null
                                  ? _latestFollowup!.followupQuestionsEnglish
                                  : widget.messageScreenArgs.message
                                      .followupQuestionsEnglish,
                              suggestedQuestionsNepali: _latestFollowup != null
                                  ? _latestFollowup!.followupQuestionsNepali
                                  : widget.messageScreenArgs.message
                                      .followupQuestionsNepali,
                              insect: widget.messageScreenArgs.message.insect,
                            ),
                            onQuestionSelected: _handleQuestionSelected,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: DescriptionField(
                            controller: _descriptionController,
                            title:
                                "${AppStrings.typeYourQuestion.tr()} ...........",
                            onPressed: () {
                              String inputText = _descriptionController.text;
                              setState(() {
                                _selectedQuestion = inputText;
                                _selectedQuestionNepali = inputText;
                              });
                              AskBotRequestDto dto = AskBotRequestDto(
                                text: _descriptionController.text,
                                insect: widget.messageScreenArgs.message.insect,
                              );
                              context
                                  .read<ChatBloc>()
                                  .add(GetFollowUp(dto: dto));
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        const AudioRecord(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
