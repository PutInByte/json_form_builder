import 'package:flutter/material.dart';
// import 'package:json_form_builder/json_form_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Json Form Builder Plugin example app'),
        ),
        body: Center(
          child: Text('WARIODDLY'),
        ),
      ),
    );
  }
}
