import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_sathi/src/core/constants/app_colors.dart';
import 'package:krishi_sathi/src/core/constants/app_enums.dart';
import 'package:krishi_sathi/src/core/functions/build_toast.dart';
import 'package:krishi_sathi/src/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class AudioRecord extends StatefulWidget {
  const AudioRecord({super.key});

  @override
  State<AudioRecord> createState() => _AudioRecordState();
}

class _AudioRecordState extends State<AudioRecord> {
  final AudioRecorder _record = AudioRecorder();
  bool _isRecording = false;
  Uint8List? _audioBytes;

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    await Permission.microphone.request();
    if (await Permission.microphone.isGranted) {
      print('Microphone permission granted');
    } else {
      print('Microphone permission denied');
    }
  }

  Future<void> _startRecording() async {
    buildToast(toastType: ToastType.success, msg: "Recording...");
    if (!_isRecording) {
      if (await _record.hasPermission()) {
        final tempDir = Directory.systemTemp;
        String tempFilePath = '${tempDir.path}/audio.m4a';
        await _record.start(const RecordConfig(), path: tempFilePath);
        setState(() {
          _isRecording = true;
        });
        print("Recording started.");
      } else {
        print('Permission denied for microphone.');
      }
    }
  }

  Future<void> _stopRecording() async {
    // buildToast(toastType: ToastType.error, msg: "Recording ");
    if (_isRecording) {
      final filePath = await _record.stop();
      setState(() {
        _isRecording = false;
      });

      if (filePath != null) {
        print("Recording stopped. File path: $filePath");
        final audioFile = File(filePath);
        _audioBytes = await audioFile.readAsBytes();

        if (_audioBytes != null) {
          print("Audio ready to be sent to API");
          context
              .read<ChatBloc>()
              .add(GetAudioTranscript(audioData: audioFile));
        }
      }
    }
  }

  Future<void> _cancelRecording() async {
    await _record.cancel();
    setState(() {
      _isRecording = false;
    });
    print("Recording canceled.");
  }

  @override
  void dispose() {
    super.dispose();
    _record.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatBloc, ChatState>(
      buildWhen: (previous, current) {
        return current is AudioTranscriptSuccess ||
            current is AudioTranscriptLoading;
      },
      listener: (context, state) {
        if (state is AudioTranscriptSuccess) {
          print('${state.audioTranscript} this is the audio ++++++++++++++++');
        }
        if (state is MessageLoadingFailed) {
          buildToast(
            toastType: ToastType.error,
            msg: state.message,
          );
        }
      },
      builder: (context, state) {
        if (state is AudioTranscriptLoading) {
          return const Center(
            child: CupertinoActivityIndicator(
              color: AppColors.white,
              animating: true,
            ),
          );
        }
        return LayoutBuilder(
          builder: (context, constraints) {
            double availableWidth = constraints.maxWidth;
            double rightPosition = availableWidth > 200 ? 84 : 20;

            return Positioned(
              bottom: 4,
              right: rightPosition,
              child: GestureDetector(
                onTap: _isRecording ? _stopRecording : _startRecording,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.frog),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    color: AppColors.midnight,
                  ),
                  child: _isRecording
                      ? const Icon(
                          Icons.mic,
                          color: AppColors.blue,
                        )
                      : const Icon(
                          Icons.mic_off,
                          color: AppColors.blue,
                        ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
