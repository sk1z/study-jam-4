import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'answer.g.dart';

@JsonSerializable()
class MagicAnswer extends Equatable {
  const MagicAnswer({required this.answer});

  factory MagicAnswer.fromJson(Map<String, dynamic> json) =>
      _$MagicAnswerFromJson(json);

  @JsonKey(name: 'reading')
  final String answer;

  @override
  List<Object> get props => [answer];

  Map<String, dynamic> toJson() => _$MagicAnswerToJson(this);
}
