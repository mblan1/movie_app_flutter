import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:test1/modals/video.dart';
import 'package:test1/pages/VideoScreen/watch_video_page.dart';
import 'package:test1/widget/custom-bottom_bar.dart';

class VideoDetailPage extends StatefulWidget {
  final Video videoData;

  const VideoDetailPage({Key? key, required this.videoData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VideoDetailPage();
  }
}

class _VideoDetailPage extends State<VideoDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(children: [
        // movie
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              // background image
              image: NetworkImage(
                widget.videoData.items[0].snippet.thumbnails.high.url,
              ),
              fit: BoxFit.fitHeight,
            ),
          ),
          child: Stack(children: [
            // play button
            playBtn(context),

            // text
            DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.3,
              maxChildSize: 1,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.9,
                    padding: const EdgeInsets.only(bottom: 40),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xff2B5876),
                        Color(0xff4E4376),
                      ]),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      padding: const EdgeInsets.only(
                        left: 50,
                        right: 50,
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(children: [
                          // icon
                          const SizedBox(
                            child: Icon(Icons.drag_handle, color: Colors.white),
                          ),

                          // movie title
                          movieTitle(),
                          movieSubTitle(),

                          // Detail
                          movieDetail(),

                          // movie description
                          movieDesc(),
                        ]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ]),
        ),
      ]),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }

  Container playBtn(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 200),
      child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WatchVideoPage(
                            videoData: widget.videoData,
                          )),
                );
              },
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 40,
              ),
            ),
          )),
    );
  }

  Container movieDesc() {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: ReadMoreText(
        widget.videoData.items[0].snippet.description,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(255, 255, 255, 0.75),
        ),
        textAlign: TextAlign.justify,
        trimLines: 5,
        colorClickableText: Colors.pink,
        trimMode: TrimMode.Line,
        trimCollapsedText: 'More',
        trimExpandedText: 'Less',
        moreStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.blue[200],
        ),
        lessStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.blue[200],
        ),
      ),
    );
  }

  Container movieDetail() {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // rating and score
          Row(
            children: [
              // movie category
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.only(left: 8, right: 8),
                height: 23,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.1),
                    borderRadius: BorderRadius.circular(20)),
                child:
                    // Movie Type
                    const Text(
                  "video",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // ages
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.only(left: 8, right: 8),
                height: 23,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.1),
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  "16+",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),

          // icon
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Transform.flip(
                    flipX: true,
                    child: const Icon(
                      Icons.reply,
                      color: Colors.white,
                    ),
                  )),
              const Icon(
                Icons.heart_broken,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container movieSubTitle() {
    return Container(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        widget.videoData.items[0].snippet.channelTitle ?? "",
        style: TextStyle(
          color: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }

  Container movieTitle() {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        widget.videoData.items[0].snippet.title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
