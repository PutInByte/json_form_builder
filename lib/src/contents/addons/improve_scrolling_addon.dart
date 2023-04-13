import 'package:flutter/material.dart';

class ImproveScrollAddon extends StatefulWidget {

  const ImproveScrollAddon({ Key? key, required this.scrollController, this.onScroll, required this.child }) : super(key: key);

  final ScrollController scrollController;
  final Function(double)? onScroll;
  final Widget child;

  @override
  State<ImproveScrollAddon> createState() => _ImproveScrollAddonState();
}

class _ImproveScrollAddonState extends State<ImproveScrollAddon> {

  late double _maxScrollExtent = widget.scrollController.position.maxScrollExtent;

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(_scrollControllerListener);

  }


  void _scrollControllerListener() {

    if (widget.scrollController.position.pixels >= _maxScrollExtent) return;

    widget.onScroll?.call(widget.scrollController.offset);

  }


  @override
  Widget build(BuildContext context) {
    if (widget.scrollController.hasClients)
      _maxScrollExtent = widget.scrollController.position.maxScrollExtent;
    return widget.child;
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollControllerListener);
    super.dispose();
  }

}
