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

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'pager_children.dart';
import 'pager_controller.dart';

class Pager extends StatefulWidget {

  const Pager({
    Key? key,
    required this.controller,
    required this.children,
    this.onPageChanged,
    this.onChildPageChanged,
    this.keepAlive = true,
    this.physics = const AlwaysScrollableScrollPhysics(),
    this.childPagePhysics = const AlwaysScrollableScrollPhysics(),
    }) : assert(children.length != 0, 'У вас нету дочерних страниц'), super(key: key);


  final PagerController controller;

  final List<dynamic> children;

  final ScrollPhysics? physics;

  final bool keepAlive;

  final ScrollPhysics? childPagePhysics;

  final  ValueChanged<int>? onPageChanged;

  final Function(int, int)? onChildPageChanged;


  @override
  State<StatefulWidget> createState() => _PagerState();
}

class _PagerState extends State<Pager> {


  List<Widget> pages = [];

  PagerController get controller => widget.controller;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    if (widget.children.runtimeType == List<Widget>) pages.addAll(widget.children as List<Widget>);
    else {

      List<Widget>? pages = getChildPages(widget.children as List<List<Widget>>);

      if (pages != null) pages.addAll(pages);

    }

  }


  @override
  Widget build(BuildContext context) {
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
      clipBehavior: Clip.hardEdge,
      child: ExpandablePageView(
        clipBehavior: Clip.antiAlias,
        // alignment: Alignment.center,
        controller: controller.controller,
        onPageChanged: (int page) {

          currentPage = page;

          if (widget.onPageChanged != null)
            widget.onPageChanged!(page);

        },
        animationDuration: const Duration(milliseconds: 300),
        animateFirstPage: false,
        physics: widget.physics,
        children: pages,
      ),
    );
  }


  List<Widget>? getChildPages (List<List<Widget>> children) {

    List<Widget> pages = [];

    for (int index = 0; index < controller.nestedControllers.length; index++) {

      if (children.length == index) break;

      Widget pageView = PagerChildren(
        controller: controller.nestedControllers[index],
        keepAlive: widget.keepAlive,
        changeParentPage: (int page, int pageLength, bool isNext) { },
        onPageChanged: (int page) {

          if (widget.onChildPageChanged != null)
            widget.onChildPageChanged!(page, currentPage);

        },
        physics: widget.childPagePhysics,
        children: children[index]
      );

      pages.add(pageView);

    }

    return pages;

  }


}
