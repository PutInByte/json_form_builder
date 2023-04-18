import 'package:flutter/material.dart';
import 'package:json_form_builder/json_form_builder.dart';
import 'package:json_form_builder/src/contents/drawers/panel_drawer.dart';
import 'package:json_form_builder/src/core/utils/theme_utils.dart';
import 'package:provider/provider.dart';
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


  @override
  Widget build(BuildContext context) {

    ThemeConfig themeConfig = Provider.of<BuilderConfig>(context).themeConfig;

    return Scaffold(
      appBar: appBar != null ? PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: appBar!,
      ) : null,
      body: Title(
        title: "${ title != null ? "$title | " : ""} SANARIP Tamga",
        color: Colors.grey,
        child: CustomScrollView(
          controller: ScrollController(),
          shrinkWrap: true,
          slivers: [

            panelDrawer,

            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                constraints: BoxConstraints(maxWidth: themeConfig.contentMaxWidth),
                padding: EdgeInsets.symmetric(
                    horizontal: themeConfig.getHorizontalContentIndent(context),
                    vertical: themeConfig.getVerticalContentIndent(context),
                ),
                child: contentDrawer,
              ),
            ),


          ],
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: navigatorDrawer,
      backgroundColor: const Color.fromRGBO(231, 234, 241, 1),
    );


  }


}
