import 'package:flutter/material.dart';

import '../../../../utils/colors.dart';

class BtnAddBasket extends StatelessWidget {
  final bool isAdded;
  final VoidCallback onTap;

  const BtnAddBasket({super.key, required this.isAdded, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      splashColor: AppColors.primaryColor.withOpacity(0.4),
      overlayColor: WidgetStateProperty.all(AppColors.primaryColor.withOpacity(0.3)),
      child: Container(
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isAdded ? Colors.transparent : AppColors.primaryColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.primaryColor, width: 2),
          ),
          child: Text(isAdded ? "Savatchaga o'tish" : "Savatchaga qo'shish",
              style:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.fontPrimaryColor))),
    );
  }
}
