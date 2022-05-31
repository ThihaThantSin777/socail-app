import 'package:firebase_database/firebase_database.dart';
import 'package:social_media_application/data/vos/news_feed_vo.dart';
import 'package:social_media_application/network/data_agent/social_data_agent.dart';



const newsFeedPath='newsfeed';


class RealTimeDataBaseDataAgentImpl extends SocialDataAgent{


  RealTimeDataBaseDataAgentImpl._internal();
  static final RealTimeDataBaseDataAgentImpl _singleton=RealTimeDataBaseDataAgentImpl._internal();

  factory RealTimeDataBaseDataAgentImpl ()=>_singleton;


  ///Database
  var databaseRef=FirebaseDatabase.instance.reference();

  @override
  Stream<List<NewsFeedVO>> getNewsFeed() {
    // TODO: implement getNewsFeed
    throw UnimplementedError();
  }

  @override
  Stream<DatabaseEvent> test() =>databaseRef.onValue;


}