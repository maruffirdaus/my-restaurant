import 'package:flutter/cupertino.dart';

class NavIndexProvider extends ChangeNotifier {
  int _navIndex = 0;
  int get navIndex => _navIndex;
  set navIndex(int value) {
    _navIndex = value;
    notifyListeners();
  }
}
