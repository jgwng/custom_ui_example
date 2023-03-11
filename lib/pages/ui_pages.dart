import 'package:custom_ui_example/drag_scroll_bar/drag_scroll_bar_example.dart';
import 'package:flutter/material.dart';

enum Pages{
  scrollBar
}

extension PagesExtension on Pages{
  String get title{
    switch(this){
      case Pages.scrollBar:
        return '드래그 가능한 스크롤 바';
    }
  }

  Widget get examplePage{
    switch(this){
      case Pages.scrollBar:
        return DragScrollBarExamplePage();
    }
  }
}