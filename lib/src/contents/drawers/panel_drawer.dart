import 'package:flutter/material.dart';
import 'package:json_form_builder/json_form_builder.dart';
import 'package:json_form_builder/src/controllers/json_form_controller.dart';
import 'package:json_form_builder/src/core/states/json_data_state.dart';
import 'package:json_form_builder/src/core/utils/theme_utils.dart';
import 'package:json_form_builder/src/dependencies/stepper/addons/stepper_step_addon.dart';
import 'package:json_form_builder/src/dependencies/stepper/percent_stepper.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../addons/persistant_header_delegate_addon.dart';


class PanelDrawer extends StatefulWidget {

  const PanelDrawer({ Key? key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PanelDrawerState();
}

class _PanelDrawerState extends State<PanelDrawer> {


  late final JsonFormController controller;
  late final JsonDataState dataState;


  @override
  void initState() {

    super.initState();

    controller = Provider.of<JsonFormController>(context, listen: false);
    dataState = Provider.of<JsonDataState>(context, listen: false);

  }


  @override
  Widget build(BuildContext context) {

    double maxWidth = 820.0;

    BuilderThemeConfig themeConfig = BuilderConfig.of(context).themeConfig;

    Size screenSize = MediaQuery.of(context).size;
    DeviceScreenType deviceScreenType = getDeviceType(screenSize);
    bool isDesktop = deviceScreenType == DeviceScreenType.desktop;

    double padding = themeConfig.getHorizontalContentIndent(context);

    double cardWidth = isDesktop ? 400 : deviceScreenType == DeviceScreenType.tablet ? 120.0 : 82.0;

    double cardMaxWidth = (cardWidth + (12 * 2)) * dataState.panels.length;
    double mediaQueryWidth = screenSize.width - (padding * 2);

    if (mediaQueryWidth >= cardMaxWidth) maxWidth = mediaQueryWidth;
    else maxWidth = cardMaxWidth;

    double headerHeight = isDesktop ? 80.0 : 135.0;

    return SliverPersistentHeader(
      delegate: HeaderDelegateAddon(
        expandedHeight: headerHeight + .1,
        minHeight: headerHeight,
        child: Container(
          padding: EdgeInsets.symmetric( horizontal: padding ),
          decoration: BoxDecoration( color: isDesktop ? const Color.fromRGBO(1, 114, 206, 1) : null ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: PercentStepper(
                    steps: [

                      for (int index = 0; index < dataState.panels.length; index++)
                        StepperStep( title: dataState.panels[index].title )

                    ],
                  ),
                ),
              ),

              if (!isDesktop) ... [

                const SizedBox( height: 12.0 ),

                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Row(
                    children: [

                      for ( int index = 0; index < dataState.panels.length; index++ ) ...[
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric( horizontal: 5.0 ),
                            height: 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromRGBO( 1, 114, 206, 1 ),
                            ),
                          )
                        ),
                      ]

                    ],
                  ),
                )

              ],

            ],
          ),
        )
      ),
    );

  }



}
