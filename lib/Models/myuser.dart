class MyUser {
  String id;
  String? email;
  String username;
  String? userToken;
  List<MyUser>? favoritesPeople;

  MyUser(
      {required this.id,
      this.email,
      required this.username,
      this.userToken,
      this.favoritesPeople});

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
        id: json['id'],
        email: json['email'],
        username: json['username'],
        userToken: json['userToken'],
        favoritesPeople: json['favoritesPeople']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'userToken': userToken,
      'favoritesPeople': favoritesPeople
    };
  }

  @override
  String toString() {
    return 'User  {userID: $id, email: $email, username: $username, userToken: $userToken, favoritesPeople: $favoritesPeople } ';
  }
}
