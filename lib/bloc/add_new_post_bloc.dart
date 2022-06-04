import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_application/analytics/firebase_analytics_tracker.dart';
import 'package:social_media_application/data/model/authentication_model.dart';
import 'package:social_media_application/data/model/authentication_model_impl.dart';
import 'package:social_media_application/data/model/social_model.dart';
import 'package:social_media_application/data/model/social_model_impl.dart';
import 'package:social_media_application/data/vos/news_feed_vo.dart';
import 'package:social_media_application/data/vos/user_vo.dart';
import 'package:social_media_application/remote_config/firebase_remote_config.dart';

class AddNewPostBloc extends ChangeNotifier {
  String _postText = '';
  bool isAddNewPoster = false;
  bool isDisposed = false;
  bool isInEditMode = false;
  String userName = '';
  String profilePicture = '';
  NewsFeedVO? newsFeedVO;
  File? chooseImageFile;
  bool isLoading = false;
  UserVO? loggInUserVO;
  Color themeColor=Colors.black;

  final SocialModel _socialModel=SocialModelImpl();
  final AuthenticationModel _authenticationModel=AuthenticationModelImpl();


  set setPostText(String postText) => _postText = postText;

  String get getPostText => _postText;

  Future<void> addPost() {
    if (getPostText.isEmpty) {
      isAddNewPoster = true;
      _notifySafely();
      return Future.error('Error');
    }else{
      isLoading = true;
      _notifySafely();
      isAddNewPoster = false;
      if (isInEditMode) {
        return _editNewsFeedPost().then((value) {
          isLoading = false;
          _notifySafely();
          _sendAnalyticsData(editPostAction, {postID:newsFeedVO?.id.toString()??''});
        });
      } else {
        return _createNewsFeedsPost().then((value) {
          isLoading = false;
          _notifySafely();
          _sendAnalyticsData(addNewPostAction, null);
        });
      }
    }

  }

  Future<void> _editNewsFeedPost() {
    newsFeedVO?.description = getPostText;
    if (newsFeedVO != null) {
      return _socialModel.editPost(newsFeedVO!, chooseImageFile);
    }
    return Future.error('error');
  }

  Future<void> _createNewsFeedsPost() {
    return _socialModel.addNewPost(getPostText, chooseImageFile);
  }

  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }

  void onImageChoose(File imageFile) {
    chooseImageFile = imageFile;
    print('Save file $imageFile');
    _notifySafely();
  }

  void onTapDeleteImage() {
    chooseImageFile = null;
    _notifySafely();
  }

  void _prepopulateForAddPost() {
    profilePicture =
        'https://st3.depositphotos.com/5392356/13703/i/1600/depositphotos_137037020-stock-photo-professional-software-developer-working-in.jpg';
    userName = loggInUserVO?.userName.toString()??"Un Known";
    _notifySafely();
  }

  void _getRemoteConfigAndChangeTheme(){
    themeColor=FirebaseRemoteConfig().getThemeColorFromRemoteConfig();
    _notifySafely();
  }

  void _prePopulateForEditPost(int newsFeedID) {
    _socialModel.getNewsFeedByID(newsFeedID).listen((event) {
      profilePicture = event.profilePicture ??
          'https://st3.depositphotos.com/5392356/13703/i/1600/depositphotos_137037020-stock-photo-professional-software-developer-working-in.jpg';
      userName = event.userName ?? 'Thiha Thant Sin';
      setPostText = event.description ?? '';
      newsFeedVO = event;
      _notifySafely();
    });
  }

  AddNewPostBloc({int? newsFeedID}) {
    loggInUserVO=_authenticationModel.getLoggedInUser();
    if (newsFeedID != null) {
      isInEditMode = true;
      _prePopulateForEditPost(newsFeedID);
    } else {
      _prepopulateForAddPost();
    }
    _sendAnalyticsData(addNewPostScreenReached, null);
   // _getRemoteConfigAndChangeTheme();
  }
void _sendAnalyticsData(String name,Map<String,String>?parameters)async{
    await FireBaseAnalyticsTracker().logEvent(name, parameters);
}
  _notifySafely() {
    if (!isDisposed) {
      notifyListeners();
    }
  }
}
