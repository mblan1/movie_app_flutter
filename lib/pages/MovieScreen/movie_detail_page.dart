import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:test1/widget/custom-bottom_bar.dart';
import 'package:test1/modals/movie.dart';
import 'package:test1/pages/MovieScreen/watch_movie_page.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movieData;

  const MovieDetailPage({Key? key, required this.movieData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MovieDetailPage();
  }
}

class _MovieDetailPage extends State<MovieDetailPage> {
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
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(children: [
        // movie
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              // background image
              image: AssetImage(widget.movieData.imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.3,
            maxChildSize: 0.5,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                // physics: const BouncingScrollPhysics(),
                controller: scrollController,
                child: Container(
                  // height: MediaQuery.of(context).size.height * 0.8,
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
                    padding: const EdgeInsets.only(left: 50, right: 50),
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

                      // CAST
                      movieCast(),
                    ]),
                  ),
                ),
              );
            },
          ),
        ),

        // play button
        playBtn(context),
      ]),
      bottomNavigationBar: const CustomBottomBar(),
    );
  }

  Container playBtn(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 160),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WatchMoviePage(
                    movieData: widget.movieData,
                  );
                }));
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

  Container movieCast() {
    // cast
    List<Cast> castData = widget.movieData.cast;
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          // title
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Cast",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              // see all
              Text(
                "See all",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          // list cast
          Container(
            padding: const EdgeInsets.only(top: 8),
            height: 160,
            child: Row(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 8,
                    ),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: castData.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: Column(
                          children: [
                            // cast image
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                  image: AssetImage(
                                    castData[index].castAvtUrl,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            // cast name
                            Container(
                              width: 60,
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                children: [
                                  // cast real name
                                  Text(
                                    castData[index].name,
                                    textDirection: TextDirection.rtl,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),

                                  // cast role
                                  Container(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Text(
                                      castData[index].role,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container movieDesc() {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: ReadMoreText(
        widget.movieData.description,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color.fromRGBO(255, 255, 255, 0.75),
        ),
        textAlign: TextAlign.justify,
        trimLines: 3,
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
                    Text(
                  widget.movieData.type,
                  style: const TextStyle(
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
                child: Text(
                  "${widget.movieData.age}+",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    height: 1.6,
                  ),
                ),
              ),

              // imdb score
              Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                height: 23,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(20)),
                child: RichText(
                  text: TextSpan(
                    text: "IMDb ",
                    children: [
                      TextSpan(
                        text: "${widget.movieData.imdb_point}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                        ),
                      )
                    ],
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // icon
          Container(
            child: Row(
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
          ),
        ],
      ),
    );
  }

  Container movieSubTitle() {
    return Container(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        widget.movieData.subtitle,
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
        widget.movieData.name,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
