import 'package:custom_ui_example/custom_dropdown/custom_dropdown.dart';
import 'package:custom_ui_example/custom_dropdown/custom_dropdown_style.dart';
import 'package:flutter/material.dart';

class CustomDropdownExample extends StatefulWidget {
  const CustomDropdownExample({Key? key}) : super(key: key);

  @override
  State<CustomDropdownExample> createState() => _CustomDropdownExampleState();
}

class _CustomDropdownExampleState extends State<CustomDropdownExample> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomDropdown<int>(
          onChange: (int value, int index) => print(value),
          dropdownButtonStyle: const DropdownButtonStyle(
            width: 170,
            height: 40,
            elevation: 1,
            backgroundColor: Colors.white,
            primaryColor: Colors.black87,
          ),
          dropdownStyle: DropdownStyle(
            borderRadius: BorderRadius.circular(8),
            elevation: 6,
            padding: const EdgeInsets.all(5),
          ),
          items: const [1,2,3,4],
          hintText: '선택해주세요',
        ),
      ),
    );
  }
}
