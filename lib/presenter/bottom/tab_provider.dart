import 'package:flutter/cupertino.dart';

class TabProvider extends ChangeNotifier{
  int _currIndex = 0;

  int get currIndex => _currIndex;

  void setTabIndex(int index){
    _currIndex = index;
    notifyListeners();
  }
}