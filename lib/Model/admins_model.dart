class Admins {
  Admins({
    this.id,
    this.name,
    this.email,
    this.image,
  });

  int id;
  String name;
  String email;
  String image;

  factory Admins.fromJson(Map<String, dynamic> json) => Admins(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "image": image == null ? null : image,
  };
}
