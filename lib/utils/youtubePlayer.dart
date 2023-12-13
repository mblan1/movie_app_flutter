import 'package:flutter/material.dart';
import 'package:test1/pages/MovieScreen/fullScreenVideo.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerAppPage extends StatefulWidget {
  String? videoURL;
  String? videoId;
  YoutubePlayerAppPage({
    Key? key,
    this.videoURL,
    this.videoId,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _YoutubePlayerAppState();
}

class _YoutubePlayerAppState extends State<YoutubePlayerAppPage> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;
  late String videoID;

  @override
  void initState() {
    widget.videoId == null
        ? videoID = YoutubePlayer.convertUrlToId(widget.videoURL!)!
        : videoID = widget.videoId!;
    // TODO: implement initState
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: videoID,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: true,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  // pause video when app is inactive
  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      // onExitFullScreen: () {
      //   FullScreen.setFullScreen(false);
      //   SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      // },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        bottomActions: [
          CurrentPosition(),
          ProgressBar(isExpanded: true),
          RemainingDuration(),
          IconButton(
            icon: const Icon(
              Icons.fullscreen,
              color: Colors.white,
            ),
            onPressed: () {
              // FullScreen.setFullScreen(true);
              _controller.pause();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FullScreenPage(videoURL: widget.videoURL!);
              }));
              // SystemChrome.setPreferredOrientations([
              //   DeviceOrientation.landscapeLeft,
              //   DeviceOrientation.landscapeRight,
              // ]);
            },
          )
        ],
      ),
      builder: (context, player) {
        return Column(
          children: [
            player,
          ],
        );
      },
    );
  }
}
