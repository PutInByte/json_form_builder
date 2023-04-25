import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:json_form_builder/src/controllers/json_form_controller.dart';
import 'package:json_form_builder/src/controllers/pager_controller.dart';
import 'package:json_form_builder/src/controllers/panel_controller.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:badges/badges.dart';
import 'addons/stepper_step_addon.dart';

const double _kStepSize = 60.0;
const double _kStepSpacing = 3.0;
const Duration _kThemeAnimationDuration = Duration(milliseconds: 300);

class PercentStepper extends StatefulWidget {

  const PercentStepper({ Key? key, required this.steps }) : super(key: key);

  final List<StepperStep> steps;

  @override
  State<PercentStepper> createState() => _PercentStepperState();
}

class _PercentStepperState extends State<PercentStepper> with TickerProviderStateMixin {


  late final PanelController panelController;

  List<GlobalKey> _keys = [];
  bool isDesktop = true;
  int currentIndex = 0;


  @override
  void initState() {
    super.initState();

    _keys = List<GlobalKey>.generate(widget.steps.length, (int i) => GlobalKey());

    // for (int i = 0; i < widget.steps.length; i++) {
    //   _oldStates[i] = widget.steps[i].state;
    // }

    PagerController controller = Provider.of<JsonFormController>(context, listen: false).pagerController;

    panelController = controller.panelController;

    panelController.onChanged = (index) {

      currentIndex = index;

      _onInteractive(index);

      setState(() { });

    };


  }


  @override
  void didUpdateWidget(PercentStepper oldWidget) {
    super.didUpdateWidget(oldWidget);

    assert(widget.steps.length == oldWidget.steps.length);

    // for (int i = 0; i < oldWidget.steps.length; i += 1) {
    //   _oldStates[i] = oldWidget.steps[i].state;
    // }

  }


  @override
  Widget build(BuildContext context) {

    assert(debugCheckHasDirectionality(context));
    assert(() {
      if (context.findAncestorWidgetOfExactType<PercentStepper>() != null) {
        throw FlutterError('Steppers must not be nested.\n'
            'The material specification advises that one should avoid embedding '
            'steppers within steppers. '
            'https://material.io/archive/guidelines/components/steppers.html#steppers-usage');
      }
      return true;
    }());

    Size screenSize = MediaQuery.of(context).size;
    DeviceScreenType deviceScreenType = getDeviceType(screenSize);

    isDesktop = deviceScreenType == DeviceScreenType.desktop;

    final List<Widget> children = <Widget>[

      for (int index = 0; index < widget.steps.length; index++) ...<Widget>[

        Badge(
          showBadge: isDesktop ? false : !_isCurrentIndex(index),
          position: BadgePosition.topEnd(top: 0, end: 0),
          child: AnimatedContainer(
            key: _keys[index],
            constraints: isDesktop ? const BoxConstraints(maxWidth: 400) : null,
            height: isDesktop ? null : 94,
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              gradient: _isCurrentIndex(index) ? const LinearGradient(
                colors: [
                  Color.fromRGBO(91, 108, 255, 1),
                  Color.fromRGBO(15, 66, 176, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ) : null,
              borderRadius: BorderRadius.circular(isDesktop ? 58 : 12),
              color: isDesktop ? null : Colors.white,
              boxShadow: isDesktop ? [] : [ const BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.08),
                blurRadius: 14,
                offset: Offset(0, 2),
                spreadRadius: 0,
              ) ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Focus(
              canRequestFocus: false,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _onInteractive(index),
                child: isDesktop
                    ? Row(
                        children: <Widget>[

                          SizedBox(
                            height: 80.0,
                            child: Center(
                              child: _buildIcon(index),
                            ),
                          ),

                          Flexible(
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(start: _kStepSpacing),
                              child: _buildTitle(index)
                            ),
                          )
                        ],
                      )
                    : ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: deviceScreenType == DeviceScreenType.tablet ? 120.0 : 82.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[

                            Center( child: _buildIcon(index) ),

                            Flexible(
                              child: _buildTitle(index)
                            )

                          ],
                        ),
                      )
              ),
            ),
          ),
        ),

        if (!_isLast(index)) const Expanded(child: SizedBox()),

      ],

    ];

    return Row( children: children );

  }


  bool _isLast( int index ) {
    return widget.steps.length - 1 == index;
  }


  bool _isCurrentIndex( int index ) {
    return currentIndex == index;
  }


  Widget _buildCircle( int index, bool oldState ) {
    return SizedBox(
      width: _kStepSize,
      child: Center(
        child: CircularPercentIndicator(
          animation: true,
          circularStrokeCap: CircularStrokeCap.round,
          curve: Curves.fastLinearToSlowEaseIn,
          animationDuration: 2000,
          radius: isDesktop ? 28.0 : 24.0,
          lineWidth: 8.0,
          percent: .4,
          progressColor: const Color.fromRGBO(96, 188, 255, 1),
          backgroundColor: _isCurrentIndex(index) ? Colors.white : const Color.fromRGBO(96, 188, 255, 0.2),
          animateFromLastPercent: true,
          center: Text(
            '${(0.4 * 100).toInt()}%',
            maxLines: 1,
            style: TextStyle(
              color: _isCurrentIndex(index) ? Colors.white : const Color.fromRGBO(15, 66, 176, 1),
              fontSize: isDesktop ? 16 : 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildTitle( int index ) {
    return Text(
      widget.steps[index].title,
      maxLines: 2,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      softWrap: true,
    );
  }


  Widget _buildIcon( int index ) {
    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      duration: _kThemeAnimationDuration,
      child: _buildCircle(index, true),
    );
  }


  void _onInteractive( int index ) {
    Scrollable.ensureVisible(
      _keys[index].currentContext!,
      curve: Curves.fastOutSlowIn,
      duration: _kThemeAnimationDuration,
    );
  }


}
