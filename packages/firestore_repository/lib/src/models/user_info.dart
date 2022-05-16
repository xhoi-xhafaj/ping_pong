import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  final String username;
  final String email;

  const UserInfo({required this.username, required this.email});

  factory UserInfo.fromSnapshot(Map<String, dynamic> doc) {
    UserInfo userInfo = UserInfo(
      username: doc["username"] ?? "",
      email: doc["email"] ?? "",
    );
    return userInfo;
  }

  static const empty = UserInfo(
    username: "",
    email: "",
  );

  @override
  List<Object?> get props => [username, email];
}
