class Admins {
  Admins({
    this.name,
    this.email,
    this.image,
  });

  String name;
  String email;
  String image;

  factory Admins.fromJson(Map<String, dynamic> json) => Admins(
    name: json["name"],
    email: json["email"],
    image: json["image"] == null ? null : json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "image": image == null ? null : image,
  };
}
