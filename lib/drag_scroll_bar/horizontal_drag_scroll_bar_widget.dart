import 'package:flutter/material.dart';

class HorizontalDraggableScrollBar extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Color? bgColor;
  final Color? barColor;
  final double? bgBarWidth;
  final double? scrollBarWidth;
  final double? barRadius;

  const HorizontalDraggableScrollBar(
      {super.key, required this.child,
      required this.controller,
      this.barRadius,
      this.bgBarWidth,
      this.scrollBarWidth,
      this.bgColor,
      this.barColor});

  @override
  _HorizontalDraggableScrollBarState createState() => _HorizontalDraggableScrollBarState();
}

class _HorizontalDraggableScrollBarState extends State<HorizontalDraggableScrollBar> {
  late double _barOffset;
  late double _viewOffset;
  late bool _isDragInProcess;
  late bool isDragAtBottom;

  @override
  void initState() {
    super.initState();
    _barOffset = 0.0;
    _viewOffset = 0.0;
    _isDragInProcess = false;
  }

  double get barMaxScrollExtent =>
      (widget.bgBarWidth ?? 220) - (widget.scrollBarWidth ?? 200) + 2;

  double get barMinScrollExtent => 0.0;

//this is usually length (in pixels) of list
//if list has 1000 items of 100.0 pixels each, maxScrollExtent is 100,000.0 pixels
  double get viewMaxScrollExtent => widget.controller.position.maxScrollExtent;

//this is usually 0.0
  double get viewMinScrollExtent => widget.controller.position.minScrollExtent;

  double getScrollViewDelta(
    double barDelta,
    double barMaxScrollExtent,
    double viewMaxScrollExtent,
  ) {
    //propotion
    return barDelta * viewMaxScrollExtent / barMaxScrollExtent;
  }

  double getBarDelta(
    double scrollViewDelta,
    double barMaxScrollExtent,
    double viewMaxScrollExtent,
  ) {
    //propotion
    return scrollViewDelta * barMaxScrollExtent / viewMaxScrollExtent;
  }

  changePosition(ScrollNotification notification) {
    if (_isDragInProcess) {
      return;
    }
    setState(() {
      if (notification is ScrollUpdateNotification) {
        if (!notification.metrics.outOfRange) {
          _barOffset += getBarDelta(
            notification.scrollDelta!,
            barMaxScrollExtent,
            viewMaxScrollExtent,
          );
          if (_barOffset < barMinScrollExtent) {
            _barOffset = barMinScrollExtent;
          }
          if (_barOffset > viewMaxScrollExtent) {
            _barOffset = viewMaxScrollExtent;
          }
          _viewOffset += notification.scrollDelta!;

          if (_viewOffset > viewMaxScrollExtent) {
            _viewOffset = viewMaxScrollExtent;
          }
          if (_viewOffset < widget.controller.position.minScrollExtent) {
            _viewOffset = widget.controller.position.minScrollExtent;
          }
          if (_viewOffset > viewMaxScrollExtent) {
            _viewOffset = viewMaxScrollExtent;
          }
        }
      }
    });
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    setState(() {
      _isDragInProcess = true;
    });
  }

  void  _onHorizontalDragEnd(DragEndDetails details) {
    setState(() {
      _isDragInProcess = false;
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _barOffset += details.delta.dx;
      if (_barOffset < barMinScrollExtent) {
        _barOffset = barMinScrollExtent;
      }
      if (_barOffset > barMaxScrollExtent) {
        _barOffset = barMaxScrollExtent;
      }

      double viewDelta = getScrollViewDelta(
          details.delta.dx, barMaxScrollExtent, viewMaxScrollExtent);

      _viewOffset = widget.controller.position.pixels + viewDelta;
      if (_viewOffset < widget.controller.position.minScrollExtent) {
        _viewOffset = widget.controller.position.minScrollExtent;
      }
      if (_viewOffset > viewMaxScrollExtent) {
        _viewOffset = viewMaxScrollExtent;
      }
      widget.controller.jumpTo(_viewOffset);
    });
  }
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          changePosition(notification);
          return true;
        },
        child: GestureDetector(
          onHorizontalDragStart: _onHorizontalDragStart,
          onHorizontalDragEnd: _onHorizontalDragEnd,
          onHorizontalDragUpdate: _onHorizontalDragUpdate,
          child:  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            widget.child,
            const SizedBox(
              height: 30,
            ),
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  height: 20,
                  width: widget.bgBarWidth ?? 220,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: widget.bgColor ?? Colors.red),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: _barOffset),
                      child: _buildScrollThumb()),
                ),
              ],
            ),
          ]),
        ));
  }

  Widget _buildScrollThumb() {
    return Container(
      height: 20,
      width: widget.scrollBarWidth ?? 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: widget.barColor ?? const Color.fromRGBO(4, 191, 138, 1.0),
      ),
    );
  }
}
