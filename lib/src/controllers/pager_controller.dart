import 'package:flutter/material.dart';
import 'package:json_form_builder/src/controllers/navigator_controller.dart';
import 'package:json_form_builder/src/core/utils/api_utils.dart';
import 'package:json_form_builder/src/core/utils/pager_utils.dart';

class PagerController extends ChangeNotifier {


  final NavigatorController navigator = NavigatorController();
  final PageController pageController = PageController(initialPage: 0, keepPage: true);
  final Map<int, PageController> _nestedPageControllers = { };


  VoidCallback? onChanged;
  VoidCallback? onStart;
  VoidCallback? onEnd;
  OnNextServerSide? onNextServerSide;
  

  int get currentPage => PagerUtils.getCurrentPage( pageController );

  int get currentChildPage => PagerUtils.getCurrentPage( _getNestedPageController(currentPage) );

  int get pageCount => PagerUtils.calculatePageCount( pageController );

  int get childPageCount => PagerUtils.calculatePageCount(_getNestedPageController( currentPage ));


  bool _isChangingPage = false;


  Future<void> changePage({ bool next = true }) async {

    if (_isChangingPage) return;

    _isChangingPage = true;

    final PageController controller = _getNestedPageController( currentPage );


    if (onNextServerSide != null && next) await _onPageNextServerSide();


    if ( (PagerUtils.isMinExtent(controller) && !next) || (PagerUtils.isMaxExtent(controller) && next) ) {
      await PagerUtils.changePage(pageController, next);
    }
    else {
      if (!PagerUtils.canForward(controller, next)) return;
      await PagerUtils.changePage(controller, next);
    }

    _onPageChanged( currentPage );

    if ( PagerUtils.isMaxExtent(controller) && PagerUtils.isMaxExtent(pageController) ) {
      _onPageEnd();
    }
    else if ( currentChildPage == 0 && PagerUtils.isMinExtent(pageController) ) {
      _onPageStart();
    }

    Future.delayed( const Duration(milliseconds: 300), () => _isChangingPage = false );

  }


  PageController getChildPageController( int index ) => _getNestedPageController(index);


  PageController _getNestedPageController( int pageIndex ) {
    return _nestedPageControllers.putIfAbsent(pageIndex, () => PageController(keepPage: true, initialPage: 0));
  }


  void _onPageChanged( int index ) {
    navigator.onChanges();
    onChanged?.call();
  }


  void _onPageStart() {
    debugPrint('page_start triggered');
    navigator.onStart();
    onStart?.call();
  }


  void _onPageEnd() {
    debugPrint('page_end triggered');
    navigator.onEnd();
    onEnd?.call();
  }


  Future<void> _onPageNextServerSide() async {
    debugPrint('page_next_server_side triggered');

    navigator.processing = true;

    await onNextServerSide?.call();

    navigator.processing = false;

  }


  @override
  void dispose() {
    pageController.dispose();
    for (PageController controller in _nestedPageControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

}