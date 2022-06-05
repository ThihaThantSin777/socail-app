
import 'package:social_media_application/data/model/authentication_model.dart';
import 'package:social_media_application/data/vos/user_vo.dart';
import 'package:social_media_application/network/data_agent/realtime_database_data_agent_impl.dart';
import 'package:social_media_application/network/data_agent/social_data_agent.dart';

import '../../network/data_agent/cloud_firestore_data_agent_impl.dart';

class AuthenticationModelImpl extends AuthenticationModel{
  final SocialDataAgent _socialDataAgent=RealTimeDataBaseDataAgentImpl();
  //final SocialDataAgent _socialDataAgent=CloudFireStoreDataAgentImpl();
  @override
  UserVO getLoggedInUser() {
    return _socialDataAgent.getLoggedInUser();
  }

  @override
  bool isLoggedIn() {
    return _socialDataAgent.isLoggedIn();
  }

  @override
  Future<void> logOut() {
   return _socialDataAgent.logout();
  }

  @override
  Future<void> login(String email, String password) {
   return _socialDataAgent.login(email, password);
  }

  @override
  Future<void> register(String email, String userName, String password) {
   return _craftUserVO(email, userName, password).then((user) => _socialDataAgent.registerNewUser(user));
  }

  Future<UserVO>_craftUserVO(String email,String userName,String password){
    var newUser=UserVO('', userName, email, password);
    return Future.value(newUser);
  }

}