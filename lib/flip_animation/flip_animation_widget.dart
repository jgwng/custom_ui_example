import 'package:flutter/material.dart';
import 'dart:math';
class FlipWidget extends StatefulWidget {
  int text;
  bool initAnimation;

  FlipWidget(
      {Key? key,
        required this.text,
        this.initAnimation = false
      })
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FlipWidgetState();
  }
}

class _FlipWidgetState extends State<FlipWidget> with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _animation;
  final ValueNotifier<double> animationRatio = ValueNotifier<double>(0.0); //

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(duration: const Duration(milliseconds: 1000), vsync: this)
      ..addListener(progressListener);
    _animation = Tween(begin: 0, end: pi).animate(_controller!);
    if(widget.initAnimation){
      _controller!.forward();
    }
  }

  @override
  void didUpdateWidget(covariant FlipWidget oldWidget) {
    if(oldWidget.text != widget.text ){
      animationRatio.value = 0;
      _controller!.reset();
      _controller!.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  void progressListener() {
    final value = (_animation!.value) ?? 0;
    if (value > 0) {
      animationRatio.value = value;
    }
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder(
            valueListenable: animationRatio,
            builder: (BuildContext context, double value, Widget? child) {
              return Stack(
                children: [
                  Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.006)
                      ..rotateX(0),
                    alignment: Alignment.bottomCenter,
                    child: ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: 0.5,
                        child: panel(),
                      ),
                    ),
                  ),
                  Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.006)
                      ..rotateX(double.parse(_animation!.value.toString())),
                    alignment: Alignment.bottomCenter,
                    child: ClipRect(
                      child: Align(
                        alignment: Alignment.topCenter,
                        heightFactor: 0.5,
                        child: panel(),
                      ),
                    ),
                  )
                ],
              );
            }),
        const SizedBox(
          height: 1.0,
        ),
        ClipRect(
          child: Align(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.5,
            child: panel(),
          ),
        ),
      ],
    );
  }

  Widget panel() {
    return Container(
      width: 150,
      height: 150,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.black,
      ),
      child: Text(widget.text.toString().padLeft(2, '0'),
          style: const TextStyle(
              color: Colors.white, fontSize: 80, fontWeight: FontWeight.bold)),
    );
  }
}