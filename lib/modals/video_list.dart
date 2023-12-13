class VideoList {
  List<Item> items;

  VideoList({required this.items});

  factory VideoList.fromJson(Map<String, dynamic> json) {
    return VideoList(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))));
  }

  Map<String, dynamic> toJson() {
    return {"items": List<dynamic>.from(items.map((x) => x.toJson()))};
  }
}

// item
class Item {
  ID id;
  Snippet snippet;

  Item({required this.id, required this.snippet});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: ID.fromJson(json["id"]),
        snippet: Snippet.fromJson(json["snippet"]));
  }

  Map<String, dynamic> toJson() {
    return {"id": id.toJson(), "snippet": snippet.toJson()};
  }
}

// id
class ID {
  String kind;
  String? channelId;
  String? videoId;

  ID({required this.kind, required this.videoId, required this.channelId});

  factory ID.fromJson(Map<String, dynamic> json) {
    return ID(
      kind: json["kind"],
      videoId: json["videoId"],
      channelId: json["channelId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"kind": kind, "videoId": videoId};
  }
}

// snippet
class Snippet {
  DateTime publishedAt;
  String channelId;
  String title;
  String description;
  String? channelTitle;
  Thumbnail thumbnails;

  Snippet(
      {required this.publishedAt,
      required this.channelId,
      required this.title,
      required this.description,
      required this.thumbnails,
      required this.channelTitle});

  factory Snippet.fromJson(Map<String, dynamic> json) {
    return Snippet(
        publishedAt: DateTime.parse(json["publishedAt"]),
        channelId: json["channelId"],
        title: json["title"],
        description: json["description"],
        channelTitle: json["channelTitle"],
        thumbnails: Thumbnail.fromJson(json["thumbnails"]));
  }

  Map<String, dynamic> toJson() {
    return {
      "publishedAt": publishedAt.toIso8601String(),
      "channelId": channelId,
      "title": title,
      "description": description,
      "thumbnails": thumbnails.toJson()
    };
  }
}

// thumbnail
class Thumbnail {
  Default defaultThumbnail;
  Default medium;
  Default high;

  Thumbnail(
      {required this.defaultThumbnail,
      required this.medium,
      required this.high});

  factory Thumbnail.fromJson(Map<String, dynamic> json) {
    return Thumbnail(
        defaultThumbnail: Default.fromJson(json["default"]),
        medium: Default.fromJson(json["medium"]),
        high: Default.fromJson(json["high"]));
  }

  Map<String, dynamic> toJson() {
    return {
      "default": defaultThumbnail.toJson(),
      "medium": medium.toJson(),
      "high": high.toJson()
    };
  }
}

class Default {
  String url;
  int? width;
  int? height;

  Default({required this.url, required this.width, required this.height});
  factory Default.fromJson(Map<String, dynamic> json) {
    return Default(
        url: json["url"], width: json["width"], height: json["height"]);
  }

  Map<String, dynamic> toJson() {
    return {"url": url, "width": width, "height": height};
  }
}
