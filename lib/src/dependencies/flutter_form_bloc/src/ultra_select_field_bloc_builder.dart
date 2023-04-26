import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../bs_flutter_selectbox/bs_flutter_selectbox.dart';
import '../../bs_flutter_selectbox/src/components/bs_wrapper_option.dart';
import '../src/features/appear/can_show_field_bloc_builder.dart';
import '../src/theme/field_theme_resolver.dart';
import '../src/theme/form_bloc_theme.dart';
import '../src/utils/utils.dart';
import 'fields/ultra_select_field.dart';

export 'package:flutter/services.dart' show TextInputType, TextInputAction, TextCapitalization;
export 'package:flutter/widgets.dart' show EditableText;

class UltraSelectFieldBlocBuilder<Value> extends StatefulWidget {

  const UltraSelectFieldBlocBuilder({
    Key? key,
    required this.field,
    required this.itemBuilder,
    this.enableOnlyWhenFormBlocCanSubmit = false,
    this.isEnabled = true,
    this.errorBuilder,
    this.title,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.showSuggestionsWhenIsEmpty = true,
    this.serverSide,
    this.countryServerSide,
    this.animateWhenCanShow = true,
    this.autofillHints,
    this.onClear,
    this.onOpen,
    this.onClose,
  })  : super(key: key);


  final SpecifyFieldBloc<Value> field;

  final FieldItemBuilder<Value> itemBuilder;

  final String? title;

  final BsSelectBoxServerSide? countryServerSide;

  final FieldBlocErrorBuilder? errorBuilder;

  final bool enableOnlyWhenFormBlocCanSubmit;

  final bool isEnabled;

  final VoidCallback? onClear;

  final VoidCallback? onOpen;

  final VoidCallback? onClose;

  final BsSelectBoxServerSide? serverSide;

  final bool showSuggestionsWhenIsEmpty;

  final InputDecoration decoration;

  final ValueChanged<String>? onChanged;

  final VoidCallback? onEditingComplete;

  final ValueChanged<String>? onSubmitted;

  final List<TextInputFormatter>? inputFormatters;

  final bool animateWhenCanShow;

  final Iterable<String>? autofillHints;

  TextFieldTheme themeStyleOf(BuildContext context) {

    final theme = Theme.of(context);
    final formTheme = FormTheme.of(context);
    final fieldTheme = formTheme.textTheme;
    final resolver = FieldThemeResolver(theme, formTheme, fieldTheme);

    return TextFieldTheme(
      decorationTheme: resolver.decorationTheme,
      textStyle: resolver.textStyle,
      textColor: resolver.textColor,
      textAlign: fieldTheme.textAlign ?? TextAlign.start,
    );
  }

  @override
  State<UltraSelectFieldBlocBuilder<Value>> createState() => _UltraSelectFieldBlocBuilderState<Value>();

}

class _UltraSelectFieldBlocBuilderState<Value> extends State<UltraSelectFieldBlocBuilder<Value>> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {


  SpecifyFieldBloc<Value> get fieldBloc => widget.field;

  final GlobalKey<State> _key = GlobalKey<State>();
  final GlobalKey<State> _keyOverlay = GlobalKey<State>();
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();

  late final BsSelectBoxController bsCountryController;
  late final BsSelectBoxController bsCheckpointController;
  late final TextEditingController _controller;

  late final AnimationController _arrowAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 180));
  late Animation _arrowAnimation;

  late List<BsSelectBoxOption> _optionsCheckpoints;
  late List<BsSelectBoxOption> _optionsCountry;

  DeviceScreenType deviceScreenType = DeviceScreenType.desktop;
  BsWrapperOptions? _wrapperOptions;
  bool isOpen = false;



  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: fieldBloc.specifyVehicleNumber.state.value);
    _controller.addListener(_textControllerListener);

    bsCheckpointController = BsSelectBoxController(
      options: _buildBsItems(
        context: context,
        items: fieldBloc.specifyCheckPoint.state.items,
        isEnabled: widget.isEnabled,
        isSelected: false,
      )
    );

    bsCountryController = BsSelectBoxController(
      options: _buildBsItems(
        context: context,
        items: fieldBloc.specifyState.state.items,
        isEnabled: widget.isEnabled,
        isSelected: false,
      )
    );

    _optionsCheckpoints = bsCheckpointController.options;

    _optionsCountry = bsCountryController.options;

    _arrowAnimation = Tween(begin: 0.0, end: 3.14).animate(_arrowAnimationController);

  }


  @override
  void dispose() {
    _controller.removeListener(_textControllerListener);
    _controller.dispose();
    _focusNode.dispose();
    _arrowAnimationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);

    final fieldTheme = widget.themeStyleOf(context);
    deviceScreenType = getDeviceType(MediaQuery.of(context).size);

    return WillPopScope(
      onWillPop: () async {

        bool returned = true;

        if(isOpen) {
          returned = false;
          close();
        }

        return returned;
      },
      child: CanShowFieldBlocBuilder(
        fieldBloc: fieldBloc,
        animate: widget.animateWhenCanShow,
        builder: (_, __) {

          if (fieldBloc.specifyState.value != null) _setValue(field: fieldBloc.specifyState, bsController: bsCountryController );

          return Container(
            margin: EdgeInsets.only(bottom: deviceScreenType == DeviceScreenType.desktop ? 32 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                if (widget.title != null) ...[
                    Text(
                      widget.title!,
                     style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(height: 7),
                  ],

                BlocBuilder<SpecifyFieldBloc<Value>, dynamic>(
                  bloc: fieldBloc,
                  builder: (context, state) {

                    // if (_controller.text != fieldBloc.specifyVehicleNumber.state.value) {
                    //   _fixControllerTextValue(fieldBloc.specifyVehicleNumber.state.value);
                    // }

                    if (fieldBloc.specifyCheckPoint.state.value != null) _setValue(field: fieldBloc.specifyCheckPoint, bsController: bsCheckpointController);

                    return InputDecorator(
                      decoration: _buildDecoration(fieldTheme, fieldBloc.specifyVehicleNumber.state),
                      child: renderContainer(),
                    );

                  },
                )

              ],
            ),
          );
        },
      ),
    );
  }


  List<BsSelectBoxOption> _buildBsItems({required BuildContext context, required Iterable<Value> items, required bool isSelected, required bool isEnabled }) {

    final builder = widget.itemBuilder;

    return items.map<BsSelectBoxOption>((value) {

      final fieldItem = builder(context, value);

      return BsSelectBoxOption(
        value: value,
        text: DefaultTextStyle(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: Style.resolveTextStyle(
            isEnabled: fieldItem.isEnabled && isEnabled,
            style: const TextStyle(),
            color: MaterialStateProperty.all<Color>(Colors.black),
          ),
          child: fieldItem.child,
        ),
      );

    }).toList(growable: false);

  }

  InputDecoration _buildDecoration(TextFieldTheme fieldTheme, TextFieldBlocState state) {

    InputDecoration decoration = widget.decoration;

    decoration = decoration.copyWith(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      errorText: Style.getErrorText(
        context: context,
        errorBuilder: widget.errorBuilder,
        fieldBlocState: state,
        fieldBloc: fieldBloc.specifyVehicleNumber,
      ),
    );

    return decoration.applyDefaults(fieldTheme.decorationTheme!);
  }

  Widget renderContainer() {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        key: _key,
        child:Row(
          children: [

            Expanded(
              flex: deviceScreenType != DeviceScreenType.desktop ? 0 : 1,
              child: TextButton(
                focusNode: _focusNode,
                onPressed: () => _onPressed(
                    bsController: bsCountryController,
                    options: _optionsCountry,
                    onChange: (option) {
                      fieldBloc.specifyState.changeValue(option.getOtherValue());
                    }
                ),
                style: const ButtonStyle(overlayColor: MaterialStatePropertyAll(Colors.transparent)),
                child: Tooltip(
                  message: bsCountryController.getSelected()?.getValue()["name"] ?? "",
                  child: Row(
                    children: [

                      Container(
                        width: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: kDebugMode ? Image.asset(
                          'assets/images/flags/${bsCountryController.getSelected()?.getValue()["other"]}.png',
                          width: 32,
                        ) : Image.network(
                          'assets/images/flags/${bsCountryController.getSelected()?.getValue()["other"]}.png',
                          width: 32,
                        ),
                      ),

                      if (deviceScreenType == DeviceScreenType.desktop) ...[

                        Container(
                          color: Theme.of(context).colorScheme.secondary,
                          height: 15,
                          width: 1,
                          margin: const EdgeInsets.symmetric(vertical: 7),
                        ),

                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: bsCountryController.getSelectedAll().isEmpty
                                  ? widget.decoration.hintText == null
                                  ? const Text('')
                                  : Text(
                                widget.decoration.hintText!,
                                style: widget.decoration.hintStyle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ) : DefaultTextStyle(
                                maxLines: 1,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis
                                ),
                                child: bsCountryController.getSelected()!.getText(),
                              ),
                            )
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Icon(CupertinoIcons.search ),
                        )
                      ]

                    ],
                  ),
                ),
              ),
            ),

            Container(
              color: Theme.of(context).colorScheme.secondary,
              height: 15,
              width: 1,
            ),

            Expanded(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Введите номер',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                ),
                onFieldSubmitted: _onSubmitted,
                onChanged: (value) {
                  fieldBloc.specifyVehicleNumber.changeValue(value);
                  if (widget.onChanged != null) {
                    widget.onChanged!(value);
                  }
                },
              ),
            ),

            Container(
              color: Theme.of(context).colorScheme.secondary,
              height: 15,
              width: 1,
            ),

            Expanded(
              flex: deviceScreenType != DeviceScreenType.desktop ? 0 : 1,
              child: TextButton(
                focusNode: _focusNode,
                onPressed: () => _onPressed(
                  bsController: bsCheckpointController,
                  options: _optionsCheckpoints,
                  onChange: (option) {
                    fieldBloc.specifyCheckPoint.changeValue(option.getOtherValue());
                  },
                ),
                style: const ButtonStyle(overlayColor: MaterialStatePropertyAll(Colors.transparent)),
                child: Tooltip(
                  message: bsCheckpointController.getSelected()?.getValue()["name"] ?? "",
                  child: Row(
                    children: [

                      if (deviceScreenType != DeviceScreenType.desktop) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Icon(
                            IconData(int.parse(bsCheckpointController.getSelected()?.getValue()["other"] ?? "0xe1d7"), fontFamily: 'M'
                                'aterialIcons',),
                            size: 26,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        )
                      ],

                      if (deviceScreenType == DeviceScreenType.desktop) ...[

                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: bsCheckpointController.getSelectedAll().isEmpty
                                  ? widget.decoration.hintText == null
                                  ? const Text('')
                                  : Text(
                                widget.decoration.hintText!,
                                style: widget.decoration.hintStyle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ) : DefaultTextStyle(
                                maxLines: 1,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis
                                ),
                                child: bsCheckpointController.getSelected()!.getText(),
                              ),
                            )
                        ),

                        Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          child: AnimatedBuilder(
                            animation: _arrowAnimationController,
                            builder: (context, child) => Transform.rotate(
                              angle: _arrowAnimation.value,
                              child: const Icon(
                                Icons.expand_more,
                                size: 26,
                              ),
                            ),
                          ),
                        )

                      ],

                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void _textControllerListener() {
    if (fieldBloc.specifyVehicleNumber.state.formBloc?.state is FormBlocSubmitting) {
      if (_controller.text != (fieldBloc.specifyVehicleNumber.value)) {
        _fixControllerTextValue(fieldBloc.specifyVehicleNumber.value);
      }
    }
  }

  void _onSubmitted(String value) {
      widget.onSubmitted?.call(value);
  }

  void _fixControllerTextValue(String value) async {
    _controller
      ..text = value
      ..selection = TextSelection.collapsed(offset: _controller.text.length);

    await Future.delayed(const Duration(milliseconds: 0));

    _controller.selection = TextSelection.collapsed(offset: _controller.text.length);
  }

  void _setValue({ required SelectFieldBloc<Value, dynamic> field, required BsSelectBoxController bsController }) {

    Map<String, dynamic> data = field.value as Map<String, dynamic>;

    Value value = { "name": data["text"] ?? data["name"], "value": data["value"], "other": data["other"] } as Value;

    bsController.setSelected(_buildBsItems(
        context: context,
        items: [ value ],
        isEnabled: widget.isEnabled,
        isSelected: true
    ).first);

  }

  /// This method is called when the [SelectFieldBloc] is initialized.
  // void _onFocus({ required BsSelectBoxController bsController, required List<BsSelectBoxOption> options, Function(BsSelectBoxOption)? onChange}) {
  //   if (_focusNode.hasFocus && widget.isEnabled) open(bsController: bsController, options: options, onChange: onChange);
  // }

  void updateState(Function function) {
    if(mounted) setState(() => function());
  }

  void _onPressed({ required BsSelectBoxController bsController,  required List<BsSelectBoxOption> options,  Function(BsSelectBoxOption)? onChange}) {

    if (widget.isEnabled) {
      if (!isOpen) open(bsController: bsController, options: options, onChange: onChange);
      else close();
    }

  }

  void open({ required BsSelectBoxController bsController, required List<BsSelectBoxOption> options, Function(BsSelectBoxOption)? onChange}) {

    SelectBoxOverlay.removeAll();

    _arrowAnimationController.forward();

    _wrapperOptions = BsWrapperOptions(
      key: _keyOverlay,
      link: _layerLink,
      containerKey: _key,
      controller: bsController,
      searchable: true,
      onClose: () => close(),
      onChange: (BsSelectBoxOption option) {
        try {

          bsController.setSelected(option);

          onChange?.call(option);

          close();
          if (widget.countryServerSide != null) api(searchValue: "", bsController: bsCountryController);

          _wrapperOptions?.update();

        }
        catch(error) { print(error); }

      },
      onSearch: (value) {

        if (widget.countryServerSide != null) api(searchValue: value, bsController: bsCountryController);
        updateState(() {
            bsController.options = options.where((element) => value.toLowerCase() == '' || element.searchable.toLowerCase().contains(value.toLowerCase())).toList();
            if (_keyOverlay.currentState != null && _keyOverlay.currentState!.mounted)
              _keyOverlay.currentState!.setState(() {});
          });

      },
    );

    if (deviceScreenType == DeviceScreenType.desktop) {
      SelectBoxOverlayEntry overlayEntry = SelectBoxOverlay.add(OverlayEntry(builder: (context) => _wrapperOptions!), () => updateState(() => isOpen = false));
      Overlay.of(context).insert(overlayEntry.overlayEntry);
    }
    else { _showModal(bsController: bsController, options: options, onChange: onChange); }

    if (widget.countryServerSide != null) api(searchValue: "", bsController: bsCountryController);

    widget.onOpen?.call();

    updateState(() => isOpen = true);
  }

  void close() {

    SelectBoxOverlay.removeAll();

    _arrowAnimationController.reverse();

    widget.onClose?.call();

    updateState(() => isOpen = false);
  }

  void clear() {

    bsCheckpointController.clear();

    fieldBloc.specifyCheckPoint.changeValue(null);

    widget.onClear?.call();

    close();
  }

  void api({String searchValue = '', required BsSelectBoxController bsController, }) {

    bsController.processing = true;
    if (_keyOverlay.currentState != null && _keyOverlay.currentState!.mounted)
      _keyOverlay.currentState!.setState(() {});

    widget.countryServerSide!({'searchValue': searchValue}).then((response) {

        bsController.processing = false;
        bsController.options = response.options;
        _wrapperOptions?.update();
        updateState(() { });

    });

    updateState(() { });

  }

  void _showModal({ required BsSelectBoxController bsController, required List<BsSelectBoxOption> options, Function(BsSelectBoxOption)? onChange }) {

    TextEditingController textEditingController = TextEditingController();

    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      useRootNavigator: true,
      enableDrag: false,
      constraints: const BoxConstraints(
          maxWidth: 900
      ),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            padding: const EdgeInsets.only(top: 24),
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Поиск'
                    ),
                    onChanged: (value) {

                      if (widget.countryServerSide != null) api(searchValue: value, bsController: bsCountryController);

                      bsController.options = options.where((element) => value.toLowerCase() == '' || element.searchable.toLowerCase().contains(value.toLowerCase())).toList();
                      if (_keyOverlay.currentState != null && _keyOverlay.currentState!.mounted)
                        _keyOverlay.currentState!.setState(() {});

                      setState(() { });


                    },
                  ),
                ),

                if (bsController.processing)
                  const Text('processing'),

                if (!bsController.processing)
                  Expanded(
                    child: ListView.separated(
                      itemCount: bsController.options.length,
                      separatorBuilder: ( context, int index ) => const Divider(height: 1,),
                      itemBuilder: (context, index) {

                        bool selected = false;

                        if (bsController.getSelected() != null) {
                          int index2 = bsController.getSelectedAll().indexWhere((element) => element.getValue() == bsController.options[index].getValue());

                          if (index2 != -1) { selected = true; }

                          else { selected = false;  }

                        } else { selected = false; }

                        return Material(
                          color: selected ? const Color.fromRGBO(236, 236, 236, 1.0) : null,
                          child: InkWell(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                              child: Row(

                                children: [

                                  Expanded( child: bsController.options[index].getText() ),

                                  if (selected)
                                    const Icon(Icons.check, size: 17)

                                ],
                              ),
                            ),
                            onTap: () {

                              try {

                                bsController.setSelected(bsController.options[index]);

                                onChange?.call(bsController.options[index]);

                                _wrapperOptions?.update();

                                close();

                              }
                              catch(error) { print(error); }

                              Navigator.pop(context);

                            },
                          ),
                        );
                      },
                    ),
                  )

              ],
            ),
          );
        },
      ),
    ).whenComplete(close);

  }


  @override
  bool get wantKeepAlive => true;


}
