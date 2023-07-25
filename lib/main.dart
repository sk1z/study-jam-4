import 'package:surf_practice_magic_ball/cubit/magic_ball_cubit.dart';
import 'package:surf_practice_magic_ball/magic_ball_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

/// App,s main widget.
class MyApp extends StatelessWidget {
  /// Constructor for [MyApp].
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: BlocProvider(
          create: (_) =>
              MagicBallCubit(magicBallRepository: MagicBallRepository(Dio())),
          child: const MagicBallScreen(),
        ),
      ),
    );
  }
}
