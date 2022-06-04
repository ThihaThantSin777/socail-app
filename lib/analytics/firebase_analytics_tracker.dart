
import 'package:firebase_analytics/firebase_analytics.dart';

const homeScreenReached='home_screen_reached';
const addNewPostScreenReached='add_new_post_screen_reached';
const addNewPostAction='add_new_post_action';
const editPostAction='edit_post_action';


const postID='post_id';

class FireBaseAnalyticsTracker{
  FireBaseAnalyticsTracker.internal();
  static final FireBaseAnalyticsTracker _singleton=FireBaseAnalyticsTracker.internal();

  factory FireBaseAnalyticsTracker()=>_singleton;



  final FirebaseAnalytics analytics=FirebaseAnalytics.instance;

  Future logEvent(String name,Map<String,dynamic>?parameters){
    return analytics.logEvent(name: name,parameters: parameters);
  }
}