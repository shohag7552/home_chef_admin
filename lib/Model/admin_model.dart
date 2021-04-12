class Admin {
  Admin({
    this.name,
    this.email,
  });

  String name;
  String email;

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
    name: json["name"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
  };
}
