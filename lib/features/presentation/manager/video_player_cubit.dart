
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_1/features/domain/usecase/video_player_use_case.dart';
import 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  final GetVideoUseCase getVideoUseCase;

  VideoPlayerCubit(this.getVideoUseCase) : super(VideoPlayerInitial());


  Future<void> fetchVideo(String url) async {
    emit(VideoPlayerLoading());

    try {
      final videoEntity = await getVideoUseCase(url: url);

      final controller = VideoPlayerController.networkUrl(Uri.parse(videoEntity.url));
      await controller.initialize();

      controller.addListener(() {
        if (controller.value.isInitialized && !controller.value.isPlaying) {
          // Check if the video has reached the end
          if (controller.value.position >= controller.value.duration) {
            emit((state as VideoPlayerLoaded).copyWith(isPlaying: false));
            controller.seekTo(Duration.zero); // Optional: Reset to the beginning
          }
        }
      });

      emit(VideoPlayerLoaded(videoEntity: videoEntity, controller: controller));
    } catch (e) {
      emit(VideoPlayerError(e.toString()));
    }
  }

  void togglePlayPause() {
    if (state is VideoPlayerLoaded) {
      final currentState = state as VideoPlayerLoaded;
      if (currentState.isPlaying) {
        currentState.controller.pause();
      } else {
        currentState.controller.play();
      }
      emit(currentState.copyWith(isPlaying: !currentState.isPlaying));
    }
  }

  @override
  Future<void> close() {
    if (state is VideoPlayerLoaded) {
      (state as VideoPlayerLoaded).controller.dispose();
    }
    return super.close();
  }
}