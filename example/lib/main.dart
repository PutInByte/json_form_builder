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
            "id": 2,
            "order": 1,
            "type": "block",
            "isSeparated": false,
            "info": "C помощью данного электронного сервиса задекларируйте товары, валюту или транспортные средства, которые будут пересекать таможенную границу, распечатайте декларацию и предъявите сотруднику таможни.",
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
            "id": 4,
            "order": 2,
            "type": "block",
            "isSeparated": false,
            "info": "C помощью данного электронного сервиса задекларируйте товары, валюту или транспортные средства, которые будут пересекать таможенную границу, распечатайте декларацию и предъявите сотруднику таможни.",
            "items": [
              {
                "id": 5,
                "title": "Через какой пункт пропуска и когда планируете прибытие в Кыргызскую Республику?*",
                "type": "separator",
                "order": 1,
                "colSpan": 3,
                "items": [
                  {
                    "id": 7,
                    "title": "",
                    "type": "field",
                    "fieldName": "arrivalLocation",
                    "source": {
                      "id": 2,
                      "source": "/ws/rest/com.axelor.apps.sale.db.ArrivalLocation"
                    },
                    "conditionValues": [
                      {
                        "value": ":piType",
                        "conditional": "=",
                        "fieldName": "self.forPiType"
                      }
                    ],
                    "parent": {
                      "id": 1
                    },
                    "conditionFields": [],
                    "order": 1,
                    "fieldType": "many-to-one",
                    "widget": "RadioSelect",
                    "colSpan": 6
                  },
                  {
                    "id": 8,
                    "title": "",
                    "type": "field",
                    "fieldName": "arrivalLocationArrivalDateTime",
                    "source": null,
                    "conditionValues": [],
                    "parent": {
                      "id": 1
                    },
                    "conditionFields": [],
                    "order": 2,
                    "fieldType": "datetime",
                    "widget": "DateTimeCalendar",
                    "colSpan": 6
                  }
                ]
              }
            ]
          }
        ]
      },
      {
        "id": 9,
        "type": "panel",
        "name": "Сведения о ТС",
        "order": 2,
        "items": []
      },
      {
        "id": 10,
        "type": "panel",
        "name": "Сведения о перевозке товаров",
        "order": 3,
        "items": []
      },
      {
        "id": 10,
        "type": "panel",
        "name": "Сведения о товарной партии",
        "order": 2,
        "items": []
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: JsonFormBuilder(
          data: formData,
          config: BuilderConfig(),
        ),
      ),
    );
  }
}
