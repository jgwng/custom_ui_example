import 'package:flutter/material.dart';

class OpticalCardWidget extends StatefulWidget {
  const OpticalCardWidget({Key? key}) : super(key: key);

  @override
  State<OpticalCardWidget> createState() => _OpticalCardWidgetState();
}

class _OpticalCardWidgetState extends State<OpticalCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 250,
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: const RadialGradient(
              colors: [
                Colors.white,
                Colors.purple,
              ],
              center: Alignment(0, 0),
              stops: [0, 1],
            ),
          ),
        ),
      ),
    );
  }
}
