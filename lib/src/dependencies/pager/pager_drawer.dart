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
import 'package:json_form_builder/src/controllers/json_form_controller.dart';
import 'package:json_form_builder/src/dependencies/pager/pager.dart';
import 'package:provider/provider.dart';

class PagerDrawer extends StatefulWidget {

  const PagerDrawer({
    Key? key,
    // required this.children,
    this.onPageChanged,
    this.onChildPageChanged,
    this.keepAlive = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.physics = const NeverScrollableScrollPhysics(),
    this.childPagePhysics = const AlwaysScrollableScrollPhysics(),
  }) : super(key: key);


  // final List<dynamic> children;

  final ScrollPhysics? physics;

  final bool keepAlive;

  final Duration animationDuration;

  final ScrollPhysics? childPagePhysics;

  final  ValueChanged<int>? onPageChanged;

  final Function(int, int)? onChildPageChanged;


  @override
  State<StatefulWidget> createState() => _PagerDrawerState();
}

class _PagerDrawerState extends State<PagerDrawer> {


  List<Widget> pagers = [];
  int currentPage = 0;
  late final JsonFormController controller;


  @override
  void initState() {
    super.initState();

    controller = Provider.of<JsonFormController>(context, listen: false);

    // pagers.addAll(_getChildPages());

    // if (widget.children.runtimeType == List<Widget>) pages.addAll(widget.children as List<Widget>);
    // else {
    //
    //   List<Widget>? _pages = getChildPages(widget.children as List<List<Widget>>);
    //
    //   if (_pages != null) pages.addAll(_pages);
    //
    // }

  }


  @override
  Widget build(BuildContext context) {

    for (int index = 0; index < 4; index++) {

      // if (children.length == index) break;

      pagers.add(Pager(
          controller: PageController(initialPage: 0),
          keepAlive: widget.keepAlive,
          // changeParentPage: (int page, int pageLength, bool isNext) { },
          onPageChanged: (int page) {

            widget.onChildPageChanged?.call(page, currentPage);

          },
          physics: widget.childPagePhysics,
          children: [
            Container(
              height: 200,
              color: Colors.red,
              child: Text('Page $index'),
              width: 200,
            ),
            Container(
              height: 200,
              color: Colors.red,
              child: Text('Page $index'),
              width: 200,
            ),    Container(
              height: 200,
              color: Colors.red,
              child: Text('Page $index'),
              width: 200,
            ),

          ]


      ));

    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 14,
            offset: Offset(0, 2),
          ),
        ],
      ),
      // clipBehavior: Clip.hardEdge,
      child: Pager(
        controller: PageController(initialPage: 0),
        // onPageChanged: (int page) {
        //
        //   widget.onPageChanged?.call(page);
        //
        // },
        animationDuration: widget.animationDuration,
        keepAlive: widget.keepAlive,
        children: pagers,
      ),
    );

  }


  List<Widget> _getChildPages() {

    List<Widget> pagers = [];

    for (int index = 0; index < 4; index++) {

      // if (children.length == index) break;

      Widget pager = Pager(
          controller: controller.getChildPageController(index),
          keepAlive: widget.keepAlive,
          // changeParentPage: (int page, int pageLength, bool isNext) { },
          onPageChanged: (int page) {

            widget.onChildPageChanged?.call(page, currentPage);

          },
          physics: widget.childPagePhysics,
          children: [
            Container(
              height: 200,
              color: Colors.red,
              child: Text('Page $index'),
              width: 200,

            )
          ]


      );

      pagers.add(pager);

    }

    print(pagers);

    return pagers;

  }


}
