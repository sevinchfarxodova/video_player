import 'package:video_player/video_player.dart';

import '../../domain/entity/video_player_entity.dart';

abstract class VideoPlayerState {
  const VideoPlayerState();
}

class VideoPlayerInitial extends VideoPlayerState {}

class VideoPlayerLoading extends VideoPlayerState {}

class VideoPlayerLoaded extends VideoPlayerState {
  final VideoPlayerEntity videoEntity;
  final VideoPlayerController controller;
  final bool isPlaying;

  const VideoPlayerLoaded({
    required this.videoEntity,
    required this.controller,
    this.isPlaying = false,
  });

  VideoPlayerLoaded copyWith({
    VideoPlayerEntity? videoEntity,
    VideoPlayerController? controller,
    bool? isPlaying,
  }) {
    return VideoPlayerLoaded(
      videoEntity: videoEntity ?? this.videoEntity,
      controller: controller ?? this.controller,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}

class VideoPlayerError extends VideoPlayerState {
  final String message;

  const VideoPlayerError(this.message);
}
