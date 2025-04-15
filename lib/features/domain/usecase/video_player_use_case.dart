import 'package:video_player_1/features/domain/entity/video_player_entity.dart';
import '../repository/video_repository.dart';

class GetVideoUseCase {
  final VideoRepository repository;

  GetVideoUseCase(this.repository);

  Future<VideoPlayerEntity> call({required String url}) async =>
      repository.getVideo(url: url);
}
