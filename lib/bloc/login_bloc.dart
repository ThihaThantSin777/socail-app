import 'package:flutter/material.dart';
import 'package:social_media_application/data/model/authentication_model.dart';
import 'package:social_media_application/data/model/authentication_model_impl.dart';

class LoginBloc extends ChangeNotifier{
  bool isLoading=false;
  String email="";
  String password="";
  bool isDisposed=false;

  ///Model
  final AuthenticationModel _authenticationModel=AuthenticationModelImpl();
  Future onTapLogin(){
  _showLoading();
  return _authenticationModel.login(email, password).whenComplete( ()=> _hideLoading());
  }

void onEmailChange(String email){
  this.email=email;
}


void onPasswordChange(String password){
  this.password=password;
}

void _showLoading(){
  isLoading=true;
  _notifySafely();
}

  void _hideLoading(){
    isLoading=false;
    _notifySafely();
  }

void _notifySafely(){
  if(!isDisposed){
    notifyListeners();
  }
}
  @override
  void dispose() {
    super.dispose();
    isDisposed = true;
  }
}