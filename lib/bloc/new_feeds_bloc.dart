import 'package:flutter/material.dart';
import 'package:social_media_application/analytics/firebase_analytics_tracker.dart';
import 'package:social_media_application/data/model/authentication_model.dart';
import 'package:social_media_application/data/model/authentication_model_impl.dart';
import 'package:social_media_application/data/model/social_model.dart';
import 'package:social_media_application/data/model/social_model_impl.dart';

import '../data/vos/news_feed_vo.dart';

class NewsFeedBloc extends ChangeNotifier{
  List<NewsFeedVO>?newsFeed;

  final SocialModel _socialModel=SocialModelImpl();
  final AuthenticationModel _authenticationModel=AuthenticationModelImpl();

  bool isDisposed=false;

  NewsFeedBloc(){
    _socialModel.getNewsFeed().listen((event) {
      newsFeed=event;
      if(!isDisposed){
        notifyListeners();
      }
    });
    _sendAnalyticsData();
  }

  void delete(int postID){
    _socialModel.deletePost(postID);

  }
  Future logout(){
    return _authenticationModel.logOut();
  }
void _sendAnalyticsData()async{
    await FireBaseAnalyticsTracker().logEvent(homeScreenReached, null);
}
  @override
  void dispose(){
    super.dispose();
    isDisposed=true;
  }
}