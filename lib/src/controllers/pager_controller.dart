
import 'package:flutter/cupertino.dart';
import 'package:json_form_builder/src/utils/utils.dart';

class PagerController {

  late final PageController controller;
  late final List<PageController> nestedControllers;
  final ScrollController? pageScrollController;
  final Function(bool, int, int)? onChanged;
  final VoidCallback? onChildPrev;
  final VoidCallback? onChildNext;
  final VoidCallback? onPageEnd;

  PagerController({
    required this.controller,
    required this.nestedControllers,
    this.pageScrollController,
    this.onChanged,
    this.onPageEnd,
    this.onChildNext,
    this.onChildPrev,
  });


  PageController get currentChildController => nestedControllers[currentPage];
  int get currentPage => controller.page?.toInt() ?? 0;
  int get currentChildPage => currentChildController.page?.toInt() ?? 0;
  int get pageCount => Utils.calculateCount(controller.positions);
  int get childPageCount => Utils.calculateCount(currentChildController.positions);


  void nextPage() => _changeChildPage(next: true);

  void prevPage() => _changeChildPage(next: false);


  void _changeChildPage({bool next = true}) {

    if (next) {
      if (currentChildPage < childPageCount) {
        _changePage(currentChildController, true);
        onChildNext?.call();
      } else {
        _changeParentPage(next: true);
      }
    } else {
      if (currentChildPage > 0) {
        _changePage(currentChildController, false);
        onChildPrev?.call();
      } else {
        _changeParentPage(next: false);
      }
    }
    pageScrollController?.animateTo(0, duration: const Duration(milliseconds: 320), curve: Curves.fastOutSlowIn);

  }


  void _changeParentPage({bool next = true}) => _changePage(controller, next);


  void _changePage(PageController controller, bool isNext) async {
    final pageMethod = isNext ? controller.nextPage : controller.previousPage;
    await pageMethod(duration: const Duration(milliseconds: 320), curve: Curves.fastOutSlowIn);
    _onPageChanged(isNext);
  }


  void _onPageChanged(bool isNext) {

    onChanged?.call(isNext, currentChildPage, currentPage);

    if (4 == currentPage + 1 && childPageCount + 1 == currentChildPage + 1) {
      onPageEnd?.call();
    }

  }




  void dispose() {
    controller.dispose();
    for (var c in nestedControllers) {
      c.dispose();
    }
  }


}
