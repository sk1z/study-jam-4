import 'package:surf_practice_magic_ball/models/models.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'magic_ball_repository.g.dart';

@RestApi(baseUrl: 'https://eightballapi.com/api')
abstract class MagicBallRepository {
  factory MagicBallRepository(Dio dio, {String baseUrl}) = _MagicBallRepository;

  @GET('')
  Future<MagicAnswer> getAnswer();
}
