import 'package:flutter/material.dart';

class RowTextField extends StatelessWidget {
  final String title;
  // final Widget? widget;
  final TextEditingController controller;
  final TextInputType inputType;
  const RowTextField({
    Key? key,
    required this.title,
    required this.controller,
    this.inputType = TextInputType.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Row(
        children: [
          RowLeftTitle(title: title),
          TextFormField(
            controller: controller,
            keyboardType: inputType,
            cursorColor: Theme.of(context).primaryColor,
            onChanged: (String text) {
              // if (int.tryParse(text) != null) {
              //   // controller.otpValue = text;
              // }
            },
            style: thisFieldStyle(context),
            decoration: thisFieldDecoration(context),
          ),
        ],
      ),
    );
  }

  TextStyle thisFieldStyle(context) {
    return Theme.of(context).textTheme.subtitle2!.copyWith(
          fontSize: 16,
          color: Colors.blueGrey.shade700,
          letterSpacing: 0.2,
          fontWeight: FontWeight.w600,
        );
  }

  InputDecoration thisFieldDecoration(context) {
    return InputDecoration(
      filled: true,
      fillColor: Theme.of(context).primaryColor.withOpacity(0.048),
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
          color: Theme.of(context).primaryColor.withOpacity(0.60),
          width: 1.6,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class RowLeftTitle extends StatelessWidget {
  final String title;
  RowLeftTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.subtitle2!.copyWith(
              fontSize: 16,
              color: Colors.blueGrey.shade800,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
