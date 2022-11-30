class User {
  final String name;
  final String roomId;

  User({required this.name, required this.roomId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      roomId: json['roomId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'roomId': roomId,
    };
  }
}
