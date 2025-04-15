import '../../domain/entity/video_player_entity.dart';
import '../../domain/repository/video_repository.dart';
import '../data_sources/video_remote_data_source.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideoRemoteDataSource remoteDataSource;

  VideoRepositoryImpl(this.remoteDataSource);

  @override
  Future<VideoPlayerEntity> getVideo({required String url}) async {
    try {
      final videoModel = await remoteDataSource.getVideo(url: url);
      return videoModel;
    } catch (e) {
      throw Exception(e);
    }
  }
}
