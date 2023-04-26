import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:json_form_builder/src/dependencies/flutter_form_bloc/src/fields/simple_field_bloc_builder.dart';
import 'package:json_form_builder/src/dependencies/flutter_form_bloc/src/utils/utils.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../bs_flutter_selectbox/bs_flutter_selectbox.dart';
import '../../bs_flutter_selectbox/src/components/bs_wrapper_option.dart';

class CountrySelectFieldBlocBuilder <Value> extends StatefulWidget {

  const CountrySelectFieldBlocBuilder({
    Key? key,
    required this.selectFieldBloc,
    required this.itemBuilder,
    required this.decoration,
    required this.searchable,
    required this.autoClose,
    required this.alwaysUpdate,
    required this.disabled,
    required this.paddingDialog,
    required this.marginDialog,
    required this.animateDuration,
    this.enableOnlyWhenFormBlocCanSubmit = false,
    this.isEnabled = true,
    this.errorBuilder,
    this.showEmptyItem = true,
    this.nextFocusNode,
    this.focusNode,
    this.textAlign,
    this.animateWhenCanShow = true,
    this.emptyItemLabel = '',
    this.onChanged,
    this.selectedTextStyle,
    this.selectedMaxLines,
    this.disabledHint,
    this.hasBottomMargin = true,
    this.hintText,
    this.hintTextLabel,
    this.noDataText,
    this.placeholderSearch,
    this.size = const BsSelectBoxSize(),
    this.style = BsSelectBoxStyle.bordered,
    this.serverSide,
    this.onRemoveSelectedItem,
    this.onClear,
    this.onClose,
    this.title,
    this.onOpen,
    this.dialogStyle = const BsDialogBoxStyle(),
  }) : super(key: key);

  final SelectFieldBloc<Value, dynamic> selectFieldBloc;

  final FieldBlocErrorBuilder? errorBuilder;

  final FieldItemBuilder<Value> itemBuilder;

  final bool enableOnlyWhenFormBlocCanSubmit;

  final bool hasBottomMargin;

  final bool isEnabled;

  final String? title;

  final bool showEmptyItem;

  final FocusNode? nextFocusNode;

  final FocusNode? focusNode;

  final InputDecoration decoration;

  final TextAlign? textAlign;

  final bool animateWhenCanShow;

  final String emptyItemLabel;

  final ValueChanged<Value?>? onChanged;

  final TextStyle? selectedTextStyle;

  final int? selectedMaxLines;

  final Widget? disabledHint;

  final BsSelectBoxSize size;

  final BsSelectBoxStyle style;

  final String? hintText;

  final String? hintTextLabel;

  final String? noDataText;

  final String? placeholderSearch;

  final bool searchable;

  final bool disabled;

  final bool autoClose;

  final bool alwaysUpdate;

  final BsSelectBoxServerSide? serverSide;

  final BsDialogBoxStyle dialogStyle;

  final EdgeInsetsGeometry paddingDialog;

  final EdgeInsets marginDialog;

  final ValueChanged<BsSelectBoxOption>? onRemoveSelectedItem;

  final VoidCallback? onClear;

  final VoidCallback? onOpen;

  final VoidCallback? onClose;

  final Duration animateDuration;

  @override
  State<CountrySelectFieldBlocBuilder<Value>> createState() => _CountrySelectFieldBlocBuilderState<Value>();
  
}

class _CountrySelectFieldBlocBuilderState<Value> extends State<CountrySelectFieldBlocBuilder<Value>> with SingleTickerProviderStateMixin {

  SelectFieldBloc<Value, dynamic> get selectFieldBloc => widget.selectFieldBloc;

  final GlobalKey<State> _key = GlobalKey<State>();
  final GlobalKey<State> _keyOverlay = GlobalKey<State>();
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNodeKeyboard = FocusNode();


  late final BsSelectBoxController bsController;
  late final FocusNode _focusNode = widget.focusNode == null ? FocusNode() : widget.focusNode!;
  late final AnimationController _arrowAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 180));
  late List<BsSelectBoxOption> _options;
  late Animation _arrowAnimation;


  BsWrapperOptions? _wrapperOptions;
  bool isOpen = false;
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

    _focusNode.addListener(onFocus);

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

          return Container(
            margin: EdgeInsets.only(bottom: widget.hasBottomMargin ? 32 : 0),
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
                      textAlign: widget.textAlign,
                      child: renderContainer(),
                    );

                  },
                )

              ],
            ),
          );
        },
      )
    );
  }


  List<BsSelectBoxOption> _buildBsItems({required BuildContext context, required Iterable<Value> items, required bool isSelected, required bool isEnabled }) {

    final builder = widget.itemBuilder;

    return [
      if (widget.showEmptyItem)

        BsSelectBoxOption(
          value: '',
          text: Text(
            isSelected ? widget.decoration.hintText ?? '' : widget.emptyItemLabel,
            style: isSelected
                ? widget.decoration.hintStyle
                : Style.resolveTextStyle(
              isEnabled: isEnabled, style: const TextStyle(), color: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
              // style: fieldTheme.textStyle!,
              // color: fieldTheme.textColor!,
            ),
          ),
        ),

      ...items.map<BsSelectBoxOption>((value) {

        final fieldItem = builder(context, value);

        return BsSelectBoxOption(
          value: value,
          other: value,
          text: _buildDefaultTextStyle(
            isEnabled: fieldItem.isEnabled && isEnabled,
            isSelected: isSelected,
            child: fieldItem.child,
          ),
        );

      })

    ];

  }


  InputDecoration _buildDecoration(BuildContext context, SelectFieldBlocState<Value, dynamic> state, bool isEnabled) {

    InputDecoration decoration = widget.decoration;

    decoration = decoration.copyWith(
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

    return decoration;
  }


  Widget _buildDefaultTextStyle({ required bool isEnabled, required bool isSelected, required Widget child }) {
    return DefaultTextStyle(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: Style.resolveTextStyle(
        isEnabled: isEnabled,
        style: widget.selectedTextStyle ?? const TextStyle( ),
        color: MaterialStateProperty.all<Color>(Colors.black),
      ),
      child: child,
    );
  }


  Widget renderContainer() {
    return CompositedTransformTarget(
      link: _layerLink,
      child: RawKeyboardListener(
        focusNode: _focusNodeKeyboard,
        onKey: (RawKeyEvent event) { if(event.logicalKey == LogicalKeyboardKey.escape) close(); },
        child: TextButton(
          key: _key,
          focusNode: _focusNode,
          onPressed: onPressed,
          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.transparent)),
          child: DefaultTextStyle(
            style: TextStyle(color: widget.style.textColor),
            child: Container(
              child: Row(
                children: [

                  Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        child: bsController.getSelectedAll().length == 0
                            ? widget.decoration.hintText == null
                            ? const Text('')
                            : Text(
                                widget.decoration.hintText!,
                                style: widget.decoration.hintStyle,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              )
                            : renderSelected(),
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
                          color: widget.style.textColor
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
                          color: widget.style.textColor,
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget renderSelected() {

    return DefaultTextStyle(
      style: TextStyle(
        fontSize: widget.size.fontSize,
        color: widget.style.selectedTextColor,
      ),
      child: Row(
        children: [

          Container(
            width: 50,
            child: Image.asset(
              'assets/images/flags/${bsController.getSelected()?.getOtherValue()['other']}.png',
              width: 32,
              height: 18,
            ),
          ),

          Flexible(
              child: Container(child: bsController.getSelected()!.getText()),
          )

        ],
      ),
    );
  }


  void _setValue () {

    Map<String, dynamic> data = selectFieldBloc.value as Map<String, dynamic>;

    Value value = { "name": data["text"] ?? data["name"], "value": data["value"], "other": data["other"] } as Value;

    bsController.setSelected(_buildBsItems(
        context: context,
        items: [ value ],
        isEnabled: widget.isEnabled,
        isSelected: true
    ).first);

  }


  void api({String searchValue = ''}) {

    updateState(() {
      bsController.processing = true;
      if (_keyOverlay.currentState != null && _keyOverlay.currentState!.mounted)
        _keyOverlay.currentState!.setState(() {});

      widget.serverSide!({'searchValue': searchValue}).then((response) {
        updateState(() {
          bsController.processing = false;
          bsController.options = response.options;
          if (_wrapperOptions != null)
            _wrapperOptions!.update();
        });

      });
    });


  }


  void onFocus() {
    if (_focusNode.hasFocus && !widget.disabled) open();
  }


  void updateState(Function function) {
    if(mounted)
      setState(() => function());
  }


  void onPressed() {

    if (!widget.disabled) {
      if (!isOpen) open();
      else close();
    }

    return null;
  }


  void open() {

    SelectBoxOverlay.removeAll();

    _arrowAnimationController.forward();

    _wrapperOptions = BsWrapperOptions(
      key: _keyOverlay,
      link: _layerLink,
      containerKey: _key,
      padding: widget.paddingDialog,
      margin: widget.marginDialog,
      selectBoxStyle: widget.style,
      selectBoxSize: widget.size,
      style: widget.dialogStyle,
      searchable: widget.searchable,
      noDataText: widget.noDataText!,
      placeholderSearch: widget.placeholderSearch!,
      controller: bsController,
      containerMargin: EdgeInsets.zero,
      onClose: () => close(),
      onChange: (option) {

        try {

        bsController.setSelected(option);

        if(widget.autoClose) close();
        if(widget.alwaysUpdate) api();

        selectFieldBloc.changeValue(option.getOtherValue());

        widget.onChanged?.call(option.getValue());

        _wrapperOptions!.update();

        }
        catch(error) {print(error);}

      },
      onSearch: (value) {

        if (widget.serverSide != null) api(searchValue: value);
        else {
          updateState(() {
            bsController.options = _options.where((element) => value.toLowerCase() == '' || element.searchable.toLowerCase().contains(value.toLowerCase())).toList();
            if (_keyOverlay.currentState != null && _keyOverlay.currentState!.mounted)
              _keyOverlay.currentState!.setState(() {});
          });
        }

      },
    );


    if (deviceScreenType == DeviceScreenType.desktop) {
      SelectBoxOverlayEntry overlayEntry = SelectBoxOverlay.add(OverlayEntry(builder: (context) => _wrapperOptions!), () => updateState(() => isOpen = false));
      Overlay.of(context).insert(overlayEntry.overlayEntry);
    }
    else { _showModal(); }


    FocusScope.of(context).requestFocus(_focusNodeKeyboard);

    if (widget.serverSide != null) api();

    if(widget.onOpen != null)
      widget.onOpen!();

    updateState(() => isOpen = true);
  }


  void close() {

    SelectBoxOverlay.removeAll();

    _arrowAnimationController.reverse();

    if(widget.onClose != null)
      widget.onClose!();

    updateState(() => isOpen = false);
  }


  void clear() {

    SelectBoxOverlay.removeAll();
    bsController.clear();

    selectFieldBloc.changeValue(null);

    if(widget.onChanged != null)
      widget.onChanged!(null);

    if(widget.onClear != null)
      widget.onClear!();

    close();
  }


  void _showModal() {

    TextEditingController textEditingController = TextEditingController();

    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      useRootNavigator: true,
      enableDrag: false,
      constraints: const BoxConstraints( maxWidth: 900 ),
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
                          borderRadius:
                          new BorderRadius.circular(15.0),
                          borderSide: const BorderSide(),
                        ),
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Поиск'
                    ),
                    onChanged: (value) {

                      if (widget.serverSide != null) api(searchValue: value);
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
                      separatorBuilder: (context, int) => const Divider(height: 1,),
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
                                if(widget.alwaysUpdate) api();

                                selectFieldBloc.changeValue(bsController.options[index].getOtherValue());

                                if(widget.onChanged != null)
                                  widget.onChanged!(bsController.getSelected()?.getValue());

                                _wrapperOptions!.update();

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
  void dispose() {
    _focusNode.removeListener(onFocus);
    _focusNode.dispose();
    _arrowAnimationController.dispose();
    super.dispose();
  }

}
