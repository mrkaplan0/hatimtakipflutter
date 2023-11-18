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

  MyUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        username = json['username'],
        userToken = json['userToken'],
        favoritesPeople = json['favoritesPeople'];

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
