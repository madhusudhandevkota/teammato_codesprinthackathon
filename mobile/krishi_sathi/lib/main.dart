import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_sathi/src/config/container_injector.dart';
import 'package:krishi_sathi/src/config/local_wrapper.dart';
import 'package:krishi_sathi/src/core/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  await EasyLocalization.ensureInitialized();
  runApp(const LocalWrapper(child: App()));
}
