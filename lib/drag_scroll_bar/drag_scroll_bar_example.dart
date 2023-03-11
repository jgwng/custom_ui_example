import 'package:custom_ui_example/drag_scroll_bar/drag_scroll_bar_widget.dart';
import 'package:flutter/material.dart';

class DragScrollBarExamplePage extends StatefulWidget {

  @override
  State<DragScrollBarExamplePage> createState() => _DragScrollBarExamplePageState();
}

class _DragScrollBarExamplePageState extends State<DragScrollBarExamplePage> {

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DraggableScrollbar(
          controller: scrollController,
          child: SizedBox(
            height: 100,
            child: ListView.separated(
              physics: const ClampingScrollPhysics(),
              separatorBuilder: (ctx,i) => const SizedBox(width: 20),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx,i) => Container(
                height: 40,
                width: 40,
                color: Colors.red,
              ),
              itemCount: 10,
              controller: scrollController,
            ),
          ),
        ),
      ),
    );
  }
}
