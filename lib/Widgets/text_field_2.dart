import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String? title;
  late final TextEditingController? controller;
  final Function validation;
  final IconData? icon;
  final int multiLine;

  CustomInputField({
    this.title = '',
    this.controller,
    required this.validation,
    this.icon,
    this.multiLine = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: controller!,
      decoration: InputDecoration().copyWith(
        hintText: title!,
      ),
      maxLines: multiLine,
      onChanged: (String text) {
        // if (validation != null) validation(text);
      },
      style: Theme.of(context).textTheme.subtitle1!.copyWith(
            color: Style.primary,
            letterSpacing: 0.4,
            fontWeight: FontWeight.w700,
          ),
    );
  }
}
