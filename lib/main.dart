

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_installations/firebase_installations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_application/data/model/authentication_model_impl.dart';
import 'package:social_media_application/fcm/fcm_service.dart';
import 'package:social_media_application/pages/news_feed_page.dart';
import 'package:social_media_application/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FCMService().listenForMessage();

  var firebaseInstalledID=await FirebaseInstallations.id;
  debugPrint('Firebase install ID ===================> $firebaseInstalledID');
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final _auth=AuthenticationModelImpl();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.ubuntu().fontFamily),
      home: (_auth.isLoggedIn())?const NewsFeedPage(): LoginPage(),
    );
  }
}
