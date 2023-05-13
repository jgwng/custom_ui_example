import 'package:custom_ui_example/custom_dropdown/custom_dropdown_example.dart';
import 'package:custom_ui_example/drag_scroll_bar/drag_scroll_bar_example.dart';
import 'package:custom_ui_example/flip_animation/flip_animation_example.dart';
import 'package:custom_ui_example/optical_card/optical_card_example.dart';
import 'package:flutter/material.dart';

enum Pages{
  scrollBar,
  flipWidget,
  customDropdown,
  opticalCard
}

extension PagesExtension on Pages{
  String get title{
    switch(this){
      case Pages.scrollBar:
        return '드래그 가능한 스크롤 바';
      case Pages.flipWidget:
        return '접히는 애니메이션 위젯';
      case Pages.opticalCard:
        return '카드에 광원효과 주기';
      case Pages.customDropdown:
        return '커스텀 드롭다운 위젯';
    }
  }

  Widget get examplePage{
    switch(this){
      case Pages.scrollBar:
        return const DragScrollBarExamplePage();
      case Pages.flipWidget:
        return  FlipAnimationExample();
      case Pages.opticalCard:
        return const OpticalCardWidget();
      case Pages.customDropdown:
        return const CustomDropdownExample();
    }
  }
}