import 'package:doctor_booking_application/style.dart';
import 'package:flutter/material.dart';

class TitleView extends StatelessWidget {
  final String title;
  final String subtitle;
  // final Function? onPressed;
  final VoidCallback? onPressed;
  TitleView({
    this.title = '',
    this.subtitle = '',
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Style.darkerText.withOpacity(0.87),
                  ),
            ),
          ),
          (subtitle != '')
              ? InkWell(
                  highlightColor: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  onTap: onPressed,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: <Widget>[
                        Text(
                          subtitle,
                          textAlign: TextAlign.left,
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(),
                        ),
                        SizedBox(
                          height: 20,
                          width: 16,
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Style.darkerText,
                            size: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
