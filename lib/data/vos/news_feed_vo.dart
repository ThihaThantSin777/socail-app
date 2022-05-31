
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

  NewsFeedVO(this.id, this.userName, this.description, this.postImage,
      this.profilePicture);

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
}


