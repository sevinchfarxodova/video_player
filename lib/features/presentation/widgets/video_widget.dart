// lib/features/video_player/presentation/widgets/video_player_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import '../manager/video_player_cubit.dart';
import '../manager/video_player_state.dart';

class VideoPlayerWidget extends StatelessWidget {
  const VideoPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
      builder: (context, state) {
        if (state is VideoPlayerLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Видео уроки',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    const Text(
                      '12-Январь',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                // Video va play/pause icon
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: state.controller.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        VideoPlayer(state.controller),
                        if (state.controller.value.isBuffering)
                          const Center(child: CircularProgressIndicator()),
                        IconButton(
                          icon: Icon(
                            state.isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 60,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            context.read<VideoPlayerCubit>().togglePlayPause();
                          },
                        ),
                        VideoProgressIndicator(
                          state.controller,
                          allowScrubbing: true, // Allow the user to drag the thumb to seek
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          colors: const VideoProgressColors(
                            playedColor: Color(0xFF1E4E4E), // Color of the played portion
                            bufferedColor: Colors.grey, // Color of the buffered portion
                            backgroundColor: Colors.black12, // Background color
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Случайные слова чтобы заполнить пространство, слова чтобы '
                        'заполнить пространство, слова чтобы заполнить пространство, '
                        'слова чтобы заполнить пространство',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E4E4E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // Add your logic for the "Закончил" button
                      },
                      child: const Text(
                        'Закончил',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is VideoPlayerLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is VideoPlayerError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}