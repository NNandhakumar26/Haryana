import 'package:flutter/material.dart';

class CompanyAppbar extends StatelessWidget {
  final String title;
  final double widgetHeight;
  final List<Widget>? actionWidgets;
  CompanyAppbar(
      {required this.title, this.actionWidgets, this.widgetHeight = 150});
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, widgetHeight),
      child: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.87),
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white70,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white.withOpacity(0.87),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
        ),
        actions: actionWidgets,
      ),
    );
  }
}
