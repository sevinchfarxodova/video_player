import 'package:video_player_1/features/domain/entity/video_player_entity.dart';

import '../models/video_model.dart';

abstract class VideoRemoteDataSource {
  Future<VideoPlayerEntity> getVideo({required String url});
}

class VideoRemoteDataSourceImp implements VideoRemoteDataSource {
  @override
  Future<VideoPlayerModel> getVideo({required String url}) async {
    try {
      if (url.isEmpty) {
        Exception('Video URL cannot be empty');
      }

      return VideoPlayerModel(url: url, title: "");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
