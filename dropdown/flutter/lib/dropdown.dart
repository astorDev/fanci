import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A dropdown menu that can be opened from a [TextField]. The selected
/// menu item is displayed in that field.
///
/// This widget is used to help people make a choice from a menu and put the
/// selected item into the text input field. People can also filter the list based
/// on the text input or search one item in the menu list.
///
/// The menu is composed of a list of [DropdownMenuEntry]s. People can provide information,
/// such as: label, leading icon or trailing icon for each entry. The [TextField]
/// will be updated based on the selection from the menu entries. The text field
/// will stay empty if the selected entry is disabled.
///
/// The dropdown menu can be traversed by pressing the up or down key. During the
/// process, the corresponding item will be highlighted and the text field will be updated.
/// Disabled items will be skipped during traversal.
///
/// The menu can be scrollable if not all items in the list are displayed at once.
///
/// {@tool dartpad}
/// This sample shows how to display outlined [DropdownMenu] and filled [DropdownMenu].
///
/// ** See code in examples/api/lib/material/dropdown_menu/dropdown_menu.0.dart **
/// {@end-tool}
///
/// See also:
///
/// * [MenuAnchor], which is a widget used to mark the "anchor" for a set of submenus.
///   The [DropdownMenu] uses a [TextField] as the "anchor".
/// * [TextField], which is a text input widget that uses an [InputDecoration].
/// * [DropdownMenuEntry], which is used to build the [MenuItemButton] in the [DropdownMenu] list.
class Dropdown<T> extends StatelessWidget {
  /// Creates a const [DropdownMenu].
  ///
  /// The leading and trailing icons in the text field can be customized by using
  /// [leadingIcon], [trailingIcon] and [selectedTrailingIcon] properties. They are
  /// passed down to the [InputDecoration] properties, and will override values
  /// in the [InputDecoration.prefixIcon] and [InputDecoration.suffixIcon].
  ///
  /// Except leading and trailing icons, the text field can be configured by the
  /// [InputDecorationTheme] property. The menu can be configured by the [menuStyle].
  const Dropdown({
    super.key,
    this.enabled = true,
    this.width,
    this.menuHeight,
    this.leadingIcon,
    this.trailingIcon,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.selectedTrailingIcon,
    this.enableFilter = false,
    this.enableSearch = true,
    this.textStyle,
    this.textAlign = TextAlign.start,
    this.inputDecorationTheme,
    this.menuStyle,
    this.controller,
    this.initialSelection,
    this.onSelected,
    this.focusNode,
    this.requestFocusOnTap,
    this.expandedInsets,
    this.filterCallback,
    this.searchCallback,
    required this.dropdownMenuEntries,
    this.inputFormatters,
  }) : assert(filterCallback == null || enableFilter);

  /// Determine if the [DropdownMenu] is enabled.
  ///
  /// Defaults to true.
  ///
  /// {@tool dartpad}
  /// This sample demonstrates how the [enabled] and [requestFocusOnTap] properties
  /// affect the textfield's hover cursor.
  ///
  /// ** See code in examples/api/lib/material/dropdown_menu/dropdown_menu.2.dart **
  /// {@end-tool}
  final bool enabled;

  /// Determine the width of the [DropdownMenu].
  ///
  /// If this is null, the width of the [DropdownMenu] will be the same as the width of the widest
  /// menu item plus the width of the leading/trailing icon.
  final double? width;

  /// Determine the height of the menu.
  ///
  /// If this is null, the menu will display as many items as possible on the screen.
  final double? menuHeight;

  /// An optional Icon at the front of the text input field.
  ///
  /// Defaults to null. If this is not null, the menu items will have extra paddings to be aligned
  /// with the text in the text field.
  final Widget? leadingIcon;

  /// An optional icon at the end of the text field.
  ///
  /// Defaults to an [Icon] with [Icons.arrow_drop_down].
  final Widget? trailingIcon;

  /// Optional widget that describes the input field.
  ///
  /// When the input field is empty and unfocused, the label is displayed on
  /// top of the input field (i.e., at the same location on the screen where
  /// text may be entered in the input field). When the input field receives
  /// focus (or if the field is non-empty), the label moves above, either
  /// vertically adjacent to, or to the center of the input field.
  ///
  /// Defaults to null.
  final Widget? label;

  /// Text that suggests what sort of input the field accepts.
  ///
  /// Defaults to null;
  final String? hintText;

  /// Text that provides context about the [DropdownMenu]'s value, such
  /// as how the value will be used.
  ///
  /// If non-null, the text is displayed below the input field, in
  /// the same location as [errorText]. If a non-null [errorText] value is
  /// specified then the helper text is not shown.
  ///
  /// Defaults to null;
  ///
  /// See also:
  ///
  /// * [InputDecoration.helperText], which is the text that provides context about the [InputDecorator.child]'s value.
  final String? helperText;

  /// Text that appears below the input field and the border to show the error message.
  ///
  /// If non-null, the border's color animates to red and the [helperText] is not shown.
  ///
  /// Defaults to null;
  ///
  /// See also:
  ///
  /// * [InputDecoration.errorText], which is the text that appears below the [InputDecorator.child] and the border.
  final String? errorText;

  /// An optional icon at the end of the text field to indicate that the text
  /// field is pressed.
  ///
  /// Defaults to an [Icon] with [Icons.arrow_drop_up].
  final Widget? selectedTrailingIcon;

  /// Determine if the menu list can be filtered by the text input.
  ///
  /// Defaults to false.
  final bool enableFilter;

  /// Determine if the first item that matches the text input can be highlighted.
  ///
  /// Defaults to true as the search function could be commonly used.
  final bool enableSearch;

  /// The text style for the [TextField] of the [DropdownMenu];
  ///
  /// Defaults to the overall theme's [TextTheme.bodyLarge]
  /// if the dropdown menu theme's value is null.
  final TextStyle? textStyle;

  /// The text align for the [TextField] of the [DropdownMenu].
  ///
  /// Defaults to [TextAlign.start].
  final TextAlign textAlign;

  /// Defines the default appearance of [InputDecoration] to show around the text field.
  ///
  /// By default, shows a outlined text field.
  final InputDecorationTheme? inputDecorationTheme;

  /// The [MenuStyle] that defines the visual attributes of the menu.
  ///
  /// The default width of the menu is set to the width of the text field.
  final MenuStyle? menuStyle;

  /// Controls the text being edited or selected in the menu.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final DropdownTextController? controller;

  /// The value used to for an initial selection.
  ///
  /// Defaults to null.
  final T? initialSelection;

  /// The callback is called when a selection is made.
  ///
  /// Defaults to null. If null, only the text field is updated.
  final ValueChanged<T?>? onSelected;

  /// Defines the keyboard focus for this widget.
  ///
  /// The [focusNode] is a long-lived object that's typically managed by a
  /// [StatefulWidget] parent. See [FocusNode] for more information.
  ///
  /// To give the keyboard focus to this widget, provide a [focusNode] and then
  /// use the current [FocusScope] to request the focus:
  ///
  /// ```dart
  /// FocusScope.of(context).requestFocus(myFocusNode);
  /// ```
  ///
  /// This happens automatically when the widget is tapped.
  ///
  /// To be notified when the widget gains or loses the focus, add a listener
  /// to the [focusNode]:
  ///
  /// ```dart
  /// myFocusNode.addListener(() { print(myFocusNode.hasFocus); });
  /// ```
  ///
  /// If null, this widget will create its own [FocusNode].
  ///
  /// ## Keyboard
  ///
  /// Requesting the focus will typically cause the keyboard to be shown
  /// if it's not showing already.
  ///
  /// On Android, the user can hide the keyboard - without changing the focus -
  /// with the system back button. They can restore the keyboard's visibility
  /// by tapping on a text field. The user might hide the keyboard and
  /// switch to a physical keyboard, or they might just need to get it
  /// out of the way for a moment, to expose something it's
  /// obscuring. In this case requesting the focus again will not
  /// cause the focus to change, and will not make the keyboard visible.
  ///
  /// If this is non-null, the behaviour of [requestFocusOnTap] is overridden
  /// by the [FocusNode.canRequestFocus] property.
  final FocusNode? focusNode;

  /// Determine if the dropdown button requests focus and the on-screen virtual
  /// keyboard is shown in response to a touch event.
  ///
  /// Ignored if a [focusNode] is explicitly provided (in which case,
  /// [FocusNode.canRequestFocus] controls the behavior).
  ///
  /// Defaults to null, which enables platform-specific behavior:
  ///
  ///  * On mobile platforms, acts as if set to false; tapping on the text
  ///    field and opening the menu will not cause a focus request and the
  ///    virtual keyboard will not appear.
  ///
  ///  * On desktop platforms, acts as if set to true; the dropdown takes the
  ///    focus when activated.
  ///
  /// Set this to true or false explicitly to override the default behavior.
  ///
  /// {@tool dartpad}
  /// This sample demonstrates how the [enabled] and [requestFocusOnTap] properties
  /// affect the textfield's hover cursor.
  ///
  /// ** See code in examples/api/lib/material/dropdown_menu/dropdown_menu.2.dart **
  /// {@end-tool}
  final bool? requestFocusOnTap;

  /// Descriptions of the menu items in the [DropdownMenu].
  ///
  /// This is a required parameter. It is recommended that at least one [DropdownMenuEntry]
  /// is provided. If this is an empty list, the menu will be empty and only
  /// contain space for padding.
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;

  /// Defines the menu text field's width to be equal to its parent's width
  /// plus the horizontal width of the specified insets.
  ///
  /// If this property is null, the width of the text field will be determined
  /// by the width of menu items or [DropdownMenu.width]. If this property is not null,
  /// the text field's width will match the parent's width plus the specified insets.
  /// If the value of this property is [EdgeInsets.zero], the width of the text field will be the same
  /// as its parent's width.
  ///
  /// The [expandedInsets]' top and bottom are ignored, only its left and right
  /// properties are used.
  ///
  /// Defaults to null.
  final EdgeInsets? expandedInsets;

  /// When [DropdownMenu.enableFilter] is true, this callback is used to
  /// compute the list of filtered items.
  ///
  /// {@tool snippet}
  ///
  /// In this example the `filterCallback` returns the items that contains the
  /// trimmed query.
  ///
  /// ```dart
  /// DropdownMenu<Text>(
  ///   enableFilter: true,
  ///   filterCallback: (List<DropdownMenuEntry<Text>> entries, String filter) {
  ///     final String trimmedFilter = filter.trim().toLowerCase();
  ///       if (trimmedFilter.isEmpty) {
  ///         return entries;
  ///       }
  ///
  ///       return entries
  ///         .where((DropdownMenuEntry<Text> entry) =>
  ///           entry.label.toLowerCase().contains(trimmedFilter),
  ///         )
  ///         .toList();
  ///   },
  ///   dropdownMenuEntries: const <DropdownMenuEntry<Text>>[],
  /// )
  /// ```
  /// {@end-tool}
  ///
  /// Defaults to null. If this parameter is null and the
  /// [DropdownMenu.enableFilter] property is set to true, the default behavior
  /// will return a filtered list. The filtered list will contain items
  /// that match the text provided by the input field, with a case-insensitive
  /// comparison. When this is not null, `enableFilter` must be set to true.
  final FilterCallback<T>? filterCallback;

  /// When [DropdownMenu.enableSearch] is true, this callback is used to compute
  /// the index of the search result to be highlighted.
  ///
  /// {@tool snippet}
  ///
  /// In this example the `searchCallback` returns the index of the search result
  /// that exactly matches the query.
  ///
  /// ```dart
  /// DropdownMenu<Text>(
  ///   searchCallback: (List<DropdownMenuEntry<Text>> entries, String query) {
  ///     if (query.isEmpty) {
  ///       return null;
  ///     }
  ///     final int index = entries.indexWhere((DropdownMenuEntry<Text> entry) => entry.label == query);
  ///
  ///     return index != -1 ? index : null;
  ///   },
  ///   dropdownMenuEntries: const <DropdownMenuEntry<Text>>[],
  /// )
  /// ```
  /// {@end-tool}
  ///
  /// Defaults to null. If this is null and [DropdownMenu.enableSearch] is true,
  /// the default function will return the index of the first matching result
  /// which contains the contents of the text input field.
  final SearchCallback<T>? searchCallback;

  /// Optional input validation and formatting overrides.
  ///
  /// Formatters are run in the provided order when the user changes the text
  /// this widget contains. When this parameter changes, the new formatters will
  /// not be applied until the next time the user inserts or deletes text.
  /// Formatters don't run when the text is changed
  /// programmatically via [controller].
  ///
  /// See also:
  ///
  ///  * [TextEditingController], which implements the [Listenable] interface
  ///    and notifies its listeners on [TextEditingValue] changes.
  final List<TextInputFormatter>? inputFormatters;
  
  @override
  Widget build(BuildContext context) {
    var iconsTheme = Theme.of(context).extension<DropdownIconsTheme>();

    return DropdownMenu<T>(
      leadingIcon : this.leadingIcon ?? iconsTheme?.leadingIcon,
      trailingIcon : this.trailingIcon ?? iconsTheme?.trailingIcon,
      selectedTrailingIcon : this.selectedTrailingIcon ?? iconsTheme?.selectedTrailingIcon,
      enabled : this.enabled,
      width : this.width,
      menuHeight : this.menuHeight,
      label : this.label,
      hintText : this.hintText,
      helperText : this.helperText,
      errorText : this.errorText,
      enableFilter : this.enableFilter,
      enableSearch : this.enableSearch,
      textStyle : this.textStyle,
      textAlign : this.textAlign,
      inputDecorationTheme : this.inputDecorationTheme,
      menuStyle : this.menuStyle,
      controller : this.controller?.innerController,
      initialSelection : this.initialSelection,
      onSelected : this.onSelected,
      focusNode : this.focusNode,
      requestFocusOnTap : this.requestFocusOnTap,
      expandedInsets : this.expandedInsets,
      filterCallback : this.filterCallback,
      searchCallback : this.searchCallback,
      dropdownMenuEntries : this.dropdownMenuEntries,
      inputFormatters : this.inputFormatters,
    );
  }
}

class DropdownIconsTheme extends ThemeExtension<DropdownIconsTheme> {
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final Widget? selectedTrailingIcon;

  const DropdownIconsTheme({
    this.leadingIcon,
    this.trailingIcon,
    this.selectedTrailingIcon,
  });

  @override
  DropdownIconsTheme copyWith({
    Widget? leadingIcon,
    Widget? trailingIcon,
    Widget? selectedTrailingIcon,
  }) {
    return DropdownIconsTheme(
      leadingIcon: leadingIcon ?? this.leadingIcon,
      trailingIcon: trailingIcon ?? this.trailingIcon,
      selectedTrailingIcon: selectedTrailingIcon ?? this.selectedTrailingIcon,
    );
  }

  @override
  ThemeExtension<DropdownIconsTheme> lerp(covariant ThemeExtension<DropdownIconsTheme>? other, double t) {
    return this;
  }
}

class DropdownTextController extends ChangeNotifier implements ValueListenable<String> {
  TextEditingController innerController;
  String text;

  DropdownTextController({this.text = ''}) : innerController = TextEditingController(text: text) {
    innerController.addListener(() {
      if (innerController.text != text) {
        text = innerController.text;
        notifyListeners();
      }
    });
  }
  
  @override
  String get value => text;
}