
import 'dart:math';

import 'package:flutter/cupertino.dart';

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
  int get pageCount => _calculateCount(controller.positions);
  int get childPageCount => _calculateCount(currentChildController.positions);


  void nextPage() => _changeChildPage(next: true);


  void prevPage() => _changeChildPage(next: false);


  void _changeChildPage({bool next = true}) {
    pageScrollController?.animateTo(0, duration: const Duration(milliseconds: 320), curve: Curves.fastOutSlowIn);

    if (currentChildPage == 0 && !next) {
      _changeParentPage(next: false);
      return;
    }

    if (currentChildPage == childPageCount && next) {
      _changeParentPage(next: true);
      return;
    }

    final canCancel = currentChildPage > 0;
    final canContinue = currentChildPage <= childPageCount;

    if (next && canContinue) {
      _changePage(currentChildController, true);
      onChildNext?.call();
    } else if (!next && canCancel) {
      _changePage(currentChildController, false);
      onChildPrev?.call();
    }

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


  int _calculateCount(Iterable<ScrollPosition> positions) {
    final maxScrollExtent = positions.map((p) => p.maxScrollExtent).reduce(max);
    final viewportDimension = positions.map((p) => p.viewportDimension).reduce(max);
    return (maxScrollExtent / viewportDimension).floor();
  }


  void dispose() {
    controller.dispose();
    nestedControllers.forEach((c) => c.dispose());
  }

}
