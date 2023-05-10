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


  static const Map<String, dynamic> formData1 = {

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
      ],

      "actions": [

      ]

    }

  };

  static const Map<String, dynamic> formData = {
    "data": {
      "view": {
        "modelId": 348,
        "panels": [
          {
            "model": "com.axelor.apps.sale.db.Declaration",
            "id": 1,
            "name": "Общие сведения"
          },
          {
            "model": "com.axelor.apps.sale.db.Declaration",
            "id": 2,
            "name": "Сведения о транспортном средстве"
          },
          {
            "model": "com.axelor.apps.sale.db.Declaration",
            "id": 3,
            "name": "Сведения о перевозке товара"
          }
        ],
        "title": "Preliminary information",
        "model": "com.axelor.apps.sale.db.Declaration",
        "blocks": [
          {
            "panelId": 1,
            "title": "Первый блок",
            "model": "com.axelor.apps.sale.db.Declaration",
            "id": 1,
            "help": "С помощью данного электронного сервиса задекларируйте товары, валюту или транспортные средства, которые будут пересекать таможенную границу, распечатайте декларацию и предъявите сотруднику таможни."
          },
          {
            "panelId": 1,
            "title": "Второй блок",
            "model": "com.axelor.apps.sale.db.Declaration",
            "id": 2,
            "help": "С помощью данного электронного сервиса задекларируйте товары, валюту или транспортные средства, которые будут пересекать таможенную границу, распечатайте декларацию и предъявите сотруднику таможни."
          },
          {
            "panelId": 2,
            "title": "Третий блок",
            "model": "com.axelor.apps.sale.db.Declaration",
            "id": 3
          },
          {
            "panelId": 3,
            "title": "Четвертый блок",
            "model": "com.axelor.apps.sale.db.Declaration",
            "id": 4
          }
        ],
        "viewId": 1229,
        "name": "declaration-flutter-form",
        "fields": [
          {
            "model": "com.axelor.apps.sale.db.Declaration",
            "id": 1,
            "name": "piType",
            "widget": "RadioWidget",
            "fromEditor": false,
            "separatorId": 1
          },
          {
            "model": "com.axelor.apps.sale.db.Declaration",
            "id": 2,
            "name": "arrivalLocation",
            "fromEditor": false,
            "separatorId": 2
          },
          {
            "model": "com.axelor.apps.sale.db.Declaration",
            "id": 3,
            "name": "haveOtherOperations",
            "widget": "boolean-switch",
            "fromEditor": false,
            "colSpan": 12,
            "separatorId": 3
          }
        ],
        "separators": [
          {
            "title": "Через какой пункт пропуска и когда планируете прибытие в Кыргызскую Республику?*",
            "model": "com.axelor.apps.sale.db.Declaration",
            "id": 1,
            "blockId": 1
          },
          {
            "title": "Укажите страну регистрации и государственный регистрационный номер транспортных(ого) средств(а)*",
            "model": "com.axelor.apps.sale.db.Declaration",
            "id": 2,
            "blockId": 2
          },
          {
            "title": "Планируете ли Вы поменять траспортное средство при прибытии на пункт пропуска?*",
            "model": "com.axelor.apps.sale.db.Declaration",
            "id": 3,
            "blockId": 2
          }
        ]
      },
      "fields": [
        {
          "defaultValue": false,
          "name": "haveOtherOperations",
          "type": "BOOLEAN",
          "title": "Планируете ли Вы поменять транспортное средство при прибытии на пункт пропуска?"
        },
        {
          "selection": "declaration.select.piType",
          "defaultValue": 0,
          "name": "piType",
          "selectionList": [
            {
              "value": "1",
              "order": 0,
              "hidden": false,
              "data": {},
              "title": "АВТОМОБИЛЬНЫЙ ТРАНСПОРТ"
            },
            {
              "value": "2",
              "order": 1,
              "hidden": false,
              "data": {},
              "title": "ЖЕЛЕЗНОДОРОЖНЫЙ ТРАНСПОРТ"
            },
            {
              "value": "3",
              "order": 2,
              "hidden": false,
              "data": {},
              "title": "ВОЗДУШНЫЙ ТРАНСПОРТ"
            }
          ],
          "type": "INTEGER",
          "title": "Тип транспорта"
        },
        {
          "targetName": "name",
          "targetSearch": [
            "name"
          ],
          "name": "arrivalLocation",
          "type": "MANY_TO_ONE",
          "title": "Наименование пункта пропуска",
          "target": "com.axelor.apps.sale.db.ArrivalLocation"
        }
      ],
      "depend": {
        "sourceFieldType": "selection",
        "priority": 20,
        "version": 0,
        "dependencies": {
          "1": [
            {
              "hidden": false,
              "readonly": false,
              "required": false,
              "fieldName": "arrivalLocation"
            },
            {
              "hidden": false,
              "readonly": false,
              "required": false,
              "fieldName": "haveOtherOperations"
            }
          ],
          "2": [
            {
              "hidden": true,
              "readonly": false,
              "required": false,
              "fieldName": "arrivalLocation"
            },
            {
              "hidden": true,
              "readonly": false,
              "required": false,
              "fieldName": "haveOtherOperations"
            }
          ],
          "3": [
            {
              "hidden": false,
              "readonly": false,
              "required": true,
              "fieldName": "arrivalLocation"
            },
            {
              "hidden": false,
              "readonly": false,
              "required": true,
              "fieldName": "haveOtherOperations"
            }
          ]
        },
        "importId": null,
        "viewName": "declaration-flutter-form",
        "sourceFieldName": "piType",
        "name": "Пример",
        "id": 1
      },
    }
  };


  Map<String, dynamic> jsonData = { };


  @override
  void initState() {
    super.initState();

    jsonData = JsonNormalizer(json: formData).normalize();

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: JsonFormBuilder(
          data: jsonData,
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
