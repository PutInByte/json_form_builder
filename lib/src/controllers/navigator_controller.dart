import 'package:flutter/foundation.dart';

class NavigatorController extends ChangeNotifier {

  bool _canNavigatePrev = false;
  bool _canNavigateNext = true;

  bool _processing = false;


  bool get canNavigatePrev => _canNavigatePrev;
  bool get canNavigateNext => _canNavigateNext;
  bool get processing => _processing;


  set canNavigateNext(bool value) {
    _canNavigateNext = value;
    notifyListeners();
  }


  set canNavigatePrev(bool value) {
    _canNavigatePrev = value;
    notifyListeners();
  }


  set processing(bool value) {
    _processing = value;
    notifyListeners();
  }


  void onEnd() {
    _canNavigatePrev = true;
    _canNavigateNext = false;
  }


  void onStart() {
    _canNavigatePrev = false;
    _canNavigateNext = true;
  }


  void onProcessing() {
    _canNavigatePrev = false;
    _canNavigateNext = false;
  }


  void onChanges() {
    _canNavigatePrev = true;
    _canNavigateNext = true;
  }


  void reset() {
    _canNavigatePrev = false;
    _canNavigateNext = true;
  }

}