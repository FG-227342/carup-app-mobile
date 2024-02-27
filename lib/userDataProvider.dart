import 'package:carup/Model/UserData.dart';
import 'package:flutter/cupertino.dart';

class userDataProvider with ChangeNotifier{
  UserData _userData = new UserData();

  UserData get data => _userData;

  void set(UserData user){
    _userData = user;
    notifyListeners();
  }
}