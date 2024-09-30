import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef MenuBuilder = Widget Function(
  BuildContext context,
  double? width,
);

class DropdownBuilder extends StatefulWidget {
  const DropdownBuilder({
    super.key,
    required this.buttonBuilder,
    required this.menuBuilder,
  });

  final Widget Function(BuildContext context, Function() toggleDropped, bool opened) buttonBuilder;
  final Widget Function(BuildContext context, Function() close) menuBuilder;

  @override
  State<DropdownBuilder> createState() => _DropdownBuilderState();
}

class _DropdownBuilderState extends State<DropdownBuilder> {
  final _link = LayerLink();
  final OverlayPortalController _controller = OverlayPortalController();
  final ValueNotifier<bool> _opened = ValueNotifier(false);

  @override
  void initState() {
    super.initState();

    _opened.addListener(() {
      _buttonWidth = context.size?.width;

      if (!_opened.value) {
        _controller.hide();
      }
      else {
        _controller.show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _controller,
        overlayChildBuilder: (BuildContext context) {
          return CompositedTransformFollower(
            link: _link,
            targetAnchor: Alignment.bottomLeft,
            showWhenUnlinked: false,
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: buildMenu(),
            ),
          );
        },
        child: ValueListenableBuilder(
          valueListenable: _opened,
          builder: (context, value, child) {
            return widget.buttonBuilder(context, onButtonTap, _opened.value);
          }
        ),
      ),
    );
  }
  
  /// width of the button after the widget rendered
  double? _buttonWidth;

  void onButtonTap() {
    _opened.value = !_opened.value;
    //_buttonWidth = context.size?.width;
    // _controller.toggle();
  }

  void onItemTap() {
    _opened.value = false;
    //_controller.toggle();
  }

  buildMenu() {
    return SizedBox(
      width: _buttonWidth,
      child: widget.menuBuilder(context, onItemTap),
    );
  }
}