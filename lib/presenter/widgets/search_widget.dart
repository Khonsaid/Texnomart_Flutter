import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class SearchWidget extends StatelessWidget {
  final Color hintStyle;
  final Color fillColor;

  const SearchWidget({super.key, this.hintStyle = AppColors.lightGrayColor, this.fillColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      decoration: InputDecoration(
          alignLabelWithHint: true,
          hintText: 'Qidirish',
          hintStyle: TextStyle(color: hintStyle),
          filled: true,
          fillColor: fillColor,
          prefixIcon: Icon(Icons.search, color: hintStyle),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
          )),
    );
  }
}
