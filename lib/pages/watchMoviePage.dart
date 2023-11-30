import 'package:flutter/material.dart';
import 'package:test1/modals/movie.dart';
import 'package:test1/pages/youtubePlayer.dart';

class WatchMoviePage extends StatefulWidget {
  final Movie movieData;
  const WatchMoviePage({Key? key, required this.movieData}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WatchMoviePageState();
}

class _WatchMoviePageState extends State<WatchMoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff2B5876),
              Color(0xff4E4376),
            ],
          ),
        ),
        child: Column(
          children: [
            YoutubePlayerAppPage(
              videoURL: widget.movieData.videoUrl,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.movieData.name,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Row(
                    children: [
                      Icon(Icons.high_quality, color: Colors.white),
                      Icon(Icons.more_horiz, color: Colors.white)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
