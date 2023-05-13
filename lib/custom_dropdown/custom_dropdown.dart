import 'package:custom_ui_example/custom_dropdown/custom_dropdown_style.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final void Function(T, int)? onChange;

  /// list of DropdownItems
  final List<T> items;
  final DropdownStyle? dropdownStyle;

  /// dropdownButtonStyles passes styles to OutlineButton.styleFrom()
  final DropdownButtonStyle dropdownButtonStyle;
  final String hintText;

  /// dropdown button icon defaults to caret
  final Icon? icon;
  final bool? hideIcon;

  /// if true the dropdown icon will as a leading icon, default to false
  final bool leadingIcon;

  CustomDropdown({
    Key? key,
    this.hintText = '',
    this.hideIcon = false,
    required this.items,
    this.dropdownStyle = const DropdownStyle(),
    this.dropdownButtonStyle = const DropdownButtonStyle(),
    this.icon,
    this.leadingIcon = false,
    this.onChange,
  }) : super(key: key);

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>>
    with TickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  int _currentIndex = -1;
  AnimationController? _animationController;
  Animation<double>? _expandAnimation;
  Animation<double>? _rotateAnimation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _expandAnimation = CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    );
    _rotateAnimation = Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    var style = widget.dropdownButtonStyle;
    // link the overlay to the button
    return CompositedTransformTarget(
      link: this._layerLink,
      child: SizedBox(
        width: style.width,
        height: style.height,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: style.padding,
            backgroundColor: style.backgroundColor,
            elevation: style.elevation,
            primary: style.primaryColor,
          ),
          onPressed: _toggleDropdown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.ltr,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_currentIndex == -1) ...[
                initHeader(),
              ] else ...[
                listItem(_currentIndex),
              ],
              if (!widget.hideIcon!)
                RotationTransition(
                  turns: _rotateAnimation!,
                  child: widget.icon ??
                      const Icon(
                        Icons.arrow_drop_down_outlined,
                        size: 20,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget initHeader() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(widget.hintText ?? ''),
    );
  }

  Widget listItem(int index) {
    return DropdownItem<T>(
      value: widget.items[index],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(widget.items[index].toString()),
      ),
    );
  }

  // 하단의 드롭다운 버튼 목록
  OverlayEntry _createOverlayEntry() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    var offset = renderBox.localToGlobal(Offset.zero);
    var topOffset = offset.dy + size.height + 5;

    var totalHeight = MediaQuery.of(context).size.height;
    var totalWidth = MediaQuery.of(context).size.width;

    // 드롭다운 이외의 범위 눌렀을 경우 드롭다운 제거 처리
    return OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () => _toggleDropdown(close: true),
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          height: totalWidth,
          width: totalWidth,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: topOffset,
                width: size.width,
                child: CompositedTransformFollower(
                  offset: Offset(0, size.height + 5),
                  link: _layerLink,
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: 0,
                    borderRadius:
                        widget.dropdownStyle?.borderRadius ?? BorderRadius.zero,
                    color: widget.dropdownStyle?.color,
                    child: SizeTransition(
                      axisAlignment: 1,
                      sizeFactor: _expandAnimation!,
                      child: ConstrainedBox(
                        constraints: widget.dropdownStyle?.constraints ??
                            BoxConstraints(
                              maxHeight: totalHeight - topOffset - 15,
                            ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: Colors.grey[400]!)),
                          child: ListView(
                              padding: widget.dropdownStyle?.padding ??
                                  EdgeInsets.zero,
                              shrinkWrap: true,
                              children: [
                                ...List.generate(
                                    widget.items.length,
                                    (index) => InkWell(
                                          onTap: () {
                                            setState(
                                                () => _currentIndex = index);
                                            widget.onChange!(
                                                widget.items[index], index);
                                            _toggleDropdown();
                                          },
                                          child: listItem(index),
                                        ))
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleDropdown({bool close = false}) async {
    if (_isOpen || close) {
      await _animationController!.reverse();
      _overlayEntry!.remove();
      setState(() {
        _isOpen = false;
      });
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      setState(() => _isOpen = true);
      _animationController!.forward();
    }
  }
}

/// DropdownItem is just a wrapper for each child in the dropdown list.\n
/// It holds the value of the item.
class DropdownItem<T> extends StatelessWidget {
  final T value;
  final Widget child;

  const DropdownItem({Key? key, required this.value, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
