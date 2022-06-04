import 'dart:io';

import 'package:social_media_application/data/vos/news_feed_vo.dart';
import 'package:social_media_application/data/vos/user_vo.dart';

abstract class SocialDataAgent{
  Stream<List<NewsFeedVO>> getNewsFeed();
  Future<void> addNewPost(NewsFeedVO newsFeedVO);
  Future<void>delete(int postID);
  Stream<NewsFeedVO>getNewsFeedByID(int newsFeedID);
  Future<String>uploadFileToFirebase(File image);

  ///Auth
  Future registerNewUser(UserVO newUser);
  Future login(String email,String password);
  bool isLoggedIn();
  UserVO getLoggedInUser();
  Future logout();
}