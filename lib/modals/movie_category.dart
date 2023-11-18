import 'package:flutter/material.dart';

class MovieCategory {
  String imagePath;
  String name;
  String description;
  String type;
  double imdb_point;
  int age;

  MovieCategory({
    required this.age,
    required this.name,
    required this.description,
    required this.imagePath,
    required this.imdb_point,
    required this.type,
  });

  static List<MovieCategory> getCategory() {
    List<MovieCategory> movieList = [];

    movieList.add(
      MovieCategory(
          age: 16,
          name: "Deadpool 2",
          description: "DeadPool 2",
          imagePath: "assets/images/deadpool2.jpg",
          imdb_point: 12,
          type: "action"),
    );

    movieList.add(
      MovieCategory(
          age: 16,
          name: "Deadpool 2",
          description: "DeadPool 2",
          imagePath: "assets/images/avenger_infinity.jpg",
          imdb_point: 6,
          type: "action"),
    );

    movieList.add(
      MovieCategory(
          age: 16,
          name: "Deadpool 2",
          description: "DeadPool 2",
          imagePath: "assets/images/Avengers_Endgame.jpg",
          imdb_point: 12,
          type: "action"),
    );

    movieList.add(
      MovieCategory(
          age: 16,
          name: "Deadpool 2",
          description: "DeadPool 2",
          imagePath: "assets/images/deadpool2.jpg",
          imdb_point: 12,
          type: "action"),
    );

    movieList.add(
      MovieCategory(
          age: 16,
          name: "Deadpool 2",
          description: "DeadPool 2",
          imagePath: "assets/images/avenger_infinity.jpg",
          imdb_point: 12,
          type: "action"),
    );

    movieList.add(
      MovieCategory(
          age: 16,
          name: "Deadpool 2",
          description: "DeadPool 2",
          imagePath: "assets/images/Avengers_Endgame.jpg",
          imdb_point: 12,
          type: "action"),
    );

    return movieList;
  }
}
