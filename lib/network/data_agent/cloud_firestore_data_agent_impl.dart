import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_application/data/vos/news_feed_vo.dart';
import 'package:social_media_application/data/vos/user_vo.dart';
import 'package:social_media_application/network/data_agent/social_data_agent.dart';

const newsFeedCollection = 'newsfeed';
const fileUploadPath = 'uploads';
const userCollection = 'users';

class CloudFireStoreDataAgentImpl extends SocialDataAgent {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  var firebaseStorage = FirebaseStorage.instance;
  var auth = FirebaseAuth.instance;

  @override
  Future<void> addNewPost(NewsFeedVO newsFeedVO) => _firebaseFirestore
      .collection(newsFeedCollection)
      .doc(newsFeedVO.id.toString())
      .set(newsFeedVO.toJson());

  @override
  Future<void> delete(int postID) => _firebaseFirestore
      .collection(newsFeedCollection)
      .doc(postID.toString())
      .delete();

  @override
  Stream<List<NewsFeedVO>> getNewsFeed() => _firebaseFirestore
          .collection(newsFeedCollection)
          .snapshots()
          .map((querySnapShot) {
        return querySnapShot.docs.map<NewsFeedVO>((document) {
          return NewsFeedVO.fromJson(document.data());
        }).toList();
      });

  @override
  Stream<NewsFeedVO> getNewsFeedByID(int newsFeedID) => _firebaseFirestore
      .collection(newsFeedCollection)
      .doc(newsFeedID.toString())
      .get()
      .asStream()
      .where((documentSnapShot) => documentSnapShot != null)
      .map((documentSnapShot) => NewsFeedVO.fromJson(documentSnapShot.data()!));

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
          ?..updateDisplayName(newUser.userName).then((user) {
            final User? user = auth.currentUser;
            print(user?.uid);
            newUser.id = user?.uid;
            _addNewUser(newUser);
          });
      });

  Future<void> _addNewUser(UserVO newUser) {
    return _firebaseFirestore
        .collection(userCollection)
        .doc(newUser.id.toString())
        .set(newUser.toJson());
  }
}
