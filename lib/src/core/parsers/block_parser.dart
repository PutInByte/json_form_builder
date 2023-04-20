import 'package:flutter/material.dart';
import 'package:json_form_builder/src/contents/components/pager_card_folder.dart';
import 'package:json_form_builder/src/contents/components/pager_card_layout.dart';
import 'package:json_form_builder/src/contents/components/pager_empty_card_layout.dart';
import 'package:json_form_builder/src/models/builder_model.dart';


class BlockParser {


  static List<Widget> parse( List<Map<String, dynamic>> data ) {

    if (data.isEmpty) return const [ PagerEmptyCardLayout() ];

    List<Widget> widgets = [];

    List<BuilderModel> blocks = data.map<BuilderModel>((item) => BuilderModel.fromJson(item)).toList();

    for (int index = 0; index < blocks.length; index++) {

      if (blocks[index].items.isNotEmpty) {

        widgets.add( PagerCardLayoutFolder(
            children: _separatorParser( blocks[index].items )
          ) );

      }
      else widgets.add( const PagerEmptyCardLayout() );

    }

    return widgets;

  }




  static List<Widget> _separatorParser( List<Map<String, dynamic>> separatorItems ) {

    List<Widget> cardLayoutFolder = [];

    List<BuilderModel> separators = separatorItems.map<BuilderModel>((separator) => BuilderModel.fromJson(separator)).toList();

    for (int j = 0; j < separators.length; j++) {

      cardLayoutFolder.add(
        PagerCardLayout(
          title: separators[j].title,
          children: [ Text(separators[j].title) ]
        )
      );

    }

    return cardLayoutFolder;

  }


}