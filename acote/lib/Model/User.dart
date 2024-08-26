class User {
  final String login;
  final int id;
  final String avatarUrl;

  User({required this.login, required this.id, required this.avatarUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      id: json['id'],
      avatarUrl: json['avatar_url'],
    );
  }
}
