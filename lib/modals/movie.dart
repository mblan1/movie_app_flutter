List<Map<String, dynamic>> movieData = [
  {
    'name': 'Deadpool',
    'description':
        "Marvel's The Avengers[5] (classified under the name Marvel Avengers Assemble in the United Kingdom and Ireland),[1][6] or simply The Avengers, is a 2012 American superhero film based on the Marvel Comics superhero team of the same name. Produced by Marvel Studios and distributed by Walt Disney Studios Motion Pictures,[a] it is the sixth film in the Marvel Cinematic Universe (MCU). Written and directed by Joss Whedon, the film features an ensemble cast including Robert Downey Jr., Chris Evans, Mark Ruffalo, Chris Hemsworth, Scarlett Johansson, and Jeremy Renner as the Avengers, alongside Tom Hiddleston, Stellan Skarsgård, and Samuel L. Jackson. In the film, Nick Fury and the spy agency S.H.I.E.L.D. recruit Tony Stark, Steve Rogers, Bruce Banner, Thor, Natasha Romanoff, and Clint Barton to form a team capable of stopping Thor's brother Loki from subjugating Earth.",
    "age": 16,
    "imagePath": "assets/images/deadpool2.jpg",
    "imdb_point": 6,
    "videoUrl": "https://www.youtube.com/watch?v=ONHBaC-pfsk",
    'cast': [
      {
        'name': 'Lion',
        'role': 'actor',
      },
      {
        'name': 'anna',
        'role': 'no',
      },
    ],
  },
  {
    'name': 'Deadpool',
    'description':
        "Marvel's The Avengers[5] (classified under the name Marvel Avengers Assemble in the United Kingdom and Ireland),[1][6] or simply The Avengers, is a 2012 American superhero film based on the Marvel Comics superhero team of the same name. Produced by Marvel Studios and distributed by Walt Disney Studios Motion Pictures,[a] it is the sixth film in the Marvel Cinematic Universe (MCU). Written and directed by Joss Whedon, the film features an ensemble cast including Robert Downey Jr., Chris Evans, Mark Ruffalo, Chris Hemsworth, Scarlett Johansson, and Jeremy Renner as the Avengers, alongside Tom Hiddleston, Stellan Skarsgård, and Samuel L. Jackson. In the film, Nick Fury and the spy agency S.H.I.E.L.D. recruit Tony Stark, Steve Rogers, Bruce Banner, Thor, Natasha Romanoff, and Clint Barton to form a team capable of stopping Thor's brother Loki from subjugating Earth.",
    "age": 16,
    "imagePath": "assets/images/deadpool2.jpg",
    "imdb_point": 6,
    "videoUrl": "https://www.youtube.com/watch?v=ONHBaC-pfsk",
    'cast': [
      {
        'name': 'Lion',
        'role': 'actor',
      },
      {
        'name': 'anna',
        'role': 'no',
      },
    ],
  },
  {
    'name': 'Deadpool',
    'description':
        "Marvel's The Avengers[5] (classified under the name Marvel Avengers Assemble in the United Kingdom and Ireland),[1][6] or simply The Avengers, is a 2012 American superhero film based on the Marvel Comics superhero team of the same name. Produced by Marvel Studios and distributed by Walt Disney Studios Motion Pictures,[a] it is the sixth film in the Marvel Cinematic Universe (MCU). Written and directed by Joss Whedon, the film features an ensemble cast including Robert Downey Jr., Chris Evans, Mark Ruffalo, Chris Hemsworth, Scarlett Johansson, and Jeremy Renner as the Avengers, alongside Tom Hiddleston, Stellan Skarsgård, and Samuel L. Jackson. In the film, Nick Fury and the spy agency S.H.I.E.L.D. recruit Tony Stark, Steve Rogers, Bruce Banner, Thor, Natasha Romanoff, and Clint Barton to form a team capable of stopping Thor's brother Loki from subjugating Earth.",
    "age": 16,
    "imagePath": "assets/images/deadpool2.jpg",
    "imdb_point": 6,
    "videoUrl": "https://www.youtube.com/watch?v=ONHBaC-pfsk",
    'cast': [
      {
        'name': 'Lion',
        'role': 'actor',
      },
      {
        'name': 'anna',
        'role': 'no',
      },
    ],
  },
  {
    'name': 'Deadpool',
    'description':
        "Marvel's The Avengers[5] (classified under the name Marvel Avengers Assemble in the United Kingdom and Ireland),[1][6] or simply The Avengers, is a 2012 American superhero film based on the Marvel Comics superhero team of the same name. Produced by Marvel Studios and distributed by Walt Disney Studios Motion Pictures,[a] it is the sixth film in the Marvel Cinematic Universe (MCU). Written and directed by Joss Whedon, the film features an ensemble cast including Robert Downey Jr., Chris Evans, Mark Ruffalo, Chris Hemsworth, Scarlett Johansson, and Jeremy Renner as the Avengers, alongside Tom Hiddleston, Stellan Skarsgård, and Samuel L. Jackson. In the film, Nick Fury and the spy agency S.H.I.E.L.D. recruit Tony Stark, Steve Rogers, Bruce Banner, Thor, Natasha Romanoff, and Clint Barton to form a team capable of stopping Thor's brother Loki from subjugating Earth.",
    "age": 16,
    "imagePath": "assets/images/deadpool2.jpg",
    "imdb_point": 6,
    "videoUrl": "https://www.youtube.com/watch?v=ONHBaC-pfsk",
    'cast': [
      {
        'name': 'Lion',
        'role': 'actor',
      },
      {
        'name': 'anna',
        'role': 'no',
      },
    ],
  },
  {
    'name': 'Deadpool',
    'description':
        "Marvel's The Avengers[5] (classified under the name Marvel Avengers Assemble in the United Kingdom and Ireland),[1][6] or simply The Avengers, is a 2012 American superhero film based on the Marvel Comics superhero team of the same name. Produced by Marvel Studios and distributed by Walt Disney Studios Motion Pictures,[a] it is the sixth film in the Marvel Cinematic Universe (MCU). Written and directed by Joss Whedon, the film features an ensemble cast including Robert Downey Jr., Chris Evans, Mark Ruffalo, Chris Hemsworth, Scarlett Johansson, and Jeremy Renner as the Avengers, alongside Tom Hiddleston, Stellan Skarsgård, and Samuel L. Jackson. In the film, Nick Fury and the spy agency S.H.I.E.L.D. recruit Tony Stark, Steve Rogers, Bruce Banner, Thor, Natasha Romanoff, and Clint Barton to form a team capable of stopping Thor's brother Loki from subjugating Earth.",
    "age": 16,
    "imagePath": "assets/images/deadpool2.jpg",
    "imdb_point": 6,
    "videoUrl": "https://www.youtube.com/watch?v=ONHBaC-pfsk",
    'cast': [
      {
        'name': 'Lion',
        'role': 'actor',
      },
      {
        'name': 'anna',
        'role': 'no',
      },
    ],
  },
];

List<Movie> movies = movieData.map((movie) {
  return Movie(
      name: movie['name'],
      description: movie['description'],
      imagePath: movie['imagePath'],
      imdb_point: (movie['imdb_point']).toDouble(),
      age: movie['age'],
      videoUrl: movie['videoUrl'],
      cast: (movie['cast'] as List?)!.map((cast) {
        return Cast(
          name: cast['name'],
          role: cast['role'],
        );
      }).toList());
}).toList();

class Movie {
  final String name, description, imagePath, videoUrl;
  final int age;
  final double imdb_point;
  final List<Cast> cast;

  Movie({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.imdb_point,
    required this.age,
    required this.videoUrl,
    required this.cast,
  });
}

class Cast {
  String name;
  String role;

  Cast({
    required this.name,
    required this.role,
  });
}
