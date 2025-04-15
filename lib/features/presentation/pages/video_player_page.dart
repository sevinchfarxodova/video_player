import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player_1/features/domain/usecase/video_player_use_case.dart';
import '../../data/data_sources/video_remote_data_source.dart';
import '../../data/repositories/video_repository_impl.dart';
import '../manager/video_player_cubit.dart';
import '../manager/video_player_state.dart';
import '../widgets/video_widget.dart';

class VideoPlayerPage extends StatelessWidget {
  const VideoPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize dependencies (in a real app, use dependency injection like get_it)
    final remoteDataSource = VideoRemoteDataSourceImp();
    final repository = VideoRepositoryImpl(remoteDataSource);
    final getVideoUseCase = GetVideoUseCase(repository);

    return BlocProvider(
      create: (context) => VideoPlayerCubit(getVideoUseCase)
        ..fetchVideo('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F5F4),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF1F5F4),
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          title:  Text(
            'Назад',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: const [
                  Text('Хатамов Н', style: TextStyle(color: Colors.black)),
                  SizedBox(width: 4),
                  Icon(Icons.person_outline, color: Colors.black),
                ],
              ),
            ),
          ],
        ),
        body: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
          builder: (context, state) {
            if (state is VideoPlayerLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is VideoPlayerLoaded) {
              return Center(child: VideoPlayerWidget());
            } else if (state is VideoPlayerError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Press a button to load a video'));
          },
        ),
      ),
    );
  }
}