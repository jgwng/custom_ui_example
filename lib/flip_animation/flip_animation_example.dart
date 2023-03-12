import 'dart:async';

import 'package:custom_ui_example/flip_animation/flip_animation_widget.dart';
import 'package:flutter/material.dart';

class FlipAnimationExample extends StatefulWidget {

  @override
  State<FlipAnimationExample> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FlipAnimationExample> {
  DateTime dateTime = DateTime.now();
  Timer? _timer;
  final ValueNotifier<int> hourCount = ValueNotifier<int>(0); //
  final ValueNotifier<int> minuteCount = ValueNotifier<int>(0); //
  final ValueNotifier<int> secondCount = ValueNotifier<int>(0); //
  @override
  void initState(){
    super.initState();
    initData();
    _startTimer();
  }
  void initData(){

    minuteCount.value = dateTime.minute;
    secondCount.value = dateTime.second;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      dateTime = dateTime.add(const Duration(seconds: 1));
      initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ValueListenableBuilder(
                valueListenable: minuteCount,
                builder: (BuildContext context, int value, Widget? child){
                  return FlipWidget(
                    text: minuteCount.value,
                    initAnimation: false,
                  );
                }
            ),
            const SizedBox(width: 4,),
            ValueListenableBuilder(
                valueListenable: secondCount,
                builder: (BuildContext context, int value, Widget? child){
                  return FlipWidget(
                    text: secondCount.value,
                    initAnimation: true,
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
