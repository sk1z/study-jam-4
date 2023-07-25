import 'package:surf_practice_magic_ball/magic_ball_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:shake/shake.dart';

part 'magic_ball_state.dart';

class MagicBallCubit extends Cubit<MagicBallState> {
  MagicBallCubit({required MagicBallRepository magicBallRepository})
      : _repostitory = magicBallRepository,
        super(const MagicBallState()) {
    detector = ShakeDetector.autoStart(onPhoneShake: () {
      getAnswer();
    });
  }

  late final ShakeDetector detector;

  final MagicBallRepository _repostitory;

  void getAnswer() async {
    if (state.status.isInProgress) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final String answer = (await _repostitory.getAnswer()).answer;

      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
        answer: answer,
      ));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }

  @override
  Future<void> close() {
    detector.stopListening();
    return super.close();
  }
}
