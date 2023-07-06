class UserModel {
  UserModel(
      {required this.id,
      required this.geoId,
      required this.createdAt,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.bio,
      required this.rank,
      required this.xp});

  String? id;
  String geoId;
  DateTime createdAt;
  String username;
  String firstName;
  String lastName;
  String bio;
  String rank;
  int xp;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      geoId: json["geoId"],
      createdAt: DateTime.parse(json["createdAt"]),
      username: json["username"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      bio: json["bio"],
      rank: json["rank"],
      xp: json["xp"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "geoId": geoId,
        "createdAt": createdAt.toIso8601String(),
        "username": username,
        "firstName": firstName,
        "lastName": lastName,
        "bio": bio,
        "rank": rank,
        "xp": xp
      };
}
