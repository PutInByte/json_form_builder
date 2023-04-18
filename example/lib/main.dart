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
        "conditionFields": [],
        "itemOrder": 1,
        "colSpan": 0,
        "conditionValues": [],
        "type": "panel",
        "title": "Общие сведения",
        "version": 0,
        "isSeparated": false,
        "id": 2,
        "items": [
          {
            "conditionFields": [],
            "itemOrder": 1,
            "colSpan": 0,
            "conditionValues": [],
            "type": "block",
            "version": 0,
            "isSeparated": false,
            "id": 3,
            "items": [
              {
                "conditionFields": [],
                "itemOrder": 1,
                "colSpan": 0,
                "conditionValues": [],
                "type": "separator",
                "title": "Каким видом транспорта планируете прибыть в Кыргызскую Республику?*",
                "version": 0,
                "isSeparated": false,
                "id": 4,
                "items": [
                  {
                    "conditionFields": [],
                    "widget": "RadioSelect",
                    "itemOrder": 1,
                    "colSpan": 12,
                    "conditionValues": [],
                    "type": "field",
                    "version": 0,
                    "isSeparated": false,
                    "field": {
                      "name": "createdBy",
                      "typeName": "User",
                      "description": "",
                      "json": false,
                      "id": 7456,
                      "packageName": "com.axelor.auth.db",
                      "label": "Created by",
                      "relationship": "ManyToOne",
                      "version": 0
                    },
                    "name": "createdBy",
                    "model": {
                      "name": "SaleOrder",
                      "fullName": "com.axelor.apps.sale.db.SaleOrder",
                      "id": 313,
                      "packageName": "com.axelor.apps.sale.db",
                      "version": 0,
                      "tableName": "SALE_SALE_ORDER"
                    },
                    "id": 5,
                    "items": [],
                    "fieldType": "User"
                  }
                ]
              },
              {
                "conditionFields": [],
                "itemOrder": 1,
                "colSpan": 0,
                "conditionValues": [],
                "type": "separator",
                "title": "Каким видом транспорта планируете прибыть в Кыргызскую Республику?*",
                "version": 0,
                "isSeparated": false,
                "id": 4,
                "items": [
                  {
                    "conditionFields": [],
                    "widget": "RadioSelect",
                    "itemOrder": 1,
                    "colSpan": 12,
                    "conditionValues": [],
                    "type": "field",
                    "version": 0,
                    "isSeparated": false,
                    "field": {
                      "name": "createdBy",
                      "typeName": "User",
                      "description": "",
                      "json": false,
                      "id": 7456,
                      "packageName": "com.axelor.auth.db",
                      "label": "Created by",
                      "relationship": "ManyToOne",
                      "version": 0
                    },
                    "name": "createdBy",
                    "model": {
                      "name": "SaleOrder",
                      "fullName": "com.axelor.apps.sale.db.SaleOrder",
                      "id": 313,
                      "packageName": "com.axelor.apps.sale.db",
                      "version": 0,
                      "tableName": "SALE_SALE_ORDER"
                    },
                    "id": 5,
                    "items": [],
                    "fieldType": "User"
                  }
                ]
              }
            ],
            "info": "С помощью данного электронного сервиса задекларируйте товары, валюту или транспортные средства, которые будут пересекать таможенную границу, распечатайте декларацию и предъявите сотруднику таможни."
          },
          {
            "conditionFields": [],
            "itemOrder": 1,
            "colSpan": 0,
            "conditionValues": [],
            "type": "block",
            "version": 0,
            "isSeparated": false,
            "id": 3,
            "items": [
              {
                "conditionFields": [],
                "itemOrder": 1,
                "colSpan": 0,
                "conditionValues": [],
                "type": "separator",
                "title": "Каким видом транспорта планируете прибыть в Кыргызскую Республику?*",
                "version": 0,
                "isSeparated": false,
                "id": 4,
                "items": [
                  {
                    "conditionFields": [],
                    "widget": "RadioSelect",
                    "itemOrder": 1,
                    "colSpan": 12,
                    "conditionValues": [],
                    "type": "field",
                    "version": 0,
                    "isSeparated": false,
                    "field": {
                      "name": "createdBy",
                      "typeName": "User",
                      "description": "",
                      "json": false,
                      "id": 7456,
                      "packageName": "com.axelor.auth.db",
                      "label": "Created by",
                      "relationship": "ManyToOne",
                      "version": 0
                    },
                    "name": "createdBy",
                    "model": {
                      "name": "SaleOrder",
                      "fullName": "com.axelor.apps.sale.db.SaleOrder",
                      "id": 313,
                      "packageName": "com.axelor.apps.sale.db",
                      "version": 0,
                      "tableName": "SALE_SALE_ORDER"
                    },
                    "id": 5,
                    "items": [],
                    "fieldType": "User"
                  }
                ]
              },
            ],
            "info": "С помощью данного электронного сервиса задекларируйте товары, валюту или транспортные средства, которые будут пересекать таможенную границу, распечатайте декларацию и предъявите сотруднику таможни."
          }
        ]
      },
      {
        "conditionFields": [],
        "itemOrder": 1,
        "colSpan": 0,
        "conditionValues": [],
        "type": "panel",
        "title": "Общие сведения",
        "version": 0,
        "isSeparated": false,
        "id": 2,
        "items": [
          {
            "conditionFields": [],
            "itemOrder": 1,
            "colSpan": 0,
            "conditionValues": [],
            "type": "block",
            "version": 0,
            "isSeparated": false,
            "id": 3,
            "items": [
              {
                "conditionFields": [],
                "itemOrder": 1,
                "colSpan": 0,
                "conditionValues": [],
                "type": "separator",
                "title": "Каким видом транспорта планируете прибыть в Кыргызскую Республику?*",
                "version": 0,
                "isSeparated": false,
                "id": 4,
                "items": [
                  {
                    "conditionFields": [],
                    "widget": "RadioSelect",
                    "itemOrder": 1,
                    "colSpan": 12,
                    "conditionValues": [],
                    "type": "field",
                    "version": 0,
                    "isSeparated": false,
                    "field": {
                      "name": "createdBy",
                      "typeName": "User",
                      "description": "",
                      "json": false,
                      "id": 7456,
                      "packageName": "com.axelor.auth.db",
                      "label": "Created by",
                      "relationship": "ManyToOne",
                      "version": 0
                    },
                    "name": "createdBy",
                    "model": {
                      "name": "SaleOrder",
                      "fullName": "com.axelor.apps.sale.db.SaleOrder",
                      "id": 313,
                      "packageName": "com.axelor.apps.sale.db",
                      "version": 0,
                      "tableName": "SALE_SALE_ORDER"
                    },
                    "id": 5,
                    "items": [],
                    "fieldType": "User"
                  }
                ]
              },
              {
                "conditionFields": [],
                "itemOrder": 1,
                "colSpan": 0,
                "conditionValues": [],
                "type": "separator",
                "title": "Каким видом транспорта планируете прибыть в Кыргызскую Республику?*",
                "version": 0,
                "isSeparated": false,
                "id": 4,
                "items": [
                  {
                    "conditionFields": [],
                    "widget": "RadioSelect",
                    "itemOrder": 1,
                    "colSpan": 12,
                    "conditionValues": [],
                    "type": "field",
                    "version": 0,
                    "isSeparated": false,
                    "field": {
                      "name": "createdBy",
                      "typeName": "User",
                      "description": "",
                      "json": false,
                      "id": 7456,
                      "packageName": "com.axelor.auth.db",
                      "label": "Created by",
                      "relationship": "ManyToOne",
                      "version": 0
                    },
                    "name": "createdBy",
                    "model": {
                      "name": "SaleOrder",
                      "fullName": "com.axelor.apps.sale.db.SaleOrder",
                      "id": 313,
                      "packageName": "com.axelor.apps.sale.db",
                      "version": 0,
                      "tableName": "SALE_SALE_ORDER"
                    },
                    "id": 5,
                    "items": [],
                    "fieldType": "User"
                  }
                ]
              },
            ],
            "info": "С помощью данного электронного сервиса задекларируйте товары, валюту или транспортные средства, которые будут пересекать таможенную границу, распечатайте декларацию и предъявите сотруднику таможни."
          },
        ]
      },
    ]
  };


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: JsonFormBuilder(
          data: formData,
          config: BuilderConfig(
            pagerConfig: const PagerConfig(
              childrenPhysics: NeverScrollableScrollPhysics(),
              parentPhysics: NeverScrollableScrollPhysics()
            ),
            // eventConfig: BuilderEventConfig(
            //   serverSideEvent: () async {
            //       await Future.delayed(const Duration(seconds: 2));
            //   }
            // ),
          ),
        ),
      ),
    );
  }
}
