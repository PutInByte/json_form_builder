import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_form_builder/src/contents/drawers/layout_drawer.dart';
import 'package:json_form_builder/src/contents/drawers/panel_drawer.dart';
import 'package:json_form_builder/src/controllers/json_form_controller.dart';
import 'package:provider/provider.dart';
import 'contents/components/building_status_page.dart';
import 'contents/drawers/content_drawer.dart';
import 'contents/drawers/navigator_drawer.dart';
import 'core/config/builder_config.dart';
import 'core/states/json_data_state.dart';


class JsonFormBuilder extends StatefulWidget {

  const JsonFormBuilder({ Key? key, required this.data, this.config }) : super(key: key);

  final Map<String, dynamic> data;
  final BuilderConfig? config;

  @override
  State<StatefulWidget> createState() => _JsonFormBuilderState();
}

class _JsonFormBuilderState extends State<JsonFormBuilder> {


  final JsonFormController _controller = JsonFormController( );
  late final BuilderConfig _builderConfig = widget.config ?? BuilderConfig();
  late final JsonDataState _jsonDataState;


  @override
  void initState() {
    super.initState();
    _init();
  }


  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [

        ChangeNotifierProvider<JsonFormController>(create: (context) => _controller),

        ChangeNotifierProvider<JsonDataState>(create: (context) => _jsonDataState),

        ChangeNotifierProvider<BuilderConfig>(create: (context) => _builderConfig),

      ],
      child: FutureBuilder<void>(
        future: _jsonDataState.init(),
        builder: (_, __) {

          if (_jsonDataState.isInitialized) {
            return const LayoutDrawer(
              navigatorDrawer: NavigatorDrawer(),
              contentDrawer: ContentDrawer(),
              panelDrawer: PanelDrawer(),
            );
          }

          return const BuildingStatusPage();

        },
      ),
    );


  }


  void _init() {

    _jsonDataState = JsonDataState(data: widget.data);

    _controller.pagerController
      ..onChanged = widget.config?.eventConfig.onChangeContent
      ..onStart = widget.config?.eventConfig.onStart
      ..onEnd = widget.config?.eventConfig.onEnd
      ..serverSideEvent = widget.config?.eventConfig.serverSideEvent;

  }


}
