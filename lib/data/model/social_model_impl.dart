import 'dart:io';

import 'package:social_media_application/data/model/authentication_model.dart';
import 'package:social_media_application/data/model/authentication_model_impl.dart';
import 'package:social_media_application/data/model/social_model.dart';
import 'package:social_media_application/data/vos/news_feed_vo.dart';
import 'package:social_media_application/network/data_agent/cloud_firestore_data_agent_impl.dart';
import 'package:social_media_application/network/data_agent/realtime_database_data_agent_impl.dart';
import 'package:social_media_application/network/data_agent/social_data_agent.dart';

class SocialModelImpl extends SocialModel {
  SocialModelImpl._internal();

  static final SocialModelImpl _singleton =
  SocialModelImpl._internal();

  factory SocialModelImpl() => _singleton;

   //final SocialDataAgent _socialDataAgent=RealTimeDataBaseDataAgentImpl();
  final SocialDataAgent _socialDataAgent = CloudFireStoreDataAgentImpl();
  final AuthenticationModel _authenticationModel=AuthenticationModelImpl();
  @override
  Stream<List<NewsFeedVO>> getNewsFeed() => _socialDataAgent.getNewsFeed();

  @override
  Future<void> addNewPost(String description, File? imageFile) {
    if (imageFile != null) {
      return _socialDataAgent
          .uploadFileToFirebase(imageFile)
          .then((downloadURL) => _createPost(description, downloadURL))
          .then((newPost) => _socialDataAgent.addNewPost(newPost));
    } else {
      return _createPost(description, '')
          .then((newPost) => _socialDataAgent.addNewPost(newPost));
    }
  }

  Future<NewsFeedVO> _createPost(String description, String imageURL) {
    String url = imageURL.isEmpty
        ? 'https://www.chanchao.com.tw/images/default.jpg'
        : imageURL;
    int dateTime = DateTime.now().millisecond;
    var newsFeedVO = NewsFeedVO(dateTime, _authenticationModel.getLoggedInUser().userName, description, url,
        'https://st3.depositphotos.com/5392356/13703/i/1600/depositphotos_137037020-stock-photo-professional-software-developer-working-in.jpg');
    return Future.value(newsFeedVO);
  }

  @override
  Future<void> deletePost(int postID) => _socialDataAgent.delete(postID);

  @override
  Stream<NewsFeedVO> getNewsFeedByID(int newsFeedID) =>
      _socialDataAgent.getNewsFeedByID(newsFeedID);

  @override
  Future<void> editPost(NewsFeedVO newsFeedVO, File? imageFile) {
    if (imageFile != null) {
      return _socialDataAgent
          .uploadFileToFirebase(imageFile)
          .then((downloadURL) => _createPost(newsFeedVO.description.toString(), downloadURL))
          .then((newPost) => _socialDataAgent.addNewPost(newPost));
    } else {
      return  _socialDataAgent.addNewPost(newsFeedVO);
    }
  }

}
