import 'package:flutter/material.dart';
import 'package:json_form_builder/json_form_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  static const Map<String, dynamic> formData = {
    "data": [
      {
        "id": 1,
        "type": "panel",
        "name": "Общие сведения",
        "order": 1,
        "items": [
          {
            "id": 3,
            "title": "Первый?*",
            "type": "block",
            "order": 1,
            "items": [
              {
                "id": 6,
                "title": "",
                "fieldName": "piType",
                "source": {
                  "id": 1,
                  "source": "/ws/selection/declaration.select.piType"
                },
                "conditionValues": [],
                "parent": null,
                "conditionFields": [],
                "order": 1,
                "type": "integer",
                "widget": "RadioSelect",
                "colSpan": 2
              }
            ]
          },
          {
            "id": 4,
            "title": "Под первый*",
            "type": "separator",
            "order": 2,
            "items": [
              {
                "id": 6,
                "title": "",
                "fieldName": "piType",
                "source": {
                  "id": 1,
                  "source": "/ws/selection/declaration.select.piType"
                },
                "conditionValues": [],
                "parent": null,
                "conditionFields": [],
                "order": 1,
                "type": "integer",
                "widget": "RadioSelect",
                "colSpan": 2
              }
            ]
          },
          {
            "id": 5,
            "title": "Второй*",
            "type": "block",
            "order": 3,
            "items": [
              {
                "id": 6,
                "title": "",
                "fieldName": "piType",
                "source": {
                  "id": 1,
                  "source": "/ws/selection/declaration.select.piType"
                },
                "conditionValues": [],
                "parent": null,
                "conditionFields": [],
                "order": 1,
                "type": "integer",
                "widget": "RadioSelect",
                "colSpan": 2
              }
            ]
          }
        ]
      },
      {
        "id": 2,
        "type": "panel",
        "name": "Сведения о транспортном средстве",
        "order": 2,
        "items": [
          {
            "id": 3,
            "title": "Каким видом транспорта планируете прибыть в Кыргызскую Республику?*",
            "type": "separator",
            "order": 1,
            "colSpan": 3,
            "items": [
              {
                "id": 6,
                "title": "",
                "fieldName": "piType",
                "source": {
                  "id": 1,
                  "source": "/ws/selection/declaration.select.piType"
                },
                "conditionValues": [],
                "parent": null,
                "conditionFields": [],
                "order": 1,
                "type": "integer",
                "widget": "RadioSelect",
                "colSpan": 2
              }
            ]
          }
        ]
      },
      {
        "id": 3,
        "type": "panel",
        "name": "Сведения о перевозке товара",
        "order": 3,
        "items": [ ]
      },
      {
        "id": 4,
        "type": "panel",
        "name": "Сведения о товарной партии",
        "order": 4,
        "items": [ ]
      },
    ]
  };


  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: JsonFormBuilder(
          data: formData,
          config: BuilderConfig(
            pagerConfig: PagerConfig(
              childrenPhysics: NeverScrollableScrollPhysics(),
              parentPhysics: NeverScrollableScrollPhysics()
            ),
            eventConfig: BuilderEventConfig(
              // onNextServerSide: () async {
              //     await Future.delayed(const Duration(seconds: 2));
              // }
            ),
          ),
        ),
      ),
    );
  }
}
