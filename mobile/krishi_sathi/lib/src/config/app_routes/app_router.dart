import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_sathi/src/config/app_routes/app_route.dart';
import 'package:krishi_sathi/src/config/app_routes/no_route_found.dart';
import 'package:krishi_sathi/src/config/container_injector.dart';
import 'package:krishi_sathi/src/core/screen_args.dart/message_screen_args.dart';
import 'package:krishi_sathi/src/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:krishi_sathi/src/features/chat/presentation/screens/chat_screen.dart';
import 'package:krishi_sathi/src/features/home/screens/home_screen.dart';
import 'package:krishi_sathi/src/features/home/screens/media_upload_screen.dart';
import 'package:krishi_sathi/src/features/splash/presentation/screens/splash_screen.dart';

class AppRouter {
  AppRouter._();
  static final _chatBloc = sl<ChatBloc>();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.root:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ChatBloc>.value(
            value: _chatBloc,
            child: const HomeScreen(),
          ),
        );
      case AppRoutes.mediaUpload:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ChatBloc>.value(
            value: _chatBloc,
            child: const MediaUploadScreen(),
          ),
        );
      case AppRoutes.chat:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<ChatBloc>.value(
            value: _chatBloc,
            child: ChatScreen(
              messageScreenArgs: settings.arguments as MessageScreenArgs,
            ),
          ),
        );
      case AppRoutes.noRoute:
        return MaterialPageRoute(
          builder: (context) => const NoRouteFound(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const NoRouteFound(),
        );
    }
  }
}
