import 'package:flutter/foundation.dart';

class NavigatorController extends ChangeNotifier {

  bool canNavigatePrev = false;
  bool canNavigateNext = true;

  bool _processing = false;


  bool get processing => _processing;


  set processing(bool value) {
    _processing = value;
    notifyListeners();
  }


  void onEnd() {
    canNavigatePrev = true;
    canNavigateNext = false;
  }


  void onStart() {
    canNavigatePrev = false;
    canNavigateNext = true;
  }


  void onChanged() {
    canNavigatePrev = true;
    canNavigateNext = true;
  }


  void reset() {
    canNavigatePrev = false;
    canNavigateNext = true;
  }

}