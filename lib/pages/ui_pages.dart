import 'package:custom_ui_example/drag_scroll_bar/drag_scroll_bar_example.dart';
import 'package:custom_ui_example/flip_animation/flip_animation_example.dart';
import 'package:flutter/material.dart';

enum Pages{
  scrollBar,
  flipWidget
}

extension PagesExtension on Pages{
  String get title{
    switch(this){
      case Pages.scrollBar:
        return '드래그 가능한 스크롤 바';
      case Pages.flipWidget:
        return '접히는 애니메이션 위젯';
    }
  }

  Widget get examplePage{
    switch(this){
      case Pages.scrollBar:
        return const DragScrollBarExamplePage();
      case Pages.flipWidget:
        return  FlipAnimationExample();
    }
  }
}