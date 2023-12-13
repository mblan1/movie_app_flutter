import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test1/api/apiRequest.dart';
import 'package:test1/modals/video.dart';
import 'package:test1/modals/video_list.dart';
import 'package:test1/pages/VideoScreen/video_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  Timer? _debounce;
  final List emptyList = [];
  VideoList? videoList;
  late String valueEncoded = "";
  late bool isEmptyInput = true;
  late bool isLoading = false;

  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(milliseconds: 500),
      () => FocusScope.of(context).requestFocus(myFocusNode),
    ); // auto focus to text field
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    _debounce?.cancel();
  }

  // get data
  Future<void> getData(String keyword) async {
    await getVideoListByKeyword(keyword, maxResults: 10).then((data) {
      setState(() {
        VideoList videoListData = VideoList.fromJson(data);
        videoList = videoListData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
        height: double.infinity,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color(0xff2B5876),
          Color(0xff4E4376),
        ])),
        child: Column(
          children: [
            searchInput(),

            // Search Result
            searchResult(),
          ],
        ),
      ),
    );
  }

  // search result
  Widget searchResult() {
    // filter items kind = video
    var videoListFiltered = videoList?.items
        .where((element) => element.id.kind == "youtube#video")
        .toList();

    // loading
    if (isLoading) {
      return Container(
        margin: const EdgeInsets.only(top: 20),
        child: const CircularProgressIndicator(),
      );
    } else {
      // list view
      return Expanded(
        child: ListView.builder(
          itemCount:
              isEmptyInput ? emptyList.length : videoListFiltered?.length,
          itemBuilder: (context, index) {
            // define snippet
            var snippet = videoListFiltered?[index].snippet;

            return Container(
              height: 85,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                onTap: () {
                  getVideoDataById(videoListFiltered?[index].id.videoId ?? "")
                      .then((data) {
                    Video videoData = Video.fromJson(data);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoDetailPage(
                          videoData: videoData,
                        ),
                      ),
                    );
                  });
                },
                // thumbnail
                leading: Container(
                  width: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(snippet?.thumbnails.medium.url ?? ""),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                // title
                title: Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  // height: double.infinity,
                  child: Text(
                    snippet?.title ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                // subtitle
                subtitle: Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(
                    "video",
                    style: TextStyle(
                      color: Colors.white.withOpacity(.6),
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
  }

// search input
  Row searchInput() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color.fromRGBO(107, 102, 166, 0.30),
                Color.fromRGBO(117, 209, 221, 0.30),
              ]),
              borderRadius: BorderRadius.circular(20),
            ),
            // input
            child: TextField(
              focusNode: myFocusNode,
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) async {
                if (_debounce?.isActive ?? false) _debounce?.cancel();

                _debounce = Timer(const Duration(milliseconds: 500), () async {
                  setState(() {
                    isLoading = true;
                  });
                  if (value.isEmpty) {
                    setState(() {
                      isEmptyInput = true;
                    });
                  } else {
                    setState(() {
                      isEmptyInput = false;
                      valueEncoded = value.replaceAll(" ", "%20");
                    });
                    await getData(valueEncoded);
                  }
                  setState(() {
                    isLoading = false;
                  });
                });
              },
              onTapOutside: (e) {
                FocusScope.of(context).requestFocus(FocusNode());
              },
            ),
          ),
        ),
      ],
    );
  }
}
