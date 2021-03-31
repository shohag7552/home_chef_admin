class Category {
  Category({
    this.id,
    this.name,
    this.image,
    this.icon,
  });

  int id;
  String name;
  String image;
  String icon;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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
