import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:krishi_sathi/src/core/constants/app_colors.dart';

class MediaUploadCamera extends StatefulWidget {
  final void Function(File) onMediaCaptured;

  const MediaUploadCamera({super.key, required this.onMediaCaptured});

  @override
  _MediaUploadCameraState createState() => _MediaUploadCameraState();
}

class _MediaUploadCameraState extends State<MediaUploadCamera> {
  late CameraController _cameraController;
  Future<void>? _initializeControllerFuture;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      _cameraController = CameraController(
        firstCamera,
        ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      _initializeControllerFuture = _cameraController.initialize();
      await _initializeControllerFuture;
      if (mounted) setState(() {});
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  Future<File?> _convertToJpeg(File file) async {
    try {
      // Read the image file
      final image = img.decodeImage(await file.readAsBytes());

      if (image != null) {
        // Encode to JPEG
        final jpegImage = img.encodeJpg(image);

        // Create a new file to store the JPEG image
        final jpegFile = File(file.path.replaceAll('.jpg', '.jpeg'));
        await jpegFile.writeAsBytes(jpegImage);

        return jpegFile;
      }
    } catch (e) {
      print('Error converting image: $e');
    }
    return null;
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 290,
          height: double.infinity,
          child: _imagePath == null
              ? FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CameraPreview(_cameraController);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )
              : Image.file(File(_imagePath!)),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: FloatingActionButton(
            backgroundColor: AppColors.frog,
            foregroundColor: AppColors.white,
            onPressed: () async {
              if (_imagePath == null) {
                try {
                  await _initializeControllerFuture;
                  final image = await _cameraController.takePicture();

                  // Convert the image to JPEG
                  final jpegImage = await _convertToJpeg(File(image.path));

                  if (jpegImage != null) {
                    setState(() {
                      _imagePath = jpegImage.path;
                      widget.onMediaCaptured(File(_imagePath!));
                      print("Captured image path: $_imagePath");
                    });
                  } else {
                    print('Failed to convert image to JPEG');
                  }
                } catch (e) {
                  print('Error capturing image: $e');
                }
              } else {
                setState(() {
                  _imagePath = null;
                });
              }
            },
            child: const Icon(Icons.camera_alt),
          ),
        ),
      ),
    );
  }
}
