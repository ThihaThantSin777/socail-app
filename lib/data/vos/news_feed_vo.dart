
import 'package:json_annotation/json_annotation.dart';

part 'news_feed_vo.g.dart';


@JsonSerializable()
class NewsFeedVO{

  @JsonKey(name: 'id')
  int ?id;

  @JsonKey(name: 'user_name')
  String ?userName;

  @JsonKey(name: 'description')
  String?description;

  @JsonKey(name: 'post_image')
  String ?postImage;

  @JsonKey(name: 'profile_picture')
  String?profilePicture;

  NewsFeedVO.normal();
  NewsFeedVO(this.id, this.userName, this.description, this.postImage,
      this.profilePicture);
  NewsFeedVO.fromMap(Map<dynamic, dynamic> map): id = map['id'],userName = map['user_name'],description = map['description'],postImage = map['post_image'],profilePicture = map['profile_picture'];

  @override
  String toString() {
    return 'NewsFeedVO{id: $id, userName: $userName, description: $description, postImage: $postImage, profilePicture: $profilePicture}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsFeedVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userName == other.userName &&
          description == other.description &&
          postImage == other.postImage &&
          profilePicture == other.profilePicture;

  @override
  int get hashCode =>
      id.hashCode ^
      userName.hashCode ^
      description.hashCode ^
      postImage.hashCode ^
      profilePicture.hashCode;


  factory NewsFeedVO.fromJson(Map<String,dynamic>json)=>_$NewsFeedVOFromJson(json);


  Map<String,dynamic>toJson()=>_$NewsFeedVOToJson(this);
}


