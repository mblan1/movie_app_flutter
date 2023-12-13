import 'package:flutter/material.dart';
import 'package:test1/modals/video.dart';
import 'package:test1/utils/youtubePlayer.dart';

class WatchVideoPage extends StatefulWidget {
  final Video videoData;
  const WatchVideoPage({Key? key, required this.videoData}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WatchVideoPage();
}

class _WatchVideoPage extends State<WatchVideoPage> {
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
              videoId: widget.videoData.items[0].id,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.videoData.items[0].snippet.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        overflow: TextOverflow.clip,
                      ),
                    ),
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
