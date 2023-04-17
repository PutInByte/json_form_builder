


import 'package:flutter/material.dart';
import 'package:json_form_builder/src/contents/components/pager_card_layout.dart';
import 'package:json_form_builder/src/contents/components/pager_empty_card_layout.dart';
import 'package:json_form_builder/src/models/json_block_model.dart';


class BlockParser {


  static List<Widget> parse(List<Map<String, dynamic>> data) {

    if (data.isEmpty) return const [ PagerEmptyCardLayout() ];


    List<JsonBlockModel> blocks = data.map<JsonBlockModel>((item) => JsonBlockModel.fromJson(item)).toList();

    List<Widget> widgets = [];


    for (int index = 0; index < blocks.length; index++) {

      Widget card = PagerCardLayout(
          title: blocks[index].title,
          children: [ Text(blocks[index].title) ]
      );

      // List<Widget> cardLayoutFolder = [];
      //
      // if (blocks[index].type == "seperator") {
      //     cardLayoutFolder.add(card);
      //     continue;
      // }

      widgets.add(card);

    }




    return widgets;

  }





}