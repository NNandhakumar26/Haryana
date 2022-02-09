import 'package:flutter/material.dart';

class DateTimeWidget extends StatelessWidget {
  final Widget widget;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? selectedDate;
  final Function function;

  DateTimeWidget({
    required this.widget,
    this.firstDate,
    this.lastDate,
    required this.selectedDate,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(),
      onPressed: () async {
        await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: firstDate ?? DateTime(1930),
          lastDate: lastDate ?? DateTime(2030),
          builder: (context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Theme.of(context).primaryColor.withOpacity(0.87),
                colorScheme: ColorScheme.light(
                  primary: Theme.of(context).primaryColor.withOpacity(0.87),
                ),
                buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary,
                ),
              ),
              child: child!,
            );
          },
        ).then(
          (value) {
            if (value != null) {
              return function(value);
            }
          },
        );
      },
      child: widget,
    );
  }
}
