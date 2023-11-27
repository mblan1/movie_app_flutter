import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test1/pages/youtubePlayer.dart';

class FullScreenPage extends StatefulWidget {
  final String videoURL;
  const FullScreenPage({Key? key, required this.videoURL}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() =>
      _FullScreenPageState(videoURL: videoURL);
}

class _FullScreenPageState extends State<FullScreenPage> {
  final String _videoURL;
  _FullScreenPageState({required String videoURL}) : _videoURL = videoURL;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
          color: Colors.black.withOpacity(.8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              YoutubePlayerAppPage(
                videoURL: _videoURL,
              ),
            ],
          )),
    );
  }
}
