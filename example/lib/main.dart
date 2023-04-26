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
    "data": {
      "panels": [
        {
          "conditionFields": [ ],
          "itemOrder": 1,
          "colSpan": 0,
          "conditionValues": [ ],
          "type": "panel",
          "title": "Общие сведения",
          "version": 0,
          "isSeparated": false,
          "id": 1,
        },
        {
          "conditionFields": [],
          "itemOrder": 1,
          "colSpan": 0,
          "conditionValues": [],
          "type": "panel",
          "title": "Транспорт",
          "version": 0,
          "isSeparated": false,
          "id": 2,
        },
      ],
      "blocks": [
        {
          "conditionFields": [],
          "itemOrder": 1,
          "colSpan": 0,
          "conditionValues": [],
          "type": "block",
          "dependId": 1,
          "version": 0,
          "isSeparated": false,
          "id": 3,
          "info": "С помощью данного электронного сервиса задекларируйте товары, валюту или транспортные средства, которые будут пересекать таможенную границу, распечатайте декларацию и предъявите сотруднику таможни."
        },
        {
          "conditionFields": [],
          "itemOrder": 1,
          "colSpan": 0,
          "conditionValues": [],
          "type": "block",
          "dependId": 1,
          "version": 0,
          "isSeparated": false,
          "id": 4,
          "info": "С помощью данного электронного сервиса задекларируйте товары, валюту или транспортные средства, которые будут пересекать таможенную границу, распечатайте декларацию и предъявите сотруднику таможни."
        },
        {
          "conditionFields": [],
          "itemOrder": 1,
          "colSpan": 0,
          "conditionValues": [],
          "type": "block",
          "version": 0,
          "dependId": 2,
          "isSeparated": false,
          "id": 5,
          "info": "С помощью данного электронного сервиса задекларируйте товары, валюту или транспортные средства, которые будут пересекать таможенную границу, распечатайте декларацию и предъявите сотруднику таможни."
        },
      ],
      "separators": [
        {
          "conditionFields": [],
          "itemOrder": 1,
          "dependId": 3,
          "colSpan": 0,
          "conditionValues": [],
          "type": "separator",
          "title": "Каким видом транспорта планируете прибыть в Кыргызскую Республику?*",
          "version": 0,
          "isSeparated": false,
          "id": 4,
        },
        {
          "conditionFields": [],
          "itemOrder": 1,
          "colSpan": 0,
          "dependId": 3,
          "conditionValues": [],
          "type": "separator",
          "title": "Каким видом транспорта планируете прибыть в Кыргызскую Республику?*",
          "version": 0,
          "isSeparated": false,
          "id": 5,
        },
        {
          "conditionFields": [],
          "itemOrder": 1,
          "colSpan": 0,
          "dependId": 4,
          "conditionValues": [],
          "type": "separator",
          "title": "Каким видом транспорта планируете прибыть в Кыргызскую Республику?*",
          "version": 0,
          "isSeparated": false,
          "id": 7,
        },
        {
          "conditionFields": [],
          "itemOrder": 1,
          "colSpan": 0,
          "dependId": 5,
          "conditionValues": [],
          "type": "separator",
          "title": "Каким видом транспорта планируете прибыть в Кыргызскую Республику?*",
          "version": 0,
          "isSeparated": false,
          "id": 6,
        },
      ],
      "fields": [
        {
          "conditionFields": [],
          "widget": "RadioSelect",
          "itemOrder": 1,
          "dependId": 4,
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
        },
        {
          "conditionFields": [],
          "widget": "RadioSelect",
          "itemOrder": 1,
          "dependId": 5,
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
        },
        {
          "conditionFields": [],
          "widget": "RadioSelect",
          "itemOrder": 1,
          "dependId": 7,
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
        },
        {
          "conditionFields": [],
          "widget": "RadioSelect",
          "itemOrder": 1,
          "colSpan": 12,
          "dependId": 6,
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
            // eventConfig: EventConfig(
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
