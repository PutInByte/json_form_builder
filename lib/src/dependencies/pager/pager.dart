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

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

class Pager extends StatefulWidget {

  const Pager({
    Key? key,
    required this.children,
    required this.controller,
    this.alignment = Alignment.center,
    this.keepAlive = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.physics = const AlwaysScrollableScrollPhysics(),
  }) : assert(children.length != 0, 'У вас нету дочерних страниц'), super(key: key);


  final List<Widget> children;

  final PageController controller;

  final ScrollPhysics? physics;

  final bool keepAlive;

  final Alignment alignment;

  final Duration animationDuration;

  @override
  State<StatefulWidget> createState() => _PagerState();

}

class _PagerState extends State<Pager> with AutomaticKeepAliveClientMixin {


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExpandablePageView(
      clipBehavior: Clip.antiAlias,
      controller: widget.controller,
      alignment: widget.alignment,
      animationDuration: widget.animationDuration,
      animateFirstPage: false,
      physics: widget.physics,
      children: widget.children,
    );
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;


}
