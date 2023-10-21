import 'package:flutter/material.dart';

class CollapsingTitle extends StatefulWidget {
  const CollapsingTitle(
      {super.key, required this.child, this.visibleOnCollapsed = false});

  final Widget child;
  final bool visibleOnCollapsed;

  @override
  State<CollapsingTitle> createState() => _CollapsingTitleState();
}

class _CollapsingTitleState extends State<CollapsingTitle> {
  ScrollPosition? _position;
  bool _visible = false;

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context).position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings? settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    bool visible =
        settings == null || settings.currentExtent <= settings.minExtent;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visibleOnCollapsed ? !_visible : _visible,
      child: widget.child,
    );
  }
}
