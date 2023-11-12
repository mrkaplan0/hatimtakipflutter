class MyUser {
  String? id;
  String? email;
  String? username;
  String? userToken;
  List<MyUser>? favoritesPeople;

  MyUser(
      {required this.id,
      required this.username,
      this.email,
      this.favoritesPeople});

  Map<String, dynamic> toMap() {
    return {
      'userID': id,
      'email': email,
      'username': username,
      'userToken': userToken,
      'favoritesPeople': favoritesPeople
    };
  }

  MyUser.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        email = map['email'],
        username = map['username'],
        userToken = map['userToken'],
        favoritesPeople = map['favoritesPeople'];

  @override
  String toString() {
    return 'User  {userID: $id, email: $email, username: $username, userToken: $userToken, favoritesPeople: $favoritesPeople } ';
  }
}
