import 'package:flutter/material.dart';

class JsonFormBuilder extends StatefulWidget {

  const JsonFormBuilder({ Key? key, required this.data }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  State<StatefulWidget> createState() => _JsonFormBuilderState();
}

class _JsonFormBuilderState extends State<JsonFormBuilder> {

  Map<String, dynamic> get _data => widget.data;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Text('hello 2');
  }

}
