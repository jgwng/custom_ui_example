import 'package:custom_ui_example/pages/ui_pages.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CustomUICollectionPage(title: 'Custom UI Collection'),
    );
  }
}

class CustomUICollectionPage extends StatefulWidget {
  const CustomUICollectionPage({super.key, required this.title});
  final String title;

  @override
  State<CustomUICollectionPage> createState() => _CustomUICollectionPageState();
}

class _CustomUICollectionPageState extends State<CustomUICollectionPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemBuilder: (ctx,index) => pageItem( index),
        itemCount: Pages.values.length,
        shrinkWrap: true,
      ),
    );
  }


  Widget pageItem(int index){
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
        return Pages.values[index].examplePage;
      })),
      child: Container(
        height: 40,
        alignment: Alignment.center,
        child: Text(Pages.values[index].title,style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 20
        ),),
      ),
    );
  }
}
