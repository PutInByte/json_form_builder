import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors, ControlsWidgetBuilder, Step, StepState, StepperType;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:badges/badges.dart';
export 'package:flutter/material.dart' show Step, ControlsWidgetBuilder, ControlsDetails, StepState, StepperType;

const double _kStepSize = 60.0;
const double _kStepSpacing = 3.0;
const Duration _kThemeAnimationDuration = Duration(milliseconds: 300);

class PercentStepper extends StatefulWidget {

  const PercentStepper({
    Key? key,
    required this.steps,
    this.physics,
    this.type = StepperType.vertical,
    this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
    this.controlsBuilder,
  }) : super(key: key);


  final List<Step> steps;

  final ScrollPhysics? physics;

  final StepperType type;

  final ValueChanged<int>? onStepTapped;

  final VoidCallback? onStepContinue;

  final VoidCallback? onStepCancel;

  final ControlsWidgetBuilder? controlsBuilder;

  @override
  State<PercentStepper> createState() => _PercentStepperState();
}

class _PercentStepperState extends State<PercentStepper> with TickerProviderStateMixin {

  final Map<int, StepState> _oldStates = <int, StepState>{};
  bool isDesktop = true;
  bool isTablet = false;

  List<GlobalKey> _keys = [];

  @override
  void initState() {
    super.initState();

    _keys = List<GlobalKey>.generate(
      widget.steps.length,
          (int i) => GlobalKey(),
    );

    for (int i = 0; i < widget.steps.length; i++) {
      _oldStates[i] = widget.steps[i].state;
    }

  }

  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }


  @override
  void didUpdateWidget(PercentStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    assert(widget.steps.length == oldWidget.steps.length);

    for (int i = 0; i < oldWidget.steps.length; i += 1) {
      _oldStates[i] = oldWidget.steps[i].state;
    }
  }


  Widget _buildCircle(int index, bool oldState) {
    return SizedBox(
      // margin: const EdgeInsets.symmetric(vertical: _kStepPadding),
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
          backgroundColor: widget.steps[index].state == StepState.editing ? Colors.white : const Color.fromRGBO(96, 188, 255, 0.2),
          animateFromLastPercent: true,
          center: Text(
            '${(0.4 * 100).toInt()}%',
            maxLines: 1,
            style: TextStyle(
              color: widget.steps[index].state == StepState.editing ? Colors.white : const Color.fromRGBO(15, 66, 176, 1),
              fontSize: isDesktop ? 16 : 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        )      ),
    );
  }


  Widget _buildIcon(int index) {
    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      duration: _kThemeAnimationDuration,
      child: _buildCircle(index, true),
    );
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
    isTablet = deviceScreenType == DeviceScreenType.tablet;

    final List<Widget> children = <Widget>[
      for (int i = 0; i < widget.steps.length; i++) ...<Widget>[

        Badge(
          showBadge: isDesktop ? false : widget.steps[i].state != StepState.editing,
          position: BadgePosition.topEnd(top: 0, end: 0),
          child: AnimatedContainer(
            key: _keys[i],
            constraints: isDesktop ? const BoxConstraints(maxWidth: 400) : null,
            height: isDesktop ? null : 94,
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              gradient: widget.steps[i].state == StepState.editing ? const LinearGradient(
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
            // margin: isDesktop ? null : const EdgeInsets.symmetric(horizontal: 6),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Focus(
              canRequestFocus: widget.steps[i].state != StepState.disabled,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {

                  Scrollable.ensureVisible(
                    _keys[i].currentContext!,
                    curve: Curves.fastOutSlowIn,
                    duration: _kThemeAnimationDuration,
                  );

                  if (widget.steps[i].state != StepState.disabled) return;
                  if (widget.onStepTapped != null) widget.onStepTapped!(i);

                },
                child: isDesktop
                    ? Row(
                        children: <Widget>[
                          SizedBox(
                            height: 80.0,
                            child: Center(
                              child: _buildIcon(i),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: const EdgeInsetsDirectional.only(start: _kStepSpacing),
                              child: DefaultTextStyle(
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                child: widget.steps[i].title,
                              ),
                            ),
                          )
                        ],
                      )
                    : ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: isDesktop ? 0.0 : isTablet ? 120.0 : 82.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              child: Center(
                                child: _buildIcon(i),
                              ),
                            ),
                            Flexible(
                              child: DefaultTextStyle(
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: widget.steps[i].state == StepState.editing ? Colors.white : const Color.fromRGBO(15, 66, 176, 1),
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w400,
                                ),
                                child: widget.steps[i].title,
                              ),
                            )
                          ],
                        ),
                      )
              ),
            ),
          ),
        ),

        if (!_isLast(i))
          const Expanded(child: SizedBox(height: 2)),

      ],

    ];

    return Row(children: children);

  }


}
