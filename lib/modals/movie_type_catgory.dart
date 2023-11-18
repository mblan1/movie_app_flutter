import 'package:flutter/material.dart';

class movieTypeCategories {
  String name;
  String icon;

  movieTypeCategories({
    required this.name,
    required this.icon,
  });

  static List<movieTypeCategories> getMovieTypeCategory() {
    List<movieTypeCategories> movieTypeList = [];

    movieTypeList.add(
      movieTypeCategories(
        name: "Action",
        icon: "assets/icons/four-square-menu.svg",
      ),
    );

    movieTypeList.add(
      movieTypeCategories(
        name: "Action",
        icon: "assets/icons/four-square-menu.svg",
      ),
    );

    movieTypeList.add(
      movieTypeCategories(
        name: "Action",
        icon: "assets/icons/four-square-menu.svg",
      ),
    );

    movieTypeList.add(
      movieTypeCategories(
        name: "Action",
        icon: "assets/icons/four-square-menu.svg",
      ),
    );

    return movieTypeList;
  }
}
