import 'package:flutter/cupertino.dart';
import 'package:json_form_builder/src/models/json_model.dart';
import 'package:json_form_builder/src/utils/utils.dart';


class JsonFormController extends ChangeNotifier {


  JsonFormController({ Key? key, required this.data }) {
    List.generate(data.panels.length, (index) => _getNestedPageController(index));
  }


  final JsonModel data;
  final PageController pageController = PageController(initialPage: 0, keepPage: true);
  final Map<int, PageController> _nestedPageControllers = { };
  final Map<int, double> _indicatorPercents = { };


  int get currentPage => Utils.getCurrentPage(pageController);

  int get currentChildPage => Utils.getCurrentPage(_getNestedPageController(currentPage));

  int get pageCount => Utils.calculatePageCount(pageController);

  int get childPageCount => Utils.calculatePageCount(_getNestedPageController(currentPage));

  PageController getChildPageController(int index) => _getNestedPageController(index);


  PageController _getNestedPageController(int pageIndex) {
    return _nestedPageControllers.putIfAbsent(pageIndex, () => PageController(keepPage: true, initialPage: 0));
  }

  double getIndicatorPercent(int pageIndex) {
    return _indicatorPercents.putIfAbsent(pageIndex, () => 0.0);
  }

  void setIndicatorPercent(int pageIndex, double value) {
    _indicatorPercents[pageIndex] = value;
  }

  void changePage({ bool next = true }) {

    final controller = currentChildPage < childPageCount ? _getNestedPageController(currentPage) : pageController;

    final forward = next ? currentPage < controller.positions.last.maxScrollExtent : currentPage > controller.positions.first.minScrollExtent;

    if (forward) Utils.changePage(controller, next);

    notifyListeners();

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