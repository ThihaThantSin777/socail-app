import 'package:flutter/material.dart';
import 'package:social_media_application/data/model/authentication_model.dart';
import 'package:social_media_application/data/model/authentication_model_impl.dart';

class RegisterBloc extends ChangeNotifier{
  bool isLoading=false;
  String email="";
  String password="";
  String userName="";
  bool isDisposed=false;



  ///Model
  final AuthenticationModel _authenticationModel=AuthenticationModelImpl();
  Future onTapRegister(){
    _showLoading();
    return _authenticationModel.register(email, userName, password).whenComplete(() => _hideLoading());
  }

  void onEmailChange(String email){
    this.email=email;
    _notifySafely();
  }
  void onUserNameChange(String userName){
    this.userName=userName;
    _notifySafely();
  }

  void onPasswordChange(String password){
    this.password=password;
    _notifySafely();
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