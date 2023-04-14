import 'package:flutter/material.dart';
import 'package:json_form_builder/src/controllers/navigator_controller.dart';
import 'package:json_form_builder/src/utils/utils.dart';

class PagerController extends ChangeNotifier {

  final NavigatorController navigator = NavigatorController();
  final PageController pageController = PageController(initialPage: 0, keepPage: true);
  final Map<int, PageController> _nestedPageControllers = { };


  VoidCallback? onChanged;
  VoidCallback? onStart;
  VoidCallback? onEnd;


  bool _isChangingPage = false;

  int get currentPage => Utils.getCurrentPage(pageController);

  int get currentChildPage => Utils.getCurrentPage(_getNestedPageController(currentPage));

  int get pageCount => Utils.calculatePageCount(pageController);

  int get childPageCount => Utils.calculatePageCount(_getNestedPageController(currentPage));


  Future<void> changePage({ bool next = true }) async {

    if (_isChangingPage) return;

    _isChangingPage = true;

    final controller = currentChildPage < childPageCount ? _getNestedPageController(currentPage) : pageController;
    final forward = next ? currentPage < controller.positions.last.maxScrollExtent : currentPage > controller.positions.first.minScrollExtent;

    if (!forward) return;

    await Utils.changePage(controller, next);

    if (controller.position.pixels == controller.position.maxScrollExtent) _onPageEnd();
    else if (controller.position.pixels == controller.position.minScrollExtent) _onPageStart();
    else _onPageChanged(currentPage);

    _isChangingPage = false;

  }


  PageController getChildPageController(int index) => _getNestedPageController(index);


  PageController _getNestedPageController(int pageIndex) {
    return _nestedPageControllers.putIfAbsent(pageIndex, () => PageController(keepPage: true, initialPage: 0));
  }


  void _onPageChanged(int index) {
    debugPrint("onPageChanged($index);");
    navigator.onChanges();
    onChanged?.call();
  }


  void _onPageStart() {
    debugPrint("onPageStart();");
    navigator.onStart();
    onStart?.call();
  }


  void _onPageEnd() {
    debugPrint("onPageEnd();");
    navigator.onEnd();
    onEnd?.call();
  }


  @override
  void dispose() {
    pageController.dispose();
    for (var controller in _nestedPageControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

}