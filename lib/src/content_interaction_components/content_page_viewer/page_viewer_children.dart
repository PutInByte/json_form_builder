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

class PageViewerChildren extends StatefulWidget {

  const PageViewerChildren({
    Key? key,
    required this.controller,
    required this.children,
    required this.changeParentPage,
    this.onPageChanged,
    this.keepAlive = true,
    this.physics = const AlwaysScrollableScrollPhysics(),
  }) : super(key: key);

  final PageController controller;

  final ScrollPhysics? physics;

  final bool keepAlive;

  final List<Widget> children;

  final Function(int, int, bool) changeParentPage;

  final ValueChanged<int>? onPageChanged;


  @override
  _PageViewerChildrenState createState() => _PageViewerChildrenState();
}

class _PageViewerChildrenState extends State<PageViewerChildren> with AutomaticKeepAliveClientMixin {


  @override
  Widget build(BuildContext context) {

    super.build(context);

    return ExpandablePageView(
      alignment: Alignment.center,
      controller: widget.controller,
      clipBehavior: Clip.none,
      onPageChanged: (int page) {

        int pageViewLength = widget.children.length;

        if (pageViewLength == page)
          widget.changeParentPage(page, pageViewLength, true);

        if (widget.onPageChanged != null)
          widget.onPageChanged!(page);

      },
      animationDuration: const Duration(milliseconds: 300),
      animateFirstPage: false,
      physics: widget.physics,
      children: widget.children,
    );
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;

}
