import 'dart:io' show Platform;

import 'package:surf_practice_magic_ball/cubit/magic_ball_cubit.dart';
import 'package:surf_practice_magic_ball/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MagicBallScreen extends StatelessWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    final bool tight = screenSize.height > screenSize.width;

    final String text;

    if (Platform.isAndroid || Platform.isIOS) {
      text = 'Нажмите на шар \nили потрясите телефон';
    } else {
      text = 'Нажмите на шар';
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff100c2b),
              Color(0xff0f0a26),
              Color(0xff0d0922),
              Color(0xff0b071d),
              Color(0xff080618),
              Color(0xff050413),
              Color(0xff02020c),
              Color(0xff000003),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 56),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: tight ? double.infinity : screenSize.height,
                    height: tight ? screenSize.width : null,
                    child: GestureDetector(
                      onTap: () => context.read<MagicBallCubit>().getAnswer(),
                      child: BlocBuilder<MagicBallCubit, MagicBallState>(
                        builder: (BuildContext context, MagicBallState state) {
                          return MagicBall(
                            status: state.status,
                            answer: state.answer,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(200, 50)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x0001FFFF),
                          Color(0xff01FFFF),
                        ],
                        tileMode: TileMode.mirror,
                      ),
                    ),
                    height: 30,
                    width: tight ? 120 : screenSize.height / 5,
                  ),
                  Opacity(
                    opacity: 0.7,
                    child: Transform.scale(
                      scaleX: 4,
                      child: Container(
                        clipBehavior: Clip.none,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            radius: 1,
                            colors: [
                              Color(0xff02D0D1),
                              Color(0x00FF01C7),
                            ],
                            stops: [
                              0.00001,
                              0.5,
                            ],
                          ),
                        ),
                        height: tight ? 60 : screenSize.height / 10,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff727272),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
