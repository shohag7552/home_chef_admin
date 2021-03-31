
class Categories {
  Categories({
    this.id,
    this.name,
    this.image,
    this.icon,
  });

  int id;
  String name;
  String image;
  String icon;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
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
