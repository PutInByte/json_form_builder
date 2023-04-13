import 'package:flutter/material.dart';
import 'package:json_form_builder/src/contents/addons/persistant_header_delegate_addon.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ContentLayout extends StatelessWidget {

  const ContentLayout({
    Key? key,
    this.children,
    this.floatingActionButton,
    this.scrollController,
    this.bottomAction,
    this.bottomSheet,
    this.progressBar,
    this.pageName,
    this.pageTitle,
    this.appBar,
    this.backgroundColor,
    this.title,
    this.scrollableContentAxis = MainAxisAlignment.start,
  }) : super(key: key);

  final ScrollController? scrollController;
  final List<Widget>? children;
  final MainAxisAlignment scrollableContentAxis;
  final SliverPersistentHeader? progressBar;
  final Widget? pageTitle;
  final Widget? bottomAction;
  final Widget? bottomSheet;
  final Widget? floatingActionButton;
  final String? pageName;
  final String? title;
  final Color? backgroundColor;
  final Widget? appBar;


  static const double CONTENT_MAX_WIDTH = 2400.0;


  @override
  Widget build(BuildContext context) {

    assert(() {
      if (pageTitle != null && pageName != null)
        throw FlutterError("[+] Вы должны инициализировать только один из виджетов (pageTitle != null && pageName != null) ");


      if (appBar != null && pageTitle != null)
        throw FlutterError("[+] Вы должны инициализировать только один из виджетов (appBar != null && pageTitle != null) ");

      return true;
    }());

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
      controller: scrollController,
      shrinkWrap: true,
      slivers: [

        if (pageTitle != null)
          SliverPersistentHeader(
            delegate: HeaderDelegateAddon(
              expandedHeight: 72.1,
              minHeight: 72.0,
              child: pageTitle!,
            ),
          ),


        if (progressBar != null)
          progressBar!,


        SliverPersistentHeader(
          delegate: HeaderDelegateAddon(
            expandedHeight: contentSize,
            minHeight: contentSize,
            child: SizedBox(height: contentSize),
          ),
          pinned: true,
        ),


        if (pageName != null)
          SliverPersistentHeader(
            delegate: HeaderDelegateAddon(
              expandedHeight: 32.1,
              minHeight: 32.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: contentPadding),
                alignment: Alignment.centerLeft,
                child: Text(
                  pageName!,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ),
            pinned: false,
          ),


        if (progressBar != null && pageName != null)
          SliverPersistentHeader(
            delegate: HeaderDelegateAddon(
              expandedHeight: contentSize,
              minHeight: contentSize,
              child: SizedBox(height: contentSize),
            ),
            pinned: false,
          ),


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


        if (children != null)
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: CONTENT_MAX_WIDTH),
                padding: EdgeInsets.symmetric(horizontal: contentPadding),
                margin: EdgeInsets.symmetric(vertical: progressBar != null ? contentSize : 0),
                child: Column(
                  mainAxisAlignment: scrollableContentAxis,
                  children: children!,
                ),
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
      bottomNavigationBar: bottomSheet,
      backgroundColor: backgroundColor ?? (deviceScreenType == DeviceScreenType.desktop ? null : const Color.fromRGBO(231, 234, 241, 1)),
    );
  }


}
