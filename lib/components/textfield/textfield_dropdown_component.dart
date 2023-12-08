import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

class TextfieldDropdownComponent extends StatelessWidget {
  final String hintText;
  final Function(Object?)? onChanged;
  final List<Map<dynamic, dynamic>>? items;
  final SingleValueDropDownController? controller;
  final double? width, height, fontSize;

  const TextfieldDropdownComponent(
      {super.key,
      this.hintText = "",
      this.onChanged,
      this.items,
      this.controller,
      this.width,
      this.height,
      this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: DropDownTextField(
          onChanged: onChanged,
          controller: controller,
          textStyle: TextStyle(fontSize: fontSize),
          textFieldDecoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(fontSize: fontSize),
              fillColor: Colors.white),
          dropDownList: items!
              .map((e) => DropDownValueModel(
                  value: e["value"], name: e["name"].toString()))
              .toList()),
    );
  }
}
