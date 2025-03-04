import 'package:flutter/material.dart';
import 'package:texnomart/utils/colors.dart';

import '../widgets/phone_field.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void deactivate() {
    _controller.clear();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Xush kelibsiz',
          style: TextStyle(color: AppColors.fontPrimaryColor, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 64),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: PhoneFieldWidget(
                controller: _controller,
                hintText: 'Telefon raqami',
                errorText: "Kiritilgan raqam to'liq emas",
                onChanged: (text) {}),
          ),
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(14),
              splashColor: AppColors.primaryColor.withOpacity(0.4),
              overlayColor: WidgetStateProperty.all(AppColors.primaryColor.withOpacity(0.3)),
              child: Container(
                  height: 52,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withAlpha(80),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text("Kirish",
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.fontPrimaryColor))),
            ),
          )
        ],
      ),
    );
  }
}
