//MIT License
//
// Copyright (c) 2023 warioddly
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
import 'package:json_form_builder/src/contents/components/pager_card_layout.dart';
import 'package:json_form_builder/src/controllers/json_form_controller.dart';
import 'package:json_form_builder/src/controllers/pager_controller.dart';
import 'package:json_form_builder/src/dependencies/pager/pager.dart';
import 'package:provider/provider.dart';

class PagerDrawer extends StatefulWidget {

  const PagerDrawer({ Key? key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PagerDrawerState();
}

class _PagerDrawerState extends State<PagerDrawer> with AutomaticKeepAliveClientMixin {

  List<Widget> pagers = [];

  late final PagerController controller;
  PagerConfig config = const PagerConfig();

  @override
  void initState() {
    super.initState();

    controller = Provider.of<JsonFormController>(context, listen: false).pagerController;

    initChildPagers();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);

    config = BuilderConfig.of(context).pagerConfig;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(config.borderRadius),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 14,
            offset: Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Pager(
        controller: controller.pageController,
        // onPageChanged: (int page) {
        //
        //   widget.onPageChanged?.call(page);
        //
        // },
        animationDuration: config.animationDuration,
        alignment: config.alignment,
        keepAlive: config.keepAlive,
        children: pagers,
      ),
    );

  }


  void initChildPagers() {

    for (int index = 0; index < 2; index++) {

      Widget pager = Pager(
        controller: controller.getChildPageController(index),
        keepAlive: config.keepAlive,
        // changeParentPage: (int page, int pageLength, bool isNext) { },
        onPageChanged: (int page) { },
        physics: config.childrenPhysics,
        alignment: config.alignment,
        animationDuration: config.animationDuration,
        children: [

          for(int i = 2; i > index; i--)
              PagerCardLayout(
                title: "HELLO $i",
                children: const [ ],
              ),

        ]
      );

      pagers.add(pager);

    }

  }

  @override
  bool get wantKeepAlive => config.keepAlive;


}
