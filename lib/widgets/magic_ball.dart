import 'package:surf_practice_magic_ball/cubit/magic_ball_cubit.dart';
import 'package:surf_practice_magic_ball/rendering/magic_ball_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class MagicBall extends StatefulWidget {
  const MagicBall({super.key, required this.status, required this.answer});

  final FormzSubmissionStatus status;
  final String answer;

  @override
  State<MagicBall> createState() => _MagicBallState();
}

class _MagicBallState extends State<MagicBall> with TickerProviderStateMixin {
  late final AnimationController _offsetController;
  late final AnimationController _shudderController;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<Offset> _shudderAnimation;

  static final Animatable<Offset> _shudderTween = TweenSequence<Offset>([
    TweenSequenceItem(
      weight: 1,
      tween: Tween<Offset>(begin: Offset.zero, end: const Offset(-0.1, 0)),
    ),
    TweenSequenceItem(
      weight: 1,
      tween: Tween<Offset>(
          begin: const Offset(-0.1, 0), end: const Offset(0.1, 0)),
    ),
    TweenSequenceItem(
      weight: 1,
      tween: Tween<Offset>(
          begin: const Offset(0.1, 0), end: const Offset(-0.05, 0)),
    ),
    TweenSequenceItem(
      weight: 2,
      tween: Tween<Offset>(
          begin: const Offset(-0.05, 0), end: const Offset(0.05, 0)),
    ),
    TweenSequenceItem(
      weight: 2,
      tween: Tween<Offset>(
          begin: const Offset(0.05, 0), end: const Offset(-0.03, 0)),
    ),
    TweenSequenceItem(
      weight: 3,
      tween: Tween<Offset>(
          begin: const Offset(-0.03, 0), end: const Offset(0.02, 0)),
    ),
    TweenSequenceItem(
      weight: 3,
      tween: Tween<Offset>(
          begin: const Offset(0.02, 0), end: const Offset(-0.01, 0)),
    ),
    TweenSequenceItem(
      weight: 3,
      tween:
          Tween<Offset>(begin: const Offset(-0.01, 0), end: const Offset(0, 0)),
    ),
  ]);

  @override
  void initState() {
    super.initState();

    _offsetController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _shudderController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -0.05),
      end: const Offset(0, 0.05),
    ).animate(CurvedAnimation(
      parent: _offsetController,
      curve: Curves.decelerate,
    ));
    _shudderAnimation = _shudderController.drive(_shudderTween);
  }

  @override
  void dispose() {
    _offsetController.dispose();
    _shudderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MagicBallCubit, MagicBallState>(
      listener: (BuildContext context, MagicBallState state) {
        if (state.status.isInProgress) {
          _offsetController.forward();
          _shudderController
            ..value = 0
            ..forward();
        }
      },
      child: SlideTransition(
        position: _offsetAnimation,
        child: SlideTransition(
          position: _shudderAnimation,
          child: CustomPaint(
            painter: MagicBallPainter(status: widget.status),
            child: Container(
              padding: const EdgeInsets.all(48),
              alignment: Alignment.center,
              child: Text(
                widget.answer,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
