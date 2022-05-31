 import 'package:firebase_database/firebase_database.dart';
import 'package:social_media_application/data/vos/news_feed_vo.dart';

abstract class RealTimeDatabaseModel{
   Stream<List<NewsFeedVO>> getNewsFeed();
   Stream<DatabaseEvent>test();
}