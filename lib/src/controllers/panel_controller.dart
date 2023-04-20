import 'package:json_form_builder/src/core/utils/typedefs.dart';

class PanelController {

  ChangedEvent? onChanged;

  void onChangedPager(int index) {
    onChanged?.call(index);
  }


}