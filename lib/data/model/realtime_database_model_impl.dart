import 'package:firebase_database/firebase_database.dart';
import 'package:social_media_application/data/model/realtime_database_model.dart';
import 'package:social_media_application/data/vos/news_feed_vo.dart';
import 'package:social_media_application/network/data_agent/realtime_database_data_agent_impl.dart';
import 'package:social_media_application/network/data_agent/social_data_agent.dart';

class RealTimeDatabaseModelImpl extends RealTimeDatabaseModel{
  RealTimeDatabaseModelImpl._internal();
  static final RealTimeDatabaseModelImpl _singleton=RealTimeDatabaseModelImpl._internal();

  factory RealTimeDatabaseModelImpl()=>_singleton;

  final SocialDataAgent _socialDataAgent=RealTimeDataBaseDataAgentImpl();
  @override
  Stream<List<NewsFeedVO>> getNewsFeed() {
    // TODO: implement getNewsFeed
    throw UnimplementedError();
  }

  @override
  Stream<DatabaseEvent> test() =>_socialDataAgent.test();

}