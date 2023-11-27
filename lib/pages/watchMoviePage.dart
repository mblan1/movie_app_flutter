import 'package:flutter/material.dart';
import 'package:test1/modals/movie.dart';
import 'package:test1/pages/youtubePlayer.dart';

class WatchMoviePage extends StatefulWidget {
  final Movie movieData;
  const WatchMoviePage({Key? key, required this.movieData}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _WatchMoviePageState(movie: movieData);
}

class _WatchMoviePageState extends State<WatchMoviePage> {
  final Movie _movie;
  _WatchMoviePageState({required Movie movie}) : _movie = movie;

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
              videoURL: _movie.videoUrl,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _movie.name,
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
