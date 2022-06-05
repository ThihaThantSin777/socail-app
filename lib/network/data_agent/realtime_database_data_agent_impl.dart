import 'dart:collection';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_application/data/vos/news_feed_vo.dart';
import 'package:social_media_application/data/vos/user_vo.dart';
import 'package:social_media_application/network/data_agent/social_data_agent.dart';

const newsFeedPath = 'newsfeed';
const userPath = 'users';
const fileUploadPath = 'uploads';

class RealTimeDataBaseDataAgentImpl extends SocialDataAgent {
  RealTimeDataBaseDataAgentImpl._internal();

  static final RealTimeDataBaseDataAgentImpl _singleton =
      RealTimeDataBaseDataAgentImpl._internal();

  factory RealTimeDataBaseDataAgentImpl() => _singleton;

  ///Database
  var databaseRef = FirebaseDatabase.instance.reference();

  ///Storage
  var firebaseStorage = FirebaseStorage.instance;

  ///Auth
  var auth = FirebaseAuth.instance;

  @override
  Stream<List<NewsFeedVO>> getNewsFeed() {
    return databaseRef.child(newsFeedPath).onValue.map((event) {
      return event.snapshot.value.values.map<NewsFeedVO>((element){
        return NewsFeedVO.fromJson(Map<String,dynamic>.from(element));
      }).toList();
    });



    // return databaseRef.child(newsFeedPath).onValue.map((event) {
    //   List<NewsFeedVO> temp = [];
    //   event.snapshot.value.forEach((element) {
    //     Map map = element as LinkedHashMap;
    //     NewsFeedVO newsFeedVO = NewsFeedVO.fromMap(map);
    //     temp.add(newsFeedVO);
    //   });
    //   return temp;
    // });
  }

  @override
  Future<void> addNewPost(NewsFeedVO newsFeedVO) {
    return databaseRef
        .child(newsFeedPath)
        .child(newsFeedVO.id.toString())
        .set(newsFeedVO.toJson());
  }

  @override
  Future<void> delete(int postID) {
    return databaseRef.child(newsFeedPath).child(postID.toString()).remove();
  }

  @override
  Stream<NewsFeedVO> getNewsFeedByID(int newsFeedID) {
    return databaseRef
        .child(newsFeedPath)
        .child(newsFeedID.toString())
        .once()
        .asStream()
        .map((event) {
      return NewsFeedVO.fromJson(Map<String, dynamic>.from(event.value));
    });
  }

  @override
  Future<String> uploadFileToFirebase(File image) {
    return firebaseStorage
        .ref(fileUploadPath)
        .child('${DateTime.now().millisecondsSinceEpoch}')
        .putFile(image)
        .then((takeSnapShot) => takeSnapShot.ref.getDownloadURL());
  }

  @override
  UserVO getLoggedInUser() {
    return UserVO(
        auth.currentUser?.uid.toString(),
        auth.currentUser?.displayName.toString(),
        auth.currentUser?.email.toString(),
        '');
  }

  @override
  bool isLoggedIn() {
    return auth.currentUser != null;
  }

  @override
  Future login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future logout() {
   return auth.signOut();
  }

  @override
  Future registerNewUser(UserVO newUser) => auth
          .createUserWithEmailAndPassword(
              email: newUser.email ?? '', password: newUser.password ?? '')
          .then((credential) {
        credential.user
          ?..updateDisplayName(newUser.userName).then((value) {
            final User? user = auth.currentUser;
            newUser.id = user?.uid;
            _addNewUser(newUser);
          });
      });

  Future<void> _addNewUser(UserVO newUser) {
    return databaseRef
        .child(userPath)
        .child(newUser.id.toString())
        .set(newUser.toJson());
  }
}
