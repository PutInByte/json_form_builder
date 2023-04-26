import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:json_form_builder/src/dependencies/bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:json_form_builder/src/dependencies/bs_flutter_selectbox/src/components/bs_wrapper_option.dart';
import 'package:json_form_builder/src/dependencies/flutter_form_bloc/src/utils/utils.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'fields/simple_field_bloc_builder.dart';


class SelectFieldBlocBuilder<Value> extends StatefulWidget {

  const SelectFieldBlocBuilder({
    Key? key,
    required this.selectFieldBloc,
    required this.itemBuilder,
    required this.decoration,
    required this.autoClose,
    required this.alwaysUpdate,
    required this.disabled,
    this.dependFieldBloc,
    this.enableOnlyWhenFormBlocCanSubmit = false,
    this.isEnabled = true,
    this.errorBuilder,
    this.animateWhenCanShow = true,
    this.onChanged,
    this.selectedMaxLines,
    this.hasBottomMargin = true,
    this.serverSide,
    this.onClear,
    this.onClose,
    this.title,
    this.onOpen,
  }) : super(key: key);

  final SelectFieldBloc<Value, dynamic> selectFieldBloc;

  final SelectFieldBloc<Value, dynamic>? dependFieldBloc;

  final FieldBlocErrorBuilder? errorBuilder;

  final String? title;

  final FieldItemBuilder<Value> itemBuilder;

  final bool enableOnlyWhenFormBlocCanSubmit;

  final bool hasBottomMargin;

  final bool isEnabled;

  final InputDecoration decoration;

  final bool animateWhenCanShow;

  final ValueChanged<Value?>? onChanged;

  final int? selectedMaxLines;

  final bool disabled;

  final bool autoClose;

  final bool alwaysUpdate;

  final BsSelectBoxServerSide? serverSide;

  final VoidCallback? onClear;

  final VoidCallback? onOpen;

  final VoidCallback? onClose;

  @override
  State<SelectFieldBlocBuilder<Value>> createState() => _SelectFieldBlocBuilderState<Value>();
  
}

class _SelectFieldBlocBuilderState<Value> extends State<SelectFieldBlocBuilder<Value>> with SingleTickerProviderStateMixin  {

  SelectFieldBloc<Value, dynamic> get selectFieldBloc => widget.selectFieldBloc;

  final GlobalKey<State> _key = GlobalKey<State>();
  final GlobalKey<State> _keyOverlay = GlobalKey<State>();
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();

  late final BsSelectBoxController bsController;
  late final AnimationController _arrowAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 180));
  late List<BsSelectBoxOption> _options;
  late Animation _arrowAnimation;

  bool isOpen = false;
  BsWrapperOptions? _wrapperOptions;
  DeviceScreenType deviceScreenType = DeviceScreenType.desktop;

  @override
  void initState() {

    super.initState();

    bsController = BsSelectBoxController(
      options: _buildBsItems(
        context: context,
        items: selectFieldBloc.state.items,
        isEnabled: widget.isEnabled,
        isSelected: false,
      )
    );

    _options = bsController.options;

    _focusNode.addListener(_onFocus);

    _arrowAnimation = Tween(begin: 0.0, end: 3.14).animate(_arrowAnimationController);

  }

  @override
  Widget build(BuildContext context) {

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
      child: SimpleFieldBlocBuilder(
        singleFieldBloc: selectFieldBloc,
        animateWhenCanShow: widget.animateWhenCanShow,
        builder: (context, canShow) {

          if (selectFieldBloc.value != null) _setValue();

          Widget content = Container(
            margin: kIsWeb ? EdgeInsets.only(bottom: widget.hasBottomMargin ? 30 : 0) : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                if (widget.title != null)
                  ...[
                    Text(
                      widget.title!,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),

                    const SizedBox(height: 8),
                  ],

                BlocBuilder<SelectFieldBloc<Value, dynamic>, SelectFieldBlocState<Value, dynamic>>(
                  bloc: selectFieldBloc,
                  builder: (context, fieldState) {

                    final isEnabled = fieldBlocIsEnabled(
                      isEnabled: widget.isEnabled,
                      enableOnlyWhenFormBlocCanSubmit: widget.enableOnlyWhenFormBlocCanSubmit,
                      fieldBlocState: fieldState,
                    );

                    final decoration = _buildDecoration(context, fieldState, isEnabled);

                    return InputDecorator(
                      decoration: decoration,
                      child: renderContainer(),
                    );

                  },
                )

              ],
            ),
          );

          if (widget.dependFieldBloc != null) {
            return BlocBuilder<SelectFieldBloc<Value, dynamic>, SelectFieldBlocState<Value, dynamic>>(
              bloc: widget.dependFieldBloc!,
              builder: (context, state) {

                if (state.value == null && bsController.getSelected() != null) {
                  bsController.clear();
                  selectFieldBloc.changeValue(null);
                }

                return content;

              },
            );
          }
          else return content;

        },
      )
    );
  }

  List<BsSelectBoxOption> _buildBsItems({
    required BuildContext context, required Iterable<Value> items,
    required bool isSelected, required bool isEnabled }) {

    final builder = widget.itemBuilder;

    return items.map<BsSelectBoxOption>((value) {

      final fieldItem = builder(context, value);

      return BsSelectBoxOption(
        value: value,
        other: value,
        text: fieldItem.child,
      );

    }).toList();

  }

  InputDecoration _buildDecoration(BuildContext context, SelectFieldBlocState<Value, dynamic> state, bool isEnabled) {

    InputDecoration decoration = widget.decoration;

    return decoration.copyWith(
      enabled: isEnabled,
      suffix: const SizedBox.shrink(),
      suffixIcon: const SizedBox.shrink(),
      suffixIconConstraints: const BoxConstraints(),
      errorText: Style.getErrorText(
        context: context,
        errorBuilder: widget.errorBuilder,
        fieldBlocState: state,
        fieldBloc: selectFieldBloc,
      ),
    );
  }

  Widget renderContainer() {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextButton(
        key: _key,
        focusNode: _focusNode,
        onPressed: _onPressed,
        style: const ButtonStyle(
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Theme.of(context).hintColor,
            fontSize: 16.0,
          ),
          child: Row(
            children: [

              Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: bsController.getSelectedAll().isEmpty
                        ? widget.decoration.hintText == null
                        ? const Text('')
                        : Text(
                      widget.decoration.hintText!,
                      style: widget.decoration.hintStyle,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                        : Container(child: bsController.getSelected()!.getText()),
                  )
              ),

              if (bsController.getSelected() != null)
                Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    onPressed: clear,
                    padding: const EdgeInsets.only(top: 2),
                    icon: Icon(
                      Icons.close,
                      size: 23,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ),


              Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: AnimatedBuilder(
                  animation: _arrowAnimationController,
                  builder: (context, child) => Transform.rotate(
                    angle: _arrowAnimation.value,
                    child: Icon(
                      Icons.expand_more,
                      size: 26,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  void updateState(Function function) {
    if(mounted)
      setState(() => function());
  }

  void open() {

    _arrowAnimationController.forward();

    SelectBoxOverlay.removeAll();

    _wrapperOptions = BsWrapperOptions(
      key: _keyOverlay,
      link: _layerLink,
      containerKey: _key,
      controller: bsController,
      containerMargin: EdgeInsets.zero,
      onClose: () => close(),
      onChange: _onChange,
      onSearch: _onSearch,
    );

    if (deviceScreenType == DeviceScreenType.desktop) {
      SelectBoxOverlayEntry overlayEntry = SelectBoxOverlay.add(OverlayEntry(builder: (context) => _wrapperOptions!), () => updateState(() => isOpen = false));
      Overlay.of(context).insert(overlayEntry.overlayEntry);
    }
    else { _showModal(); }

    if (widget.serverSide != null) _api();

    widget.onOpen?.call();

    updateState(() => isOpen = true);

  }

  void close() {

    _arrowAnimationController.reverse();

    SelectBoxOverlay.removeAll();

    widget.onClose?.call();

    updateState(() => isOpen = false);

  }

  void clear() {

    bsController.clear();
    selectFieldBloc.changeValue(null);
    widget.onChanged?.call(null);
    widget.onClear?.call();

    close();
  }
  
  void _onChange(BsSelectBoxOption option) {

    try {
      bsController.setSelected(option);

      if(widget.autoClose) close();
      if(widget.alwaysUpdate) _api();

      selectFieldBloc.changeValue(option.getOtherValue());

      widget.onChanged?.call(option.getValue());
      _wrapperOptions?.update();
    }
    catch(error) { print(error); }

  }

  void _onSearch(String value) {

    if (widget.serverSide != null) _api(searchValue: value);
    else {
      bsController.options = _options.where((element) => value.toLowerCase() == ''
          || element.searchable.toLowerCase().contains(value.toLowerCase())).toList();
      // if (_keyOverlay.currentState != null && _keyOverlay.currentState!.mounted)
      _keyOverlay.currentState!.setState(() {});
      updateState(() { });
    }

  }

  void _onFocus() {
    if (_focusNode.hasFocus && !widget.disabled) open();
  }

  void _onPressed() {
    if (!widget.disabled) {
      if (!isOpen) open();
      else close();
    }
  }
  
  void _showModal() {

    TextEditingController textEditingController = TextEditingController();

    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      useRootNavigator: true,
      enableDrag: false,
      backgroundColor: Colors.white,
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
                          borderSide: const BorderSide(),
                        ),
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Поиск'
                    ),
                    onChanged: (value) {

                      if (widget.serverSide != null) _api(searchValue: value);
                      else {
                        updateState((){

                          bsController.options = _options.where((element) => value.toLowerCase() == '' || element.searchable.toLowerCase().contains(value.toLowerCase())).toList();
                          setState(() {});

                        });
                      }

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
                      separatorBuilder: (context, int index) => const Divider(height: 1,),
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

                                  Expanded(child: bsController.options[index].getText()),

                                  if (selected)
                                    const Icon(Icons.check, size: 17)

                                ],
                              ),
                            ),
                            onTap: () {

                              try {

                                bsController.setSelected(bsController.options[index]);

                                if(widget.autoClose) close();
                                if(widget.alwaysUpdate) _api();

                                selectFieldBloc.changeValue(bsController.options[index].getOtherValue());

                                if(widget.onChanged != null)
                                  widget.onChanged!(bsController.getSelected()?.getValue());

                                _wrapperOptions?.update();

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

  void _setValue () {

    Map<String, dynamic> data = selectFieldBloc.value as Map<String, dynamic>;

    Value value = { "name": data["text"] ?? data["name"], "value": data["value"], "other": data["extraData"] } as Value;

    bsController.setSelected(_buildBsItems(
        context: context,
        items: [ value ],
        isEnabled: widget.isEnabled,
        isSelected: true
    ).first);

  }

  void _api({String searchValue = ''}) {

    bsController.processing = true;

    updateState(() {  });

    if (_keyOverlay.currentState != null && _keyOverlay.currentState!.mounted)
      _keyOverlay.currentState!.setState(() {});

    widget.serverSide!({ 'searchValue': searchValue }).then((response) {
      bsController.processing = false;
      bsController.options = response.options;

      _wrapperOptions?.update();

      updateState(() {  });
    });

  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocus);
    _focusNode.dispose();
    _arrowAnimationController.dispose();
    super.dispose();
  }

}
