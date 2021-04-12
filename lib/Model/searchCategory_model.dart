
class SearchCategory {
  SearchCategory({
    this.data,
  });

  List<Datum> data;

  factory SearchCategory.fromJson(Map<String, dynamic> json) => SearchCategory(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.image,
    this.icon,
  });

  int id;
  String name;
  String image;
  String icon;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "icon": icon,
  };
}
