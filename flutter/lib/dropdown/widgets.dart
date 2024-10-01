import 'package:flutter/material.dart';

class DefaultDropdownSelector extends StatelessWidget {
  final ValueNotifier<String> selectedController;
  final List<String> options;

  const DefaultDropdownSelector({
    required this.selectedController,
    required this.options
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSelectorBuilder(
      selectedController: selectedController, 
      options: options,
      headBuilder: (selectedValue, opened) => DropdownHeadSkeleton(
        title: Text(
          selectedValue,
          style: Theme.of(context).textTheme.titleMedium
        ), 
        icon: Icon(opened ? Icons.arrow_drop_up : Icons.arrow_drop_down),
      ),
      bodyContainerBuilder: (children) => DropdownColumn(
        maxHeight: 180,
        children: children,
      ),
      optionBuilder: (option) => StringOptionView(
        height: 60,
        option: option,
      )
    );
  }
}

class StringOptionView extends StatelessWidget {
  final String option;
  final double height;

  const StringOptionView({
    required this.option, 
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.only(left: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          option,
          style: Theme.of(context).textTheme.titleMedium
        ),
      )
    );
  }
}

class DropdownColumn extends StatelessWidget {
  final List<Widget> children;
  final double maxHeight;
  final Color? backgroundColor;
  final double elevation;
  final bool scrollThumbAlwaysVisible;

  const DropdownColumn({
    required this.children,
    this.maxHeight = double.infinity,
    this.backgroundColor,
    this.elevation = 3,
    this.scrollThumbAlwaysVisible = true
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeight,
      ),
      child: Ink(
        decoration: BoxDecoration(
          color: backgroundColor ?? Theme.of(context).colorScheme.surfaceContainerHighest,
          boxShadow: kElevationToShadow[elevation],
        ),
        child: Scrollbar(
          thumbVisibility: scrollThumbAlwaysVisible,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children
            ),
          ),
        ),
      ),
    );
  }

}

class DropdownSelectorBuilder<T> extends StatelessWidget {
  final ValueNotifier<T> selectedController;
  final Widget Function(T selectedValue, bool opened) headBuilder;
  final Widget Function(List<Widget> children) bodyContainerBuilder;
  final Widget Function(T item) optionBuilder;
  final double? height;
  final List<T> options;

  const DropdownSelectorBuilder({
    required this.selectedController,
    required this.headBuilder,
    required this.options,
    required this.optionBuilder,
    required this.bodyContainerBuilder,
    this.height = 180
  });

  @override
  Widget build(BuildContext context) {
    return DropdownBuilder(
      headBuilder: (ctx, expand, opened) {
        return ValueListenableBuilder(
          valueListenable: selectedController, 
          builder: (ctx, selectedValue, child) => InkWell(
            onTap: expand,
            child: headBuilder(selectedValue, opened),
          )
        );
      },
      bodyBuilder: (context, close) {
        var children = options.map((option) {
          return InkWell(
            onTap: () {
              selectedController.value = option;
              close();
            },
            child: optionBuilder(option),
          );
        }).toList();

        return bodyContainerBuilder(children);
      },
    );
  }
}

class FocusListeningUnderline extends StatelessWidget {
  final Widget child;
  final FocusNode focusNode;

  const FocusListeningUnderline({required this.child, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: focusNode,
      builder: (context, builderChild) {
        return Container(
          decoration: BoxDecoration(
            border: focusNode.hasFocus ? focusedBorder(context) : unfocusedBorder(context)
          ),
          child: builderChild,
        );
      },
      child: child,
    );
  }

  Border unfocusedBorder(BuildContext context) {
    return Border(
      bottom: BorderSide(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        width: 1,
      ),
    );
  }

  Border focusedBorder(BuildContext context) {
    return Border(
      bottom: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 2,
      ),
    );
  }
}

class DropdownHeadSkeleton extends StatelessWidget {
  final Widget title;
  final Widget? icon;
  final Decoration? decoration;
  final EdgeInsets padding;
  final double betweenSpace;

  const DropdownHeadSkeleton({
    required this.title, 
    this.icon,
    this.decoration,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
    this.betweenSpace = 8
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: decoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(right: betweenSpace),
            child: title,
          ),
          if (icon != null) icon!,
        ],
      ),
    );
  }
}

class DropdownBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, Function() toggleDropped, bool opened) headBuilder;
  final Widget Function(BuildContext context, Function() close) bodyBuilder;
  final EdgeInsets bodyMargin;
  final double extendDroppedWidth;

  const DropdownBuilder({
    super.key,
    required this.headBuilder,
    required this.bodyBuilder,
    this.extendDroppedWidth = 0,
    this.bodyMargin = const EdgeInsets.only(top: 2),
  });


  @override
  State<DropdownBuilder> createState() => _DropdownBuilderState();
}

class _DropdownBuilderState extends State<DropdownBuilder> {
  final _link = LayerLink();
  final OverlayPortalController _controller = OverlayPortalController();
  final ValueNotifier<bool> _opened = ValueNotifier(false);

  /// width of the button after the widget rendered
  double? _buttonWidth;

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
            return widget.headBuilder(context, onButtonTap, _opened.value);
          }
        ),
      ),
    );
  }
  
  

  void onButtonTap() {
    _opened.value = !_opened.value;
  }

  void onItemTap() {
    _opened.value = false;
  }

  buildMenu() {
    return Padding(
      padding: widget.bodyMargin,
      child: SizedBox(
        width: _buttonWidth! + widget.extendDroppedWidth,
        child: widget.bodyBuilder(context, onItemTap),
      ),
    );
  }
}