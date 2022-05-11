import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 0.24,
      indent: 16,
      endIndent: 16,
      color: Colors.grey.shade400,
    );
  }
}
