import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:json_form_builder/src/dependencies/bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../bs_flutter_selectbox/src/components/bs_wrapper_option.dart';
import 'fields/simple_field_bloc_builder.dart';
import 'utils/utils.dart';


class MultiSelectFieldBlocBuilder<Value> extends StatefulWidget {

  const MultiSelectFieldBlocBuilder({
    Key? key,
    required this.multiSelectFieldBloc,
    required this.itemBuilder,
    required this.decoration,
    required this.autoClose,
    required this.alwaysUpdate,
    required this.disabled,
    this.enableOnlyWhenFormBlocCanSubmit = false,
    this.isEnabled = true,
    this.title,
    this.errorBuilder,
    this.animateWhenCanShow = true,
    this.emptyItemLabel = '',
    this.onChanged,
    this.serverSide,
    this.onClear,
    this.onClose,
    this.onOpen,
  }) : super(key: key);

  final MultiSelectFieldBloc<String, dynamic> multiSelectFieldBloc;

  final FieldBlocErrorBuilder? errorBuilder;

  final FieldItemBuilder<Value> itemBuilder;

  final bool enableOnlyWhenFormBlocCanSubmit;

  final String? title;

  final bool isEnabled;

  final InputDecoration decoration;

  final bool animateWhenCanShow;

  final String emptyItemLabel;

  final ValueChanged<Value?>? onChanged;

  final bool disabled;

  final bool autoClose;

  final bool alwaysUpdate;

  final BsSelectBoxServerSide? serverSide;

  final VoidCallback? onClear;

  final VoidCallback? onOpen;

  final VoidCallback? onClose;


  @override
  State<MultiSelectFieldBlocBuilder<Value>> createState() => _MultiSelectFieldBlocBuilderState<Value>();

}

class _MultiSelectFieldBlocBuilderState<Value> extends State<MultiSelectFieldBlocBuilder<Value>> with TickerProviderStateMixin {

  MultiSelectFieldBloc<String, dynamic> get multiSelectFieldBloc => widget.multiSelectFieldBloc;

  final GlobalKey<State> _key = GlobalKey<State>();
  final GlobalKey<State> _keyOverlay = GlobalKey<State>();
  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();


  late final BsSelectBoxController bsController;
  late final AnimationController _animated = AnimationController(vsync: this, duration: const Duration(milliseconds: 180));
  late final AnimationController _arrowAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 180));
  late List<BsSelectBoxOption> _options;
  late Animation _arrowAnimation;


  BsWrapperOptions? _wrapperOptions;
  bool isOpen = false;
  DeviceScreenType deviceScreenType = DeviceScreenType.desktop;


  @override
  void initState() {

    bsController = BsSelectBoxController(
      multiple: true,
      options: _buildBsItems(
        context: context,
        items: multiSelectFieldBloc.state.items,
        isEnabled: widget.isEnabled,
        isSelected: false,
      )
    );

    _options = bsController.options;

    _focusNode.addListener(_onFocus);

    _arrowAnimation = Tween(begin: 0.0, end: 3.14).animate(_arrowAnimationController);

    super.initState();

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
          singleFieldBloc: multiSelectFieldBloc,
          animateWhenCanShow: widget.animateWhenCanShow,
          builder: (context, canShow) {
            return Container(
              margin: const EdgeInsets.only(bottom: 32),
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


                  BlocBuilder<MultiSelectFieldBloc<String, dynamic>, MultiSelectFieldBlocState<String, dynamic>>(
                    bloc: multiSelectFieldBloc,
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
          },
        )
    );
  }


  List<BsSelectBoxOption> _buildBsItems({required BuildContext context, required List<String> items, required bool isSelected, required bool isEnabled }) {

    final builder = widget.itemBuilder;

    return [

      ...items.map<BsSelectBoxOption>((value) {

        final fieldItem = builder(context, value as Value);

        return BsSelectBoxOption(
          value: value,
          text: _buildDefaultTextStyle(
            isEnabled: fieldItem.isEnabled && isEnabled,
            isSelected: isSelected,
            child: fieldItem.child,
          ),
        );

      })

    ];

  }


  InputDecoration _buildDecoration(BuildContext context, MultiSelectFieldBlocState<String, dynamic> state, bool isEnabled) {

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
        fieldBloc: multiSelectFieldBloc,
      ),
    );

    return decoration;
  }


  Widget _buildDefaultTextStyle({ required bool isEnabled, required bool isSelected, required Widget child,}) {
    return DefaultTextStyle(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: Style.resolveTextStyle(
        isEnabled: isEnabled,
        style: const TextStyle(),
        color: MaterialStateProperty.all<Color>(Colors.black),
      ),
      child: child,
    );
  }


  Widget renderContainer() {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextButton(
        key: _key,
        focusNode: _focusNode,
        onPressed: onPressed,
        style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.transparent)),
        child: DefaultTextStyle(
          style: const TextStyle(),
          child: Container(
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
                          : renderSelected(),
                    )
                ),


                if (bsController.getSelected() != null)
                  Container(
                    padding: const EdgeInsets.all(1.5),
                    margin: const EdgeInsets.only(right: 10.0),
                    child: IconButton(
                      onPressed: clear,
                      padding: const EdgeInsets.only(top: 2),
                      icon: Icon(
                          Icons.close,
                          size: 26,
                          color: widget.decoration.hintStyle?.color
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
                        color: widget.decoration.hintStyle?.color
                      ),
                    ),
                  ),
                )


              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget renderSelected() {

    List<Widget> children = [];

    bsController.getSelectedAll().forEach((option) {
        children.add(Container(
            margin: const EdgeInsets.only(right: 5.0, bottom: 1.0, top: 1.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {

                  if (_keyOverlay.currentState != null && _keyOverlay.currentState!.mounted)
                    _keyOverlay.currentState!.setState(() { });

                  bsController.removeSelected(option);

                  multiSelectFieldBloc.changeValue(bsController.getSelectedAll().map((value) => value.getValueAsString()).toList());

                  updateState(() {});

                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(right: 5.0),
                          child: option.getText(),
                        ),
                      )

                    ],
                  ),
                ),
              ),
            )
        ));
      });

    return Wrap(children: children);
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


  void _onFocus() {
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
      controller: bsController,
      containerMargin: EdgeInsets.zero,
      onClose: () => close(),
      onChange: (option) {


        if (bsController.getSelected() != null) {
          int index = bsController.getSelectedAll()
              .indexWhere((element) => element.getValue() == option.getValue());

          if (index != -1) bsController.removeSelectedAt(index);
          else bsController.setSelected(option);

        } else bsController.setSelected(option);


        if(widget.autoClose) close();
        if(widget.alwaysUpdate) api();

          widget.onChanged?.call(option.getValue());

        multiSelectFieldBloc.changeValue(bsController.getSelectedAll().map((value) => value.getValueAsString()).toList());

        _wrapperOptions!.update();


      },
      onSearch: (value) {

        if (widget.serverSide != null) {
          api(searchValue: value);
        }
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
      SelectBoxOverlayEntry overlayEntry = SelectBoxOverlay.add(
          OverlayEntry(builder: (context) => _wrapperOptions!), () => updateState(() => isOpen = false)
      );

      Overlay.of(context).insert(overlayEntry.overlayEntry);
    }
    else {
      _showModal();
    }

    if (widget.serverSide != null) api();
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

    bsController.clear();
    multiSelectFieldBloc.changeValue(bsController.getSelectedAll().map((value) => value.getValueAsString()).toList());
    widget.onClear?.call();

    close();
  }

  void _showModal() {

    TextEditingController textEditingController = TextEditingController();

    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      useRootNavigator: true,
      enableDrag: false,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      constraints: const BoxConstraints(
          maxWidth: 800
      ),
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
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
                        updateState(() {

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

                                  Expanded( child: Text(bsController.options[index].getValueAsString()) ),

                                  if (selected)
                                    const Icon(Icons.check, size: 17)

                                ],
                              ),
                            ),
                            onTap: () {


                              if (bsController.getSelected() != null) {
                                int index2 = bsController.getSelectedAll().indexWhere((element) => element.getValue() == bsController.options[index].getValue());

                                if (index2 != -1) bsController.removeSelectedAt(index2);
                                else bsController.setSelected(bsController.options[index]);

                              } else bsController.setSelected(bsController.options[index]);


                              if(widget.autoClose) close();
                              if(widget.alwaysUpdate) api();

                              if(widget.onChanged != null)
                                widget.onChanged!(bsController.options[index].getValue());

                              multiSelectFieldBloc.changeValue(bsController.getSelectedAll().map((value) => value.getValueAsString()).toList());

                              _wrapperOptions!.update();

                              setState(() {});

                              // Navigator.pop(context);

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
    _focusNode.removeListener(_onFocus);
    _focusNode.dispose();
    _animated.dispose();
    _arrowAnimationController.dispose();
    super.dispose();
    super.dispose();
  }

}
