class TotalUser {
  TotalUser({
    this.totalUser,
  });

  int totalUser;

  factory TotalUser.fromJson(Map<String, dynamic> json) => TotalUser(
    totalUser: json["total_user"],
  );

  Map<String, dynamic> toJson() => {
    "total_user": totalUser,
  };
}
