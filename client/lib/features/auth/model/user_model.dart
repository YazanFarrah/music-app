import 'package:client/config/json_constants.dart';
import 'package:client/core/enums/gender.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String password;
  final String birthday;
  final Gender gender;
  final String? token;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.birthday,
    required this.gender,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json[UserModelConstants.id],
      name: json[UserModelConstants.name] ?? "",
      email: json[UserModelConstants.email] ?? "",
      password: json[UserModelConstants.password] ?? "",
      birthday: json[UserModelConstants.birthday] ?? "",
      gender: Gender.values.firstWhere(
        (e) => e.toString().split('.').last == json[UserModelConstants.gender],
        orElse: () => Gender.male,
      ),
      token: json[UserModelConstants.token],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      UserModelConstants.name: name,
      UserModelConstants.email: email,
      UserModelConstants.password: password,
      UserModelConstants.birthday: birthday,
      UserModelConstants.gender: gender.toString().split('.').last,
    };
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? birthday,
    Gender? gender,
    String? token,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      token: token ?? this.token,
    );
  }

  @override
  String toString() {
    return 'UserModel{name: $name, email: $email, password: $password, birthday: $birthday, gender: $gender}';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.password == password &&
        other.birthday == birthday &&
        other.gender == gender;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        birthday.hashCode ^
        gender.hashCode;
  }
}
