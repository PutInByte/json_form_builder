import 'package:flutter/cupertino.dart';
import 'package:json_form_builder/src/models/json_model.dart';

import 'pager_controller.dart';


class JsonFormController extends ChangeNotifier {


  JsonFormController({ Key? key, required this.data }) {}

  final JsonModel data;
  final PagerController pagerController = PagerController();

}