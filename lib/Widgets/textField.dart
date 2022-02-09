import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';

class ThisInputField extends StatelessWidget {
  final String? title;
  late final TextEditingController? controller;
  final Function validation;
  final IconData? icon;
  final int multiLine;

  ThisInputField({
    this.title = '',
    this.controller,
    required this.validation,
    this.icon,
    this.multiLine = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: TextFormField(
        controller: controller!,
        decoration: InputDecoration().copyWith(
            hintText: title!,
            prefixIcon: (icon != null)
                ? Icon(
                    icon,
                    color: Style.primary.withOpacity(0.48),
                  )
                : SizedBox()),
        maxLines: multiLine,
        onChanged: (String text) => validation(text),
        cursorColor: Style.primary,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
              color: Style.primary,
              letterSpacing: 0.8,
              fontWeight: FontWeight.w700,
            ),
      ),
    );
  }
}
