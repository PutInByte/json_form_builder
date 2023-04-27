//MIT License
//
// Copyright (c) 2023 WARIODDLY
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import 'package:flutter/material.dart';
import 'package:json_form_builder/json_form_builder.dart';
import 'package:json_form_builder/src/contents/components/pager_empty_card_layout.dart';
import 'package:json_form_builder/src/controllers/json_form_controller.dart';
import 'package:json_form_builder/src/controllers/pager_controller.dart';
import 'package:json_form_builder/src/core/states/global_state.dart';
import 'package:json_form_builder/src/dependencies/pager/pager.dart';
import 'package:provider/provider.dart';


class PagerDrawer extends StatefulWidget {

  const PagerDrawer({ Key? key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PagerDrawerState();
}


class _PagerDrawerState extends State<PagerDrawer> {


  List<Widget> pagers = [];

  late final PagerController controller;
  late final GlobalState globalState;
  PagerConfig config = const PagerConfig();


  @override
  void initState() {
    super.initState();

    controller = Provider.of<JsonFormController>(context, listen: false).pagerController;
    globalState = Provider.of<GlobalState>(context, listen: false);
    config = Provider.of<BuilderConfig>(context, listen: false).pagerConfig;

    initChildPagers();

  }


  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(config.borderRadius),
        color: Colors.white,
        boxShadow: const [ BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 14,
            offset: Offset(0, 2),
          ) ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Pager(
        controller: controller.pageController,
        animationDuration: config.animationDuration,
        alignment: config.alignment,
        keepAlive: config.keepAlive,
        physics: config.parentPhysics,
        children: pagers,
      ),
    );

  }


  void initChildPagers() {


    List<Map<String, dynamic>> panels = globalState.getPanels;

    for (int index = 0; index < panels.length; index++) {

      List<Widget> children = globalState.blockWidgets( panels[ index ][ "id" ] ) ;


      if (children.isEmpty) {
        children = [ const PagerEmptyCardLayout() ];
      }


      Widget pager = Pager(
        controller: controller.getChildPageController(index),
        keepAlive: config.keepAlive,
        physics: config.childrenPhysics,
        alignment: config.alignment,
        animationDuration: config.animationDuration,
        children: children,
      );

      pagers.add(pager);

    }


  }

}
