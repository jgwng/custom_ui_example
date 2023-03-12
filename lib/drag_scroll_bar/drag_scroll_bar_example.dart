import 'package:custom_ui_example/drag_scroll_bar/horizontal_drag_scroll_bar_widget.dart';
import 'package:custom_ui_example/drag_scroll_bar/vertical_drag_scroll_bar_widget.dart';
import 'package:flutter/material.dart';

class DragScrollBarExamplePage extends StatefulWidget {
  const DragScrollBarExamplePage({super.key});

  @override
  State<DragScrollBarExamplePage> createState() => _DragScrollBarExamplePageState();
}

class _DragScrollBarExamplePageState extends State<DragScrollBarExamplePage> {

  ScrollController horizontalScrollController = ScrollController();
  ScrollController verticalScrollController = ScrollController();
  bool isHorizontal = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: isHorizontal ? horizontalExample() : verticalExample(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isHorizontal = !isHorizontal;
          });
        },
        child: const Icon(Icons.refresh,size: 30),
      ),
    );
  }

  Widget horizontalExample(){
    return HorizontalDraggableScrollBar(
      controller: horizontalScrollController,
      child: Flexible(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 120),
          child:  ListView.separated(
            physics: const ClampingScrollPhysics(),
            separatorBuilder: (ctx,i) => const SizedBox(width: 20),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx,i) => Container(
              height: 40,
              width: 40,
              color: Colors.red,
              alignment: Alignment.center,
              child: Text('$i',style: const TextStyle(color: Colors.black,fontSize: 20),),
            ),
            itemCount: 20,
            controller: horizontalScrollController,
          ),
        ),
      ),
    );
  }

  Widget verticalExample(){
    return VerticalDraggableScrollbar(
      controller: verticalScrollController,
      child: Flexible(
        child: ListView.separated(
          physics: const ClampingScrollPhysics(),
          separatorBuilder: (ctx,i) => const SizedBox(height: 20),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.vertical,
          itemBuilder: (ctx,i) => Container(
            height: 40,
            width: 40,
            color: Colors.red,
            alignment: Alignment.center,
            child: Text('$i',style: const TextStyle(color: Colors.black,fontSize: 20),),
          ),
          itemCount: 40,
          controller: verticalScrollController,
        ),
      ),
    );
  }
}
