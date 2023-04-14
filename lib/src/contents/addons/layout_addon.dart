import 'package:flutter/material.dart';
import 'package:json_form_builder/src/contents/drawers/panel_drawer.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../drawers/content_drawer.dart';
import '../drawers/navigator_drawer.dart';

class LayoutAddon extends StatelessWidget {

  const LayoutAddon({
    Key? key,
    required this.panelDrawer,
    required this.navigatorDrawer,
    required this.contentDrawer,
    this.floatingActionButton,
    this.scrollController,
    this.backgroundColor,
    this.appBar,
    this.title,
    this.scrollableContentAxis = MainAxisAlignment.start,
  }) : super(key: key);

  final NavigatorDrawer navigatorDrawer;
  final PanelDrawer panelDrawer;
  final ContentDrawer contentDrawer;
  final MainAxisAlignment scrollableContentAxis;
  final ScrollController? scrollController;
  final Widget? floatingActionButton;
  final Widget? appBar;
  final String? title;
  final Color? backgroundColor;


  static const double CONTENT_MAX_WIDTH = 2400.0;


  @override
  Widget build(BuildContext context) {

    DeviceScreenType deviceScreenType = getDeviceType(MediaQuery.of(context).size);

    double contentSize = 32.0;
    double contentPadding = 111.0;

    if (deviceScreenType == DeviceScreenType.desktop) {
      contentPadding = 111.0;
    }

    if (deviceScreenType == DeviceScreenType.tablet) {
      contentPadding = 32.0;
      contentSize = 32.0;
    }

    if (deviceScreenType == DeviceScreenType.mobile) {
      contentSize = 16.0;
      contentPadding = 16.0;
    }


    Widget render = CustomScrollView(
      controller: ScrollController(),
      shrinkWrap: true,
      slivers: [


        // panelDrawer,
        //
        //
        // SliverPersistentHeader(
        //   delegate: HeaderDelegateAddon(
        //     expandedHeight: contentSize,
        //     minHeight: contentSize,
        //     child: SizedBox(height: contentSize),
        //   ),
        //   pinned: true,
        // ),


        // if (content != null)
        //   SliverToBoxAdapter(
        //     child: Center(
        //       child: Container(
        //         constraints: const BoxConstraints(maxWidth: CONTENT_MAX_WIDTH),
        //         padding: EdgeInsets.symmetric(horizontal: contentPadding),
        //         margin: EdgeInsets.symmetric(vertical: progressBar != null ? contentSize : 0),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: content!,
        //         ),
        //       ),
        //     ),
        //   ),


        SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: CONTENT_MAX_WIDTH),
                padding: EdgeInsets.symmetric(horizontal: contentPadding),
                margin: EdgeInsets.symmetric(vertical: contentSize),
                child: contentDrawer,
              ),
            ),
          ),


      ],
    );

    return Scaffold(
      body: Title(
        title: "${ title != null ? "$title | " : ""} SANARIP Tamga",
        color: Colors.grey,
        child: render,
      ),
      appBar: appBar != null ? PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: appBar!,
      ) : null,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: navigatorDrawer,
      backgroundColor: backgroundColor ?? (deviceScreenType == DeviceScreenType.desktop ? null : const Color.fromRGBO(231, 234, 241, 1)),
    );
  }


}
