part of 'magic_ball_cubit.dart';

class MagicBallState extends Equatable {
  const MagicBallState({
    this.status = FormzSubmissionStatus.initial,
    this.answer = '',
  });

  final FormzSubmissionStatus status;
  final String answer;

  @override
  List<Object> get props => [status];

  MagicBallState copyWith({
    FormzSubmissionStatus? status,
    String? answer,
  }) {
    return MagicBallState(
      status: status ?? this.status,
      answer: answer ?? '',
    );
  }
}
