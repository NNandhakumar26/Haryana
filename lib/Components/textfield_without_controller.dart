import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';

class FullTextField extends StatelessWidget {
  final String? title;
  final Function? onChanged;
  final String initialValue;
  final IconData? icon;
  final int multiLine;
  final TextEditingController? controller;
  final TextInputType inputType;

  FullTextField({
    this.title = '',
    this.initialValue = '',
    // required this.onChanged,
    this.onChanged,
    this.icon,
    this.multiLine = 1,
    this.controller,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: (controller == null)
          ? TextFormField(
              initialValue: initialValue,
              keyboardType: inputType,
              // decoration: Style.inputFieldDecorationWithoutLabel(
              //   title: title!,
              // ).copyWith(),
              decoration: InputDecoration().copyWith(
                hintText: title,
              ),
              maxLines: multiLine,
              onChanged: (String text) {
                // onChanged!(text);
              },
              cursorColor: Style.primary,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Style.primary,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w700,
                  ),
            )
          : TextFormField(
              controller: controller,
              keyboardType: inputType,

              // initialValue: initialValue,
              decoration: InputDecoration().copyWith(
                hintText: title,
              ),
              maxLines: multiLine,
              onChanged: (String text) {
                // onChanged(text);
              },
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

class PopupTextField extends StatelessWidget {
  final String title;
  final int? maxLines;
  final TextEditingController? textEditingController;
  final Function? onChanged;
  final String? initialValue;
  final TextInputType inputType;

  const PopupTextField({
    Key? key,
    required this.title,
    this.maxLines,
    this.onChanged,
    this.initialValue = '',
    this.textEditingController,
    this.inputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: (textEditingController == null)
          ? TextFormField(
              maxLines: maxLines ?? 1,
              // controller: textEditingController,
              initialValue: initialValue,
              keyboardType: inputType,
              onChanged: (value) {
                if (onChanged != null) {
                  onChanged!(value);
                }
              },
              style: thisFieldStyle(context),
              decoration: thisFieldDecoration(context, title: title),
            )
          : TextFormField(
              maxLines: maxLines ?? 1,
              keyboardType: inputType,
              controller: textEditingController,
              initialValue: initialValue,
              onChanged: (value) {
                if (onChanged != null) {
                  onChanged!(value);
                }
              },
              style: thisFieldStyle(context),
              decoration: thisFieldDecoration(context, title: title),
            ),
    );
  }

  TextStyle thisFieldStyle(context) =>
      Theme.of(context).textTheme.subtitle1!.copyWith(
            fontSize: 16,
            color: Colors.blueGrey.shade700,
            letterSpacing: 0.6,
            fontWeight: FontWeight.w700,
          );

  InputDecoration thisFieldDecoration(context, {String title = ''}) {
    return InputDecoration(
      filled: true,
      fillColor: Style.primary.withOpacity(0.048),
      labelText: title,
      labelStyle: Theme.of(context).textTheme.caption!.copyWith(
            color: Style.primary.withOpacity(0.87),
          ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black12,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Style.primary.withOpacity(0.60),
          width: 1.6,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
