
import 'package:json_form_builder/src/controllers/pager_controller.dart';




class PanelController {


  OnChanged? onChanged;


  void onChangedPager(int index) {
    onChanged?.call(index);
  }


}