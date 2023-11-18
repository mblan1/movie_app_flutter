import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test1/modals/movie_category.dart';
import 'package:test1/modals/movie_type_catgory.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentSlide = 3;
  int _defaultSlide = 0;
  // get movie category
  static List<MovieCategory> movieList = MovieCategory.getCategory();
  static List<movieTypeCategories> movieTypeList =
      movieTypeCategories.getMovieTypeCategory();

  final color = [
    Colors.red,
    Colors.blue,
    Colors.amberAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xff2B5876),
        Color(0xff4E4376),
      ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // search bar
            textField(),

            const SizedBox(
              height: 20,
            ),

            // popular category
            popularCategory(context),

            const SizedBox(
              height: 12,
            ),

            // filmType category
            categoryMenu(),

            const SizedBox(
              height: 12,
            ),

            // upcoming
            upcomingReleases()
          ],
        ),
      ),
    );
  }

  // category menu
  Container categoryMenu() {
    return Container(
      padding: const EdgeInsets.only(left: 32),
      height: 95,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movieTypeList.length,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(right: 9),
          height: 95,
          width: 69,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Color.fromRGBO(255, 255, 255, 0.20)),
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(166, 161, 224, 0.30),
              Color.fromRGBO(161, 243, 254, 0.30),
            ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: SvgPicture.asset(
                  movieTypeList[index].icon,
                  height: 30,
                  width: 30,
                  // ignore: deprecated_member_use
                  color: Colors.white,
                ),
              ),
              Text(
                movieTypeList[index].name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }

  // upcoming
  Column upcomingReleases() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 32),
          child: const Text(
            "Upcoming Releases",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: PageView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            onPageChanged: (index) => setState(() {
              _defaultSlide = index;
            }),
            controller: PageController(
              initialPage: 2,
              viewportFraction: 0.5,
            ),
            itemCount: movieList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(8),
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(
                      movieList[index].imagePath,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        Center(
          child: TabPageSelector(
            controller: TabController(
              length: movieList.length,
              initialIndex: _defaultSlide,
              vsync: this,
            ),
            indicatorSize: 8,
          ),
        )
      ],
    );
  }

// popular category
  Column popularCategory(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 32),
          child: Text(
            "Most Popular",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 141,
                  width: MediaQuery.of(context).size.width,

                  // slider
                  child: PageView.builder(
                    // handle slide
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() {
                        _currentSlide = index;
                      });
                    },
                    // render
                    itemCount: movieList.length,
                    controller: PageController(
                      viewportFraction: 0.75,
                      initialPage: 3,
                    ),
                    itemBuilder: (context, index) {
                      // render
                      return Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.all(8),
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Image.asset(
                              movieList[index % movieList.length].imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),

                          // text over image
                          Container(
                            alignment: Alignment.bottomLeft,
                            margin: const EdgeInsets.only(left: 26, bottom: 15),
                            child: Text(
                              movieList[index % movieList.length].name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          // imdb point
                          Container(
                            alignment: Alignment.bottomRight,
                            margin: EdgeInsets.only(right: 30, bottom: 18),
                            child: Container(
                              width: 44,
                              height: 14,
                              decoration: BoxDecoration(
                                color: Color(0xffF5C518),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "IMDB ${movieList[index % movieList.length].imdb_point}",
                                  style: const TextStyle(
                                      fontSize: 6, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),

                          // blur item not centered
                          Positioned.fill(
                            child: Visibility(
                              visible: index != _currentSlide,
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                // slider dot
                TabPageSelector(
                  controller: TabController(
                    length: movieList.length,
                    initialIndex: _currentSlide,
                    vsync: this,
                  ),
                  indicatorSize: 8,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

// text field
  Center textField() {
    return Center(
      child: SizedBox(
        width: 328,
        height: 50,
        // margin: const EdgeInsets.only(left: 30, right: 30),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(107, 102, 166, 0.30),
              Color.fromRGBO(117, 209, 221, 0.30),
            ]),
            borderRadius: BorderRadius.circular(15),
            border:
                Border.all(color: const Color.fromRGBO(255, 255, 255, 0.20)),
          ),
          child: TextField(
            spellCheckConfiguration: const SpellCheckConfiguration.disabled(),
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(18),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),

              // search icon
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
                weight: 1,
                fill: 1,
                grade: 10,
              ),
              // placeholder text
              hintText: "Search",
              hintStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w100),
              // mic icon
              suffixIcon: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 50,
                child: const IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // white line
                      VerticalDivider(
                        color: Colors.white,
                        indent: 10,
                        endIndent: 10,
                        thickness: 1,
                      ),
                      // icon
                      Icon(
                        Icons.mic,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// app bar
  AppBar appBar() {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: Colors.transparent,
      elevation: 0,
      // text
      title: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: RichText(
          text: const TextSpan(
              text: 'Hello,',
              children: [
                TextSpan(
                    text: ' Jane',
                    style: TextStyle(fontWeight: FontWeight.bold))
              ],
              style: TextStyle(fontSize: 18)),
        ),
      ),
      // icon bell
      actions: [
        Container(
          padding: const EdgeInsets.only(right: 35),
          child: SvgPicture.asset(
            'assets/icons/notification-bell.svg',
            height: 20,
            width: 20,
            // ignore: deprecated_member_use
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
