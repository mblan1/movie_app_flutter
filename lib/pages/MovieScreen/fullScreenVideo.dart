import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test1/utils/youtubePlayer.dart';

class FullScreenPage extends StatefulWidget {
  final String videoId;
  const FullScreenPage({Key? key, required this.videoId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FullScreenPageState();
}

class _FullScreenPageState extends State<FullScreenPage> {
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
                videoId: widget.videoId,
              ),
            ],
          )),
    );
  }
}
