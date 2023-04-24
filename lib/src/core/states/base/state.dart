

class State {

  State({ this.data = const [] });

  List<Map<String, dynamic>> data;

  List<Map<String, dynamic>> get panels => data;

  List<Map<String, dynamic>> Function(int index) get block => (index) => data[index]["items"];

}
