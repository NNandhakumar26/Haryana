import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';

class ColumnText extends StatelessWidget {
  final String title;
  final String subtitle;
  ColumnText({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    //make it expanded and constrain the size in the main file from where it's been called...
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Style.lightText.withOpacity(0.60),
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Expanded(
          child: Text(
            subtitle,
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: Style.lightText.withOpacity(0.87),
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }
}
