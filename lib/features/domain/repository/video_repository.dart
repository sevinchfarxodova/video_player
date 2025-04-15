import 'package:video_player_1/features/domain/entity/video_player_entity.dart';

abstract class VideoRepository {
  Future<VideoPlayerEntity> getVideo({required String url});
}
