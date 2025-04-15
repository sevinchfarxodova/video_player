import 'package:flutter/material.dart';

import 'features/presentation/pages/video_player_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: VideoPlayerPage(),
    );
  }
}