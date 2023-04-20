import 'package:flutter/material.dart';
import 'package:json_form_builder/src/controllers/navigator_controller.dart';
import 'package:json_form_builder/src/controllers/panel_controller.dart';
import 'package:json_form_builder/src/core/utils/pager_utils.dart';
import 'package:json_form_builder/src/core/utils/typedefs.dart';


class PagerController extends ChangeNotifier {


  final NavigatorController navigator = NavigatorController();
  final PanelController panelController = PanelController();
  final PageController pageController = PageController(initialPage: 0, keepPage: true);
  final Map<int, PageController> _nestedPageControllers = { };


  ChangedEvent? onChanged;
  VoidCallback? onStart;
  VoidCallback? onEnd;
  ServerSideEvent? serverSideEvent;
  

  int get currentPage => PagerUtils.getCurrentPage( pageController );

  int get currentChildPage => PagerUtils.getCurrentPage( _getOrPutNestedPageController(currentPage) );

  int get pageCount => PagerUtils.calculatePageCount( pageController );

  int get childPageCount => PagerUtils.calculatePageCount( _getOrPutNestedPageController( currentPage ) );


  bool _isChangingPage = false;


  Future<void> changePage({ bool next = true }) async {

    if (_isChangingPage) return;

    _isChangingPage = true;

    final PageController controller = _getOrPutNestedPageController( currentPage );


    if (serverSideEvent != null && next) await _onPageNextServerSide();


    if ( (PagerUtils.isMinExtent(controller) && !next) || (PagerUtils.isMaxExtent(controller) && next) ) {
      await PagerUtils.changePage(pageController, next);
    }
    else {
      if (!PagerUtils.canForward(controller, next)) return;
      await PagerUtils.changePage(controller, next);
    }

    _onPageChanged( currentPage );

    if ( currentChildPage == childPageCount && PagerUtils.isMaxExtent(pageController) ) {
      _onPageEnd();
    }
    else if ( currentChildPage == 0 && PagerUtils.isMinExtent(pageController) ) {
      _onPageStart();
    }

    Future.delayed( const Duration(milliseconds: 300), () => _isChangingPage = false );

  }


  PageController getChildPageController( int index ) => _getOrPutNestedPageController(index);


  PageController _getOrPutNestedPageController( int pageIndex ) {
    return _nestedPageControllers.putIfAbsent(pageIndex, () => PageController(keepPage: true, initialPage: 0));
  }


  void _onPageChanged( int index ) {
    navigator.onChanged();
    panelController.onChangedPager(index);
    onChanged?.call(index);
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

    await serverSideEvent?.call();

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