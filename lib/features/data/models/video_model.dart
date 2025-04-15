// lib/features/video_player/data/models/video_player_model.dart

import '../../domain/entity/video_player_entity.dart';

class VideoPlayerModel extends VideoPlayerEntity {
  VideoPlayerModel({required super.url, required super.title});

  factory VideoPlayerModel.fromJson(Map<String, dynamic> json) {
    return VideoPlayerModel(url: json['url'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'title': title};
  }
}
