import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_vo.g.dart';

@JsonSerializable()
class UserVO {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'userName')
  String? userName;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'password')
  String? password;

  UserVO(this.id, this.userName, this.email, this.password);

  @override
  String toString() {
    return 'UserVO{id: $id, userName: $userName, email: $email, password: $password}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userName == other.userName &&
          email == other.email &&
          password == other.password;

  @override
  int get hashCode =>
      id.hashCode ^ userName.hashCode ^ email.hashCode ^ password.hashCode;
  factory UserVO.fromJson(Map<String,dynamic>json)=>_$UserVOFromJson(json);

  Map<String,dynamic>toJson()=>_$UserVOToJson(this);

}
