import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class FirebaseRemoteConfig {
  static final FirebaseRemoteConfig _singleton =
      FirebaseRemoteConfig._internal();

  FirebaseRemoteConfig._internal() {
    initializeRemoteConfig();
    _remoteConfig.fetchAndActivate();
  }

  factory FirebaseRemoteConfig() => _singleton;

  final RemoteConfig _remoteConfig = RemoteConfig.instance;

  void initializeRemoteConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 1),
        minimumFetchInterval: const Duration(seconds: 1)));
  }

  MaterialColor getThemeColorFromRemoteConfig(){
    String color=_remoteConfig.getString(remoteConfigThemeColor);
    String defaultColor='0xFF000000';
    return MaterialColor(
      int.parse(color.isEmpty?defaultColor:color),
      const {},
    );
  }
}


const String remoteConfigThemeColor='theme_color';
