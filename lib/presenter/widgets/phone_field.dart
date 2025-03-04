import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:texnomart/utils/colors.dart';

class PhoneFieldWidget extends StatefulWidget {
  const PhoneFieldWidget(
      {super.key, required this.controller, this.hintText = "Phone", this.errorText, this.onChanged});

  final TextEditingController controller;
  final String hintText;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  @override
  State<PhoneFieldWidget> createState() => _PhoneFieldWidgetState();
}

class _PhoneFieldWidgetState extends State<PhoneFieldWidget> {
  @override
  Widget build(BuildContext context) => SizedBox(
        child: TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              errorText: widget.errorText,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: AppColors.fontPrimaryColor),
              suffixIcon: widget.controller.text.isNotEmpty
                  ? IconButton(
                      onPressed: toggleNameVisibility, icon: Image.asset('assets/images/ic_clear.png'))
                  : null,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(textAlign: TextAlign.center, '+998', style: TextStyle(fontSize: 16),),
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(9),
              PhoneInputFormatter(
                allowEndlessPhone: false,
                defaultCountryCode: 'UZ', // O‘zbekistonda telefon formatlash uchun
              ),
            ],
            keyboardType: TextInputType.phone,
            autofillHints: [AutofillHints.telephoneNumber],
            onEditingComplete: () => TextInput.finishAutofillContext(),
            onChanged: widget.onChanged
            // ffixIcon` yangilanishi uchun `setState`
            ,
            validator: (phone) {
              if (phone == null || phone.isEmpty) {
                return 'Phone number is required';
              } else if (phone.length < 9) {
                return 'Enter a valid phone number';
              }
              return null;
            }),
      );

  void toggleNameVisibility() => setState(() {
        widget.controller.clear();
      });
}
