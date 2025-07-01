import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart'; // Ensure the correct package is imported
import 'package:krishi_sathi/src/config/container_injector.dart';
import 'package:krishi_sathi/src/core/constants/app_assets.dart';
import 'package:krishi_sathi/src/core/constants/app_colors.dart';
import 'package:krishi_sathi/src/core/constants/app_enums.dart';
import 'package:krishi_sathi/src/core/constants/custom_locale.dart';
import 'package:krishi_sathi/src/core/functions/build_toast.dart';
import 'package:krishi_sathi/src/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:path_provider/path_provider.dart';

class AdditionalFunctions extends StatefulWidget {
  final String summaryEnglish;
  final String summaryNepali;
  const AdditionalFunctions(
      {super.key, required this.summaryEnglish, required this.summaryNepali});

  @override
  State<AdditionalFunctions> createState() => _AdditionalFunctionsState();
}

class _AdditionalFunctionsState extends State<AdditionalFunctions> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Uint8List? _audioBytes;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Locale currentLocale = context.locale;
    String text = currentLocale == CustomLocale.english
        ? widget.summaryEnglish
        : widget.summaryNepali;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        BlocProvider(
          create: (context) => sl<ChatBloc>()..add(GetAudio(text: text)),
          child: BlocListener<ChatBloc, ChatState>(
            listener: (context, state) {
              if (state is AudioLoadingSuccess) {
                _audioBytes = Uint8List.fromList(state.audioBytes);
              }
              if (state is MessageLoadingFailed) {
                buildToast(
                  toastType: ToastType.error,
                  msg: state.message,
                );
              }
            },
            child: GestureDetector(
              onTap: () async {
                print("Voice Test : $text");
                context.read<ChatBloc>().add(GetAudio(text: text));
                if (_audioBytes != null) {
                  try {
                    final tempDir = await getTemporaryDirectory();
                    final filePath = '${tempDir.path}/temp_audio.wav';

                    File file = File(filePath);
                    await file.writeAsBytes(_audioBytes!);
                    await _audioPlayer.setFilePath(filePath);
                    await _audioPlayer.play();
                  } catch (e) {
                    print("Error playing audio: $e");
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: AppColors.foreground,
                    width: 1.5,
                  ),
                ),
                child: Image.asset(
                  AppIcons.speaker,
                  height: 20.0,
                  width: 20.0,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 11),
        GestureDetector(
          onTap: () {
            setState(() {
              Locale newLocale = context.locale.languageCode == 'en'
                  ? CustomLocale.nepali
                  : CustomLocale.english;
              context.setLocale(newLocale);
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColors.midnight,
              border: Border.all(
                color: AppColors.foreground,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
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
        const SizedBox(width: 6),
      ],
    );
  }
}
