import 'package:flutter/material.dart';

class ServiceRefreshProvider with ChangeNotifier{
  bool _data = false;

  bool get(){
    return _data;
  }
  void actualizar(){
    if(_data){
      _data = false;
    } else{
      _data = true;
    }
    notifyListeners();
  }
}