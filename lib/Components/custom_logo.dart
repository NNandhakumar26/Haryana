import 'package:flutter/material.dart';

import '../style.dart';

class RoundedLogoCard extends StatelessWidget {
  const RoundedLogoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: CircleBorder(side: BorderSide.none),
      borderOnForeground: true,
      shadowColor: Style.primary.shade100.withOpacity(0.32),
      clipBehavior: Clip.antiAlias,
      color: Style.nearlyWhite,
      child: CircleAvatar(
        maxRadius: 72,
        backgroundColor: Style.nearlyWhite,
        foregroundImage: AssetImage('assets/images/Logo.jpg'),
      ),
    );
  }
}
