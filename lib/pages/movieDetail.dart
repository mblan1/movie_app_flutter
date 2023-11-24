import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:test1/BottomBar/CustomBottomBar.dart';
import 'package:test1/modals/movie.dart';
import 'package:test1/modals/movie_category.dart';

class MovieDetailPage extends StatefulWidget {
  // final MovieCategory movieCategory;

  const MovieDetailPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // ignore: no_logic_in_create_state
    return _MovieDetailPage();
  }
}

class _MovieDetailPage extends State<MovieDetailPage> {
  // final MovieCategory movieData;

  // _MovieDetailPage({required this.movieData});

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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/deadpool2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: DraggableScrollableSheet(
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                // height: 1000,
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
                    MovieTitle(),
                    MovieSubTitle(),

                    // Detail
                    MovieDetail(),

                    // movie description
                    MovieDesc(),

                    // CAST
                    MovieCast(),
                  ]),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
    );
  }

  Container MovieCast() {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          // title
          Container(
            child: const Row(
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
          ),

          // list cast
          Container(
            padding: const EdgeInsets.only(top: 8),
            height: 200,
            child: Row(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 8,
                    ),
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
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
                                    "assets/images/deadpool2.jpg",
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
                                  const Text(
                                    "Ryan Reynolds",
                                    textDirection: TextDirection.rtl,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),

                                  // cast role
                                  Container(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Text(
                                      "Deadpool",
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

  Container MovieDesc() {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: ReadMoreText(
        "Deadpool",
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

  Container MovieDetail() {
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
                child: Text(
                  "Action",
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
                  "16+",
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
                        text: "12.0",
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            height: 1.4),
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

  Container MovieSubTitle() {
    return Container(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        "The Dark World",
        style: TextStyle(
          color: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }

  Container MovieTitle() {
    return Container(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        "Deadpool",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
