
import 'package:form_bloc/form_bloc.dart';

class SpecifyFieldBloc<Value> extends GroupFieldBloc {

  final TextFieldBloc specifyVehicleNumber;

  final SelectFieldBloc<Value, dynamic> specifyState;

  final SelectFieldBloc<Value, dynamic> specifyCheckPoint;

  SpecifyFieldBloc(
      String? name,
      {
        required this.specifyVehicleNumber,
        required this.specifyState,
        required this.specifyCheckPoint,
      }) : super (name: name, fieldBlocs: [specifyVehicleNumber, specifyState, specifyCheckPoint]);


  Map<String, dynamic> toJson() => {
    "typeTransport": specifyCheckPoint.state.toJson(),
    "vehicleNumber": specifyVehicleNumber.value,
    "country": specifyState.state.toJson(),
  };

}