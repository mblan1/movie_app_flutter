import 'package:test1/modals/video_list.dart';

class Video {
  List<Item> items;

  Video({required this.items});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))));
  }

  Map<String, dynamic> toJson() {
    return {"items": List<dynamic>.from(items.map((x) => x.toJson()))};
  }
}

class Item {
  String id;
  Snippet snippet;

  Item({required this.id, required this.snippet});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(id: json["id"], snippet: Snippet.fromJson(json["snippet"]));
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "snippet": snippet.toJson()};
  }
}
