import 'dart:io';

import 'package:social_media_application/data/vos/news_feed_vo.dart';

abstract class SocialModel{
   Stream<List<NewsFeedVO>> getNewsFeed();
   Future<void> addNewPost(String description,File? imageFile);
   Future<void>editPost(NewsFeedVO newsFeedVO,File? imageFile);
   Future<void>deletePost(int postID);
   Stream<NewsFeedVO>getNewsFeedByID(int newsFeedID);
}